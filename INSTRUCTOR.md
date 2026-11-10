# Instructor guide

## Where this ran

The module ran in the second half of a ten-week term in an advanced programming and
problem-solving course in a professional master's program. Students chose C++, Java, or Python
for the rest of the course; none used TypeScript elsewhere. About half rated their prior system
design and TypeScript experience at 2 or lower out of 5.

## Schedule

Five weeks: four one-hour lectures with an assignment between each pair. Each assignment
counted for one third of the module grade.

| # | Lecture | Then assign |
|---|---|---|
| 1 | **Introduction.** The Sudsley scenario, product ideas in groups, defining the MVP in groups, then the CEO's MVP brief and an introduction to high-level design. | [HW1](assignments/hw1-high-level-design/HOMEWORK.md) (collaborative) |
| 2 | **High-level and component design.** Reveal the [model high-level design](scenario/high-level-design.md) progressively, then work through the [thirteen questions](framework/component-architecture-questions.md) on the User Service, reasoning aloud. | [HW2](assignments/hw2-component-design/HOMEWORK.md) (individual, collaboration permitted) |
| 3 | **Component implementation.** How to approach an unfamiliar codebase: understand, assimilate, implement, verify. | [HW3](assignments/hw3-machine-service/HOMEWORK.md) (individual) |
| 4 | **Code review and analysis.** [Engineering currency](code-review/engineering-currency.md), reviewing example HW3 implementations. | |

Each lecture's slides are in [`slides/`](slides/).

## Running each stage

- **MVP discussion.** Let groups argue before showing the brief, for example over whether
  real-time tracking or in-app payment is essential. The brief is presented as the CEO's
  decision on purpose: engineers often build to requirements they did not write.
- **High-level design reveal.** Ask students to predict each next element (clients, then
  backend services, then external services) before you show it.
- **Worked example.** Think aloud through every question for the User Service, including the
  tradeoffs you reject. HW2 is graded partly on whether answers agree with each other, so show
  how one answer constrains the next.
- **HW3.** Expect questions about TypeScript syntax. The unfamiliar language is deliberate, so
  point students to the four-step approach rather than a syntax primer.
- **Code review.** Collect anonymized snippets from HW3 submissions and pick ones that each
  teach one lesson. The provided samples work if you have none. They contain parts of a
  working HW3 solution, so don't share them before HW3 is due.
- **Know the simulation's cost model before lecture 4.** Every request pays a 128-unit token
  check, and every `getInstance()` call on the table or an external client pays a 256-unit
  connection, so where students fetch instances matters more than anything else they do.
  Cache hits are free; only misses are charged. Machines are never released, so after about
  100 reservations most machine requests return `NOT_FOUND`, and the hardware-error path runs
  rarely. Totals are best compared between students rather than against the lecture's
  illustrative dollar figures.

## What students found hard

From the end-of-module survey (`survey/`):

- Two items drew below-average agreement: that completing HW3's handler was easy (59%), and
  that creating HW1's diagram improved students' ability to visualize components (76%).
- Several students felt five weeks was compressed and suggested starting the module earlier
  in the term.
- Some asked for an efficiency leaderboard or a pre-built frontend to make HW3 results more
  tangible.
- Asked what to design instead of Sudsley, students suggested familiar consumer apps (video
  streaming, food delivery, social media, shopping) and campus problems (class registration,
  an on-campus vending service).

## A shorter version

Keep the scenario, the thirteen questions, HW1, and HW2, and drop the TypeScript
implementation. The code-review lecture goes with it, since it reviews HW3 code.

## Adapting the module

The module ran once, in one course, so treat this section as suggestions rather than tested
results.

### What carries over unchanged

- The thirteen component architecture questions. Nothing in them is about laundry.
- The four-step approach to an unfamiliar codebase: understand, assimilate, implement, verify.
- Machine and human currency as the lens for code review.
- The arc itself: requirements, then high-level design, then one component, then code, then
  review, all on one product.

### What a new scenario needs

To replace Sudsley, rebuild the pitch and MVP brief, the model high-level design, the worked
example, and, the expensive part, the HW3 starter code. A good replacement:

- **is familiar to students.** They should understand the product without a tutorial. In the
  survey, students asked for familiar consumer apps and campus problems.
- **has several services with distinct jobs,** so the high-level design has something to
  decompose.
- **has one service that controls a black box** through an API, as the Machine Service
  controls the smart machines. That service becomes HW2 and HW3, and its failure modes give
  the code review material.
- **has a stated MVP scale,** like Sudsley's 10,000 customers, so capacity estimates have
  something to work from.

### Example domains

The "black box" column names the service that would play the Machine Service's role.

| Domain | Black box | What it adds |
|---|---|---|
| EV charging network | Charger API: start, stop, status, faults | The closest one-to-one analog to Sudsley |
| Bike or scooter share | Smart lock and GPS | Real-time location, rebalancing across stations |
| Campus smart lockers (food or package pickup) | Locker API: assign, open, status | A small, local scale students know first-hand |
| Library or campus printing | Printer queue and status API | Queues, retries, and jams as hardware errors |
| Parking reservations | Gate and occupancy sensors | Overbooking and strong consistency |
| Class registration | None; pure software | Burst traffic and waitlist consistency. HW3 needs a new starter. |
| Video streaming | Transcoding service and CDN | Larger scale and caching; suits more experienced classes |

### Other course contexts

- **Upper-division undergraduate courses** can use the module as is; nothing depends on
  graduate prerequisites.
- **Capstone courses** can run real client projects through the same arc (requirements,
  high-level design, component design, code, review) and use the thirteen questions as a
  design-review checklist.
- **The implementation language** matters less than its unfamiliarity. The point of HW3 is
  entering a codebase in a language students have not learned, so port the starter to a
  language your students don't already use rather than the one they know best.
- **AI policies.** Where AI tools are allowed, make the code review the place students defend
  their design reasoning. Where they are banned, HW3 becomes a sharper test of working in an
  unfamiliar language.

## Solutions

Full HW3 solutions are not published; instructors can request them from the authors, whose
emails are in the paper. The code-review samples include working implementations of
`handleRequestMachine` and `handleGetMachine`, so treat lecture 4's materials as partial
solutions.
