# Grading rubric sketches

Each assignment counted for one third of the module grade. These sketches describe what was
graded. Adjust the weights to your course.

## HW1: High-level design

Graded on content. Diagram format and notation are not graded.

| Criterion | Full credit |
|---|---|
| System description | A coherent description, at most half a page, of how the system operates that covers the MVP brief. |
| Diagram | A readable diagram that represents the major components (clients, backend services, external services) and how they interact. |

A representative description and diagram earn full credit. No design is correct or incorrect.

## HW2: Component-level design

Graded on coverage of the framework, with attention to internal consistency, since later
answers build on earlier ones.

| Criterion | Full credit |
|---|---|
| Coverage | All thirteen questions answered for the Machine Service, each with a justification. |
| Consistency | Answers agree with each other, for example the caching decision follows from the read/write ratio and the scaling strategy from statelessness. |
| Diagram | A rough component diagram that matches the written answers. |

## HW3: Machine Service

Graded on unit-test correctness. The report was required; set its weight to suit your course.
Efficiency was measured and reported back to students but did not affect the grade.

| Criterion | Full credit |
|---|---|
| Correctness | The provided unit tests in `test/api.test.ts` pass. |
| Report | A PDF with a screenshot of the simulation's performance statistics and a short analysis. |
| Efficiency (feedback only) | Total units from `test/simulation.test.ts`, returned to students for comparison and discussed in lecture 4. |
