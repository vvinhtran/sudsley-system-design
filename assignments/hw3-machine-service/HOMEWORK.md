# HW3: Implement the Machine Service

**Individual.** Assigned after lecture 3
([slides](https://github.com/vvinhtran/sudsley-system-design/blob/main/slides/3-component-implementation.pdf)).

## Background

You designed the Machine Service in HW2. This repository is a simulated backend for it, with a
database table, a cache, and clients for the Identity Provider and the Smart Machine API. Your
job is to complete the API handler.

The code is TypeScript. If you haven't used it before, that is intentional: engineers often
contribute to codebases in languages they haven't formally learned. Use the approach from
lecture:

1. **Understand.** Start with the README and set up your environment. Identify the major
   components and trace one simple feature through the code.
2. **Assimilate.** Blend in. Mimic the existing naming, comment style, and structure, and use
   what you already know about programming to read unfamiliar syntax.
3. **Implement.** Make a small, controlled change first, then build up.
4. **Verify.** Run the test suite to prove your change works and that nothing else broke.

## What to do

Complete the `ApiHandler` class in `src/handler/api.ts`. Each method's doc comment describes
what it must do, and `test/api.test.ts` checks it.

- `checkToken`: reject invalid tokens using the Identity Provider.
- `handleRequestMachine`: reserve an available machine at a location for a job.
- `handleGetMachine`: return a machine's state, checking the cache before the database.
- `handleStartMachine`: start a reserved machine's cycle through the Smart Machine API and
  handle hardware errors.

The Smart Machine client in `src/external/smart-machine.ts` is the code version of the API from
the scenario. It offers `getStatus`, `startCycle`, and `forceStop` (the scenario's
`stopCycle()`). A hardware fault shows up as `startCycle` throwing an error; the tests and the
simulation inject such faults.

Run `./setup.sh` once, then `npm test`. Until you implement the handler, most tests fail with
"Not implemented". (On Windows without bash, run `npm install` and `npm test` instead of
`./setup.sh`.)

The simulation test (`test/simulation.test.ts`) runs 10,000 requests against your handler,
four times, and prints three tables. Units stand in for computing cost; the cost of each
operation is in `src/simulation/units.ts`.

1. **Units by resource:** how many units each part of the system consumed in each run, and its
   share of the total. The last row, `TOTAL`, is the number to compare and to reduce.
2. **Cache:** hits, misses, and hit rate for each run.
3. **Cache hits vs. database accesses:** cache hits divided by database calls. Higher means
   the cache is saving more database work.

## What to submit

1. All source code, as your instructor directs (for example a link to your repository).
2. A report (PDF) with a screenshot of the three tables and a short analysis. The runs differ
   only by chance, so discuss them together: which resource costs the most and why, and one
   change that would reduce your total.

## Grading

See the [rubric sketch](https://github.com/vvinhtran/sudsley-system-design/blob/main/rubrics/grading-rubrics.md#hw3-machine-service).
