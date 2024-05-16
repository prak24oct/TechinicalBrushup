# Javascript Basics - Part 1

## 1. What are micro and macro task in javascript ?
- ### Microtasks:
    - Microtasks are tasks with hight priority.
    - It executes asap after current script block ends and before the next event loop cycle.
    - Ex- Promises callbacks ( `then`, `catch` and `finally`)
    - Mutation Observer callbacks, and process.nextTick in Node.js
    - Executed in single queue , ensures the execution in order they are added.
    - Used for short, high-priority tasks , need to be completed before the next __macrotask__ can execute.

- ### Macrotasks:
    - Macrotasks are also knows as `tasks` or `callbacks`
    - Have a lower priority than microtasks.
    - Ex- setTimeOut, setInterva, I/O operations, UI rendering and user input events.
    - Macrotaks are executed in `FIFO` order
    - Macrotasks may be delayed if the call stacks is not empty when they are schedules to run. 


