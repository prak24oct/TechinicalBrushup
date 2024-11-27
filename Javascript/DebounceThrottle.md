### Debounce and Throttle

Debouncing and throttling are two techniques used in programming, particularly for managing the rate of function execution, which is especially useful when working with event listeners (e.g., mouse movements, scrolling, or keypresses).

1. **Debounce**: 
   - Debouncing ensures that a function is executed only once after a specified time has passed since the last call.
   - It is used when you want to wait for a burst of activity to stop before taking action. For example, if you have an input field where the user types rapidly, you can debounce the action to wait until the user stops typing before executing a function like a search or validation.
   
   **Example:**
   - A function that triggers when a user stops typing after 500ms, preventing unnecessary calls to an API or other actions while they are still typing.

2. **Throttle**:
   - Throttling ensures that a function is executed at most once in a specified time period, even if it is triggered multiple times. 
   - It is useful when you want to limit the number of times a function can be called over time, such as when handling events like scroll or resize, where the event might trigger many times within a short period.
   
   **Example:**
   - A function that is executed at most once every 200ms, regardless of how many times the user scrolls in that time.

### Polyfill Implementation

#### 1. **Debounce Polyfill**

The debounce function delays the execution of the given function until after the specified wait time has passed since the last time it was called.

```javascript
function debounce(fn, delay) {
    let timer;
    return function(...args) {
        clearTimeout(timer);
        timer = setTimeout(() => {
            fn.apply(this, args);
        }, delay);
    };
}

// Example usage:
const handleSearch = debounce(function() {
    console.log("Searching...");
}, 500);

// Simulate rapid calls (user typing)
handleSearch();
handleSearch();
handleSearch();
```

In the above implementation:
- `debounce` returns a function that clears the previous `setTimeout` and sets a new one with the specified delay.
- The `fn` function is only called once after `delay` milliseconds have passed since the last call.

#### 2. **Throttle Polyfill**

The throttle function ensures the given function is executed at most once in the specified time period (i.e., it enforces a rate limit).

```javascript
function throttle(fn, limit) {
    let lastTime = 0;
    return function(...args) {
        const now = new Date().getTime();
        if (now - lastTime >= limit) {
            fn.apply(this, args);
            lastTime = now;
        }
    };
}

// Example usage:
const handleScroll = throttle(function() {
    console.log("Scroll event triggered");
}, 200);

// Simulate rapid scroll events
window.addEventListener("scroll", handleScroll);
```

In the above implementation:
- The `throttle` function checks if enough time (`limit`) has passed since the last execution. If so, it runs the function and updates `lastTime` to the current time.
- This ensures the function does not execute more than once within the `limit` interval.

### Key Differences between Debounce and Throttle:
- **Debounce** delays the execution of a function until after a specific time period has passed since the last call (i.e., it waits for silence or inactivity).
- **Throttle** enforces a maximum execution frequency, ensuring that a function is executed at most once per specified time interval.

### Example Scenario:
- **Debounce**: User is typing in a search box and you only want to send a request to the server after they stop typing for 500ms.
- **Throttle**: User is scrolling through a page and you want to limit the number of times a function (e.g., infinite scrolling or analytics tracking) is triggered, so it happens no more than once every 200ms.

Both techniques help optimize performance by reducing unnecessary function calls, especially in cases of high-frequency events like `scroll`, `resize`, or `input` events.