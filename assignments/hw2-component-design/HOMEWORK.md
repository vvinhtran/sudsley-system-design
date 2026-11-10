# HW2: Component-level design of the Machine Service

**Individual; collaboration permitted.** Assigned after lecture 2
(`slides/2-high-level-and-component-design.pdf`).

## Background

In class we reviewed the [Sudsley high-level design](../../scenario/high-level-design.md) and
worked through the [component architecture questions](../../framework/component-architecture-questions.md) for the User
Service. Now apply the same process to a different component.

The **Machine Service** finds available machines at Sudsley locations and remotely starts and
monitors laundry cycles. It talks to the Smart Machine API, which offers `startCycle()`,
`stopCycle()`, and `getStatus()`. You will implement this service in HW3.

## What to submit

Draft a component-level design for the Machine Service:

1. Review the finished high-level design. Note which services call the Machine Service and
   what it depends on.
2. Answer all thirteen component architecture questions for the Machine Service. Give a short
   justification for each answer, as in the User Service example. Later answers should agree
   with earlier ones.
3. Create a rough design diagram of the component. [Mermaid](https://mermaid.js.org/) is a
   useful tool for this.

Submit your answers and diagram as one PDF.

## Grading

See the [rubric sketch](../../rubrics/grading-rubrics.md#hw2-component-level-design).
