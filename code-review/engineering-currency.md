# Code review: engineering currency

Lecture 4 (`slides/4-code-review-and-analysis.pdf`) closes the module by reviewing example
implementations of the HW3 handler. Each sample shows one lesson about what code costs.

These samples contain working implementations of parts of HW3. Hold this lecture until after
HW3 is due.

## Two kinds of currency

1. **Machine currency, the "real" cost:** CPU cycles, memory, database I/O, and network calls.
   In industry, efficiency is money.
2. **Human currency, the "cognitive" cost:** readability, maintainability, and time to
   understand. Code is read far more often than it is written.
   - Time to understand (TTU) and mean time to repair (MTTR) move together: code that is slow
     to understand is slow to fix.
   - Picture 3:00 AM with production down. Complex code can mean hours to fix, lost revenue,
     and escalation; clean code can mean a fix in minutes that customers never notice. (The
     lecture gives illustrative figures: two hours or more against under ten minutes.)

### From units to dollars

In HW3, efficiency is measured in units (`src/simulation/units.ts`). In the real world units
become a computing bill. The figures below are illustrative, for intuition only; they are not
totals from this simulation.

Suppose 1 unit = $0.0001, over 10,000 requests:

| | Units | Cost per 10k requests | At 1M users (100× the requests), against a $10k/month budget |
|---|---|---|---|
| Implementation X | 1.5 million | $150.00 | $15k/month: over budget, bankruptcy |
| Implementation Y | 140k | $14.00 | $1.4k/month: well under budget, profit |

In the shipped simulation, every request also pays a 128-unit token check, and every
`getInstance()` call on the database table or an external client pays a 256-unit connection.
Real totals therefore run well above these figures, above a million units even for a lean
handler. Compare students' totals with each other rather than with this table.

## Sample A: re-reading what you just wrote

```ts
private handleRequestMachine(request: RequestMachineRequestModel): MachineResponseModel {
    const table = MachineStateTable.getInstance();
    const machines = table.listMachinesAtLocation(request.locationId);
    const available = machines.find(m => m.status === MachineStatus.AVAILABLE);
    if (!available) {
        return { statusCode: HttpResponseCode.NOT_FOUND, machine: undefined };
    }
    table.updateMachineJobId(available.machineId, request.jobId);
    table.updateMachineStatus(available.machineId, MachineStatus.AWAITING_DROPOFF);
    const updated = table.getMachine(available.machineId)!;
    this.cache.put(updated.machineId, updated);
    return { statusCode: HttpResponseCode.OK, machine: updated };
}
```

This updates the database, then immediately queries it again: an unnecessary read. It happens
when the programmer lacks confidence in local state and wants to be "sure" they have the
latest data.

## Sample B: building the result in memory

```ts
private handleRequestMachine(request: RequestMachineRequestModel): MachineResponseModel {
    const table = MachineStateTable.getInstance();
    const machines = table.listMachinesAtLocation(request.locationId);
    var available = machines.find(m => m.status === MachineStatus.AVAILABLE);
    if (!available) {
        return { statusCode: HttpResponseCode.NOT_FOUND, machine: undefined };
    }
    const updatedMachine = {
        machineId: available.machineId,
        locationId: available.locationId,
        currentJobId: request.jobId,
        status: MachineStatus.AWAITING_DROPOFF
    }
    table.updateMachineStatus(updatedMachine.machineId, updatedMachine.status);
    table.updateMachineJobId(updatedMachine.machineId, updatedMachine.currentJobId);
    this.cache.put(updatedMachine.machineId, updatedMachine);
    return { statusCode: HttpResponseCode.OK, machine: updatedMachine };
}
```

This constructs the updated item in memory, which costs nothing. **Takeaway:** if you own the
data transformation, don't pay the database to repeat back what you just did.

A human-currency aside: B declares `available` with `var`. In modern TypeScript `const` is the
default for a value that never changes, and `let` for one that does; `var` makes the reader
check whether it is reassigned anywhere.

| Operation | A (re-read) | B (in memory) |
|---|---|---|
| List machines | 8 | 8 |
| Update status | 15 | 15 |
| Update job | 12 | 12 |
| Get result | 8 (database read) | 0 (memory) |
| Cache put | 6 | 6 |
| **Total units** | **49** | **41** |

