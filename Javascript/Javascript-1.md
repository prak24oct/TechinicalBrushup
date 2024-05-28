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
    

## 2. What is Event loop in javascript and how it works under the hood ?

The event loop in JavaScript is a crucial mechanism that allows JavaScript to handle asynchronous operations despite being single-threaded. This means that JavaScript can perform non-blocking operations, enabling it to handle multiple tasks simultaneously without halting the execution of the main program.

### Understanding the Event Loop

#### 1. **JavaScript Runtime Components**
To comprehend how the event loop works, we need to understand the components involved in the JavaScript runtime environment:

- **Call Stack**: The call stack is where JavaScript keeps track of the execution context. It operates on a Last-In-First-Out (LIFO) basis. Whenever a function is called, it is pushed onto the call stack, and when the function completes, it is popped off the stack.

- **Web APIs**: Provided by the browser (or Node.js in server-side JavaScript), these are APIs that allow for asynchronous operations such as `setTimeout`, `HTTP requests`, and DOM events.

- **Callback Queue (Task Queue)**: This is a queue that holds callback functions that are ready to be executed. These callbacks are moved here after their associated asynchronous operations are completed.

- **Microtask Queue**: Similar to the callback queue, but it holds microtasks such as promises. Microtasks have a higher priority than macrotasks (tasks in the callback queue).

- **Event Loop**: The event loop is a process that continuously checks the call stack and the callback queue, ensuring that tasks are executed in the correct order.

#### 2. **How the Event Loop Works**

Here's a detailed explanation of how the event loop operates under the hood:

1. **Execution Starts**: JavaScript begins executing code from the top of the file, pushing functions onto the call stack.

2. **Web API Calls**: When asynchronous functions (like `setTimeout`, `fetch`, or event listeners) are called, they are handed over to the Web APIs, and the main thread continues execution without waiting for these operations to complete.

3. **Task Completion**: Once a Web API completes its operation (e.g., a timer expires or a fetch request completes), it pushes the corresponding callback function to the callback queue.

4. **Microtasks Processing**: Before processing the tasks in the callback queue, the event loop processes all the tasks in the microtask queue. Microtasks, such as promise callbacks, are given priority and executed first.

5. **Event Loop Check**: The event loop continuously monitors the call stack. If the call stack is empty (i.e., no other synchronous code is being executed), it checks the callback queue.

6. **Callback Execution**: If there are functions in the callback queue and the call stack is empty, the event loop transfers these functions from the callback queue to the call stack for execution.

7. **Repeat**: This process repeats, ensuring smooth and non-blocking execution of both synchronous and asynchronous code.

### Example to Illustrate the Event Loop

Here’s an example to demonstrate the event loop's behavior:

```javascript
console.log('Start');  // 1. Executes immediately, logs "Start"

setTimeout(() => {
  console.log('Timeout Callback');  // 5. Executes after 1 second, logs "Timeout Callback"
}, 1000);

Promise.resolve().then(() => {
  console.log('Promise Callback');  // 4. Executes before the timeout callback, logs "Promise Callback"
});

console.log('End');  // 2. Executes immediately, logs "End"

// 3. Call stack is empty, microtasks queue is processed next.
```

**Execution Flow**:
1. `console.log('Start')` is called and executed immediately.
2. `setTimeout` is called, and the timer is set up in the Web API environment.
3. `Promise.resolve().then(...)` is called, and its callback is queued in the microtask queue.
4. `console.log('End')` is called and executed immediately.
5. The main script execution is done, so the event loop checks the microtask queue first, finding the promise callback and executing it (`console.log('Promise Callback')`).
6. After all microtasks are processed, the event loop checks the callback queue. Once the 1-second timer completes, the callback (`console.log('Timeout Callback')`) is moved to the call stack and executed.

### Important Points

- **Single Threaded**: JavaScript's single-threaded nature means it can execute one operation at a time in the main execution thread.
- **Non-blocking I/O**: Asynchronous operations ensure that the main thread is not blocked, allowing other code to run while waiting for long-running tasks to complete.
- **Microtasks vs. Macrotasks**: Microtasks (like promise callbacks) are processed before macrotasks (like `setTimeout` callbacks) in the event loop.

Understanding the event loop is crucial for writing efficient asynchronous JavaScript code, allowing developers to handle tasks without blocking the main thread and improving the performance and responsiveness of web applications.
