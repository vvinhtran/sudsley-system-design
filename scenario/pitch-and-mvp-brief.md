# The Sudsley scenario

*Instructors: this page ends with the CEO's MVP brief. Share it after the MVP discussion in
lecture 1; from then on it is the students' reference for HW1.*

Students join the founding engineering team of Sudsley, a startup building an
"Uber-for-laundry" service. The same product carries every stage of the module, from
requirements through design to code.

Lecture 1 (`slides/1-introduction.pdf`) presents this scenario; this page gives the same
material in prose.

## The problems Sudsley solves

1. **Wasted time.** Customers travel to and wait at the laundromat, unsure when their machine
   will be done.
2. **Inconvenience.** Machines are occupied, forcing customers to wait or come back later.
3. **Forgotten clothes.** Clothes are often left in machines long after the cycle finishes.

## The secret weapon: the smart laundry machine

At the heart of Sudsley is a proprietary, next-generation washer and dryer. Every machine is
internet-enabled and has an integrated API for remote control and monitoring:

- `startCycle()`
- `stopCycle()`
- `getStatus()`: available, running, finished, time remaining, needs maintenance

## Your job

1. Explore product options and suggest ideas.
2. Design the product.
3. Implement the core components.

## The product

Students first discuss in groups what software Sudsley should build and why. Then the CEO and
product managers settle on an idea: UberEats, Postmates, or DoorDash, but for laundry.

1. A customer puts their laundry out on their front porch.
2. They open an app to request a launderer.
3. The launderer picks up the clothes and takes them to a Sudsley location.
4. The launderer puts the laundry in a machine.
5. The app keeps the customer up to date on the status of their clothes.
6. The launderer delivers the clothes back once they are finished.
7. The launderer gets a portion of the job revenue.

## Defining the MVP

A Minimum Viable Product is an early version of a product with just enough features to be
functional. When defining one:

- Identify the must-have features.
- Avoid unnecessary work.
- Expect feedback from early users. This is not the forever-system.

In groups, students define a rough MVP for the alpha version of Sudsley and debate what
belongs in it, such as whether real-time tracking or in-app payment is essential.

## The MVP brief

*Instructors: hand this out after the group discussion above, not before.*

After the discussion, the instructor presents the MVP as mandated by the CEO. Engineers often
receive requirements they did not write.

- Assume about 10,000 initial customers.
- Customers can request a laundry job.
- Launderers can accept a laundry job.
- Launderers know which machine to put the clothes in.
- Customers know where their clothes are geographically.
- Customers know the status of their laundry job.
- Customers pay through the app.
- Launderers get paid through the app.
- Customers can rate their laundry job.
- Basic statistics and telemetry.

The brief feeds [HW1](../assignments/hw1-high-level-design/HOMEWORK.md).
