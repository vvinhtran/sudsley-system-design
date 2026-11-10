# Sudsley: A Case-Based System Design Module

Teaching materials for a five-week system design module built around Sudsley, a fictional
"Uber-for-laundry" startup. Students define an MVP, design the system at a high level, design
one service component by component, implement its API handler in TypeScript, and review
example implementations for machine and human cost.

These are the materials described in:

> Vincent Tran, Raymond Klefstad, Susan Anderson Klefstad, and Michael Shindler. 2027.
> Demystifying System Design: A Case-Based Approach for Advanced CS Courses. In *Proceedings of
> the 58th ACM Technical Symposium on Computer Science Education V.1 (SIGCSE TS 2027)*,
> February 17–20, 2027, Sacramento, CA, USA. ACM.
> [doi:10.1145/3857222.3860225](https://doi.org/10.1145/3857222.3860225)

## Contents

| Document | What it is |
|---|---|
| [`INSTRUCTOR.md`](INSTRUCTOR.md) | Pacing, what to expect from students, a shorter variant, and adapting the module to other domains and courses |
| [`scenario/pitch-and-mvp-brief.md`](scenario/pitch-and-mvp-brief.md) | The Sudsley pitch and the CEO's MVP brief |
| [`scenario/high-level-design.md`](scenario/high-level-design.md) | The model high-level design |
| [`framework/component-architecture-questions.md`](framework/component-architecture-questions.md) | The thirteen questions, with the User Service worked example |
| [`assignments/hw1-high-level-design/`](assignments/hw1-high-level-design/) | HW1 handout (`HOMEWORK.md`, collaborative) and an example submission |
| [`assignments/hw2-component-design/`](assignments/hw2-component-design/) | HW2 handout (`HOMEWORK.md`, individual) and an example submission |
| [`assignments/hw3-machine-service/`](assignments/hw3-machine-service/) | HW3 handout (`HOMEWORK.md`) and the TypeScript + Jest starter code |
| [`code-review/engineering-currency.md`](code-review/engineering-currency.md) | Samples A–E and the machine/human currency discussion |
| [`rubrics/grading-rubrics.md`](rubrics/grading-rubrics.md) | One-page grading sketch per assignment |
| [`survey/end-of-module-survey.md`](survey/end-of-module-survey.md) | The end-of-module survey instrument |
| [`slides/`](slides/) | The four lecture decks as PDF, with their Beamer sources |

### Who each part is for

- **Students:** the `HOMEWORK.md` handouts, the
  [grading rubrics](rubrics/grading-rubrics.md), the
  [component architecture questions](framework/component-architecture-questions.md), and
  these, each once its lecture has happened:
  - the [scenario page](scenario/pitch-and-mvp-brief.md), after the MVP discussion in lecture 1
  - the [model high-level design](scenario/high-level-design.md), after HW1
  - lecture 4's slides and the [code review](code-review/engineering-currency.md), after HW3,
    because they contain partial HW3 solutions
- **Instructors:** everything, starting with [`INSTRUCTOR.md`](INSTRUCTOR.md). The example
  submissions end with instructor notes; share the submission part with students if you
  like.

## Using it

`INSTRUCTOR.md` gives the five-week schedule and a shorter variant that keeps the scenario,
the framework, and HW1–HW2 and drops the TypeScript implementation, along with the code review
that depends on it.

For HW3, copy `assignments/hw3-machine-service/` into its own repository and mark it as a
template, or copy it into your course organization. It needs Node.js LTS. As shipped,
`npm install && npm test` runs and most tests fail with "Not implemented" until students
complete `src/handler/api.ts`.

Full solutions are not published here; instructors can request them from the authors (their
emails are in the paper). Note that the code-review samples in `code-review/` and lecture 4
include working implementations of `handleRequestMachine` and `handleGetMachine`.

## Citing

See `CITATION.cff`, or use GitHub's "Cite this repository".

## License

The teaching materials are licensed under [CC BY 4.0](LICENSE). The HW3 starter code is
licensed under [MIT](assignments/hw3-machine-service/LICENSE).