The table counts only the handler's database and cache work. Both samples also pay the same
connection and token-check charges on every request, which are left out. Re-reading adds 8
units, about 20% more database and cache work than B.

### Two requests, one machine

Samples A and B both read the list of machines, pick an available one, then write to it. If
two requests for the same location arrive together, both can pick the same machine and both
reserve it. Ask students how they would prevent that: a conditional write that only succeeds
if the machine is still `AVAILABLE` (compare-and-set), a lock, or a transaction.

## Sample C: cache lookaside

```ts
private handleGetMachine(request: GetMachineRequestModel): MachineResponseModel {
    const table = MachineStateTable.getInstance();
    const cached = this.cache.get(request.machineId);
    if (cached) return { statusCode: HttpResponseCode.OK, machine: cached };
    const doc = table.getMachine(request.machineId);
    if (!doc) return { statusCode: HttpResponseCode.NOT_FOUND };
    this.cache.put(request.machineId, doc);
    return { statusCode: HttpResponseCode.OK, machine: doc };
}
```

This is good code.

- **Machine currency.** It checks the cache first and skips the database on a hit. Counting
  only cache and database operations, a hit costs 0 units and a miss costs 18 (a 4-unit cache
  miss, an 8-unit database read, and a 6-unit cache write), while reading the database
  directly costs 8. Caching pays off only when most reads hit: above about a 56% hit rate. At
  50%, 10k calls cost 90k units with the cache against 80k without it. Ask students what hit
  rate their own simulation run reported.
- **A hidden cost.** `MachineStateTable.getInstance()` charges a 256-unit connection on every
  call, and here it runs before the cache check, so even a hit pays it. Getting the table only
  on a miss, or once in the constructor as the handler already does with the cache, saves far
  more than any other change in this lecture.
- **Human currency.** The return-early pattern keeps it readable and avoids deep nesting.

## Sample D: extra work in the error path

```ts
private handleStartMachine(request: StartMachineRequestModel): MachineResponseModel {
    // ... [Validation logic omitted] ...
    const smartMachine = SmartMachineClient.getInstance();
    try {
        smartMachine.startCycle(request.machineId);
        // ... [Success logic omitted] ...
    }
    catch (err) {
        db.updateMachineStatus(request.machineId, MachineStatus.ERROR);
        machine = db.getMachine(request.machineId);
        if (machine) {
            this.cache.put(request.machineId, machine);
        }
        return {statusCode: HttpResponseCode.HARDWARE_ERROR, machine};
    }
}
```

On a hardware failure, control jumps to the `catch`. Writing the `ERROR` status is necessary,
but re-reading the machine afterwards is the same unnecessary read as Sample A, now on the
path that is already failing. Work added to an error path slows every error response.

The bigger questions on this path are about correctness rather than cost. Is the machine left
half-started, and should the handler call `forceStop`? Should the call be retried, and after
what timeout?

## Sample E: idiomatic code that hides a cost

```ts
private handleRequestMachine(request: RequestMachineRequestModel): MachineResponseModel {
    const db = MachineStateTable.getInstance();
    const availableMachines = db.listMachinesAtLocation(request.locationId)
        .filter(m => m.status === MachineStatus.AVAILABLE);
    if (availableMachines.length === 0) {
        return { statusCode: HttpResponseCode.NOT_FOUND };
    }
    const machine = availableMachines[0];
    // ... [Update logic omitted] ...
}
```

This looks clean but hides an efficiency flaw. `.filter(...)` walks the entire array, so at a
location with 1,000 machines it checks all of them even though only the first match is used.
`.filter(...)` always does N checks; `.find(...)` stops at the first match. Both are O(N) in the
worst case, but `.find(...)` exits early whenever an available machine comes first. (A real
database would do better still by filtering in the query and returning one row.)

**Takeaways.** Once the logic works, check it briefly for efficiency. In an unfamiliar
language or codebase, convenient-looking constructs are sometimes traps: verify they do what
you think, and look up (or ask an AI) whether there is a better way.
