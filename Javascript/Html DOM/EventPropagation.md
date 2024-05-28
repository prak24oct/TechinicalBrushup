# Event propagation
Event propagation in JavaScript is a key concept that describes how events travel through the DOM. It includes three main phases: capturing, target, and bubbling. Let's delve deeper into each of these phases and related concepts:

### Event Propagation Phases

#### 1. Capturing Phase (Event Capturing)
- **Definition**: The event starts from the root of the DOM tree and propagates downwards to the target element.
- **Behavior**: During this phase, events are first captured by the outermost elements and then propagate down to the innermost element (the target).
- **Usage**: Capturing can be useful for intercepting events before they reach the target, often for logging, analytics, or special handling before the event bubbles up.

Example:
```javascript
document.getElementById('parent').addEventListener('click', function() {
  console.log('Parent capturing');
}, true); // The third parameter `true` enables capturing
```

#### 2. Target Phase
- **Definition**: The event has reached the target element, and the event listeners on the target element are triggered.
- **Behavior**: The target phase does not involve propagation; it’s simply the phase where the event reaches the target element and its event listeners are executed.

Example:
```javascript
document.getElementById('target').addEventListener('click', function() {
  console.log('Target element');
});
```

#### 3. Bubbling Phase (Event Bubbling)
- **Definition**: The event starts from the target element and propagates upwards to the root of the DOM tree.
- **Behavior**: During this phase, events bubble up from the innermost element (the target) to the outermost elements. This allows ancestor elements to listen for events fired by their descendants.
- **Usage**: Event bubbling is commonly used for event delegation, where a single event listener on a parent element can handle events from multiple child elements.

Example:
```javascript
document.getElementById('parent').addEventListener('click', function() {
  console.log('Parent bubbling');
}, false); // The third parameter `false` (or omitted) enables bubbling
```

### Stopping Event Propagation

#### 1. `event.stopPropagation()`
- **Purpose**: Stops the event from propagating further in both capturing and bubbling phases.
- **Usage**: This method is used when you want to prevent any parent elements from receiving the event.

Example:
```javascript
document.getElementById('target').addEventListener('click', function(event) {
  event.stopPropagation();
  console.log('Propagation stopped');
});
```

#### 2. `event.stopImmediatePropagation()`
- **Purpose**: Stops the event from propagating and also prevents other event listeners on the same element from being executed.
- **Usage**: This method is used when you want to ensure no other event listeners (both capturing and bubbling) are triggered on the same element.

Example:
```javascript
document.getElementById('target').addEventListener('click', function(event) {
  event.stopImmediatePropagation();
  console.log('Immediate propagation stopped');
});
```

### Preventing Default Actions

#### `event.preventDefault()`
- **Purpose**: Prevents the default action associated with the event (e.g., following a link, submitting a form).
- **Usage**: This method is used when you want to override the default behavior of an element in response to an event.

Example:
```javascript
document.getElementById('link').addEventListener('click', function(event) {
  event.preventDefault(); // Prevents the link from being followed
  console.log('Default action prevented');
});
```

### Event Delegation
- **Concept**: Attaching a single event listener to a parent element to manage events from multiple child elements.
- **Benefits**: Improves performance by reducing the number of event listeners and is useful for dynamically added elements.
- **Implementation**: Use event.target to determine which child element triggered the event and take appropriate action.

Example:
```javascript
document.getElementById('parent').addEventListener('click', function(event) {
  if (event.target.matches('.child')) {
    console.log('Child element clicked');
  }
});
```

### Example with Event Propagation

Let's put everything together in a practical example to demonstrate event propagation:

HTML:
```html
<div id="grandparent">
  <div id="parent">
    <div id="child">Click me</div>
  </div>
</div>
```

JavaScript:
```javascript
// Capturing phase (third parameter is true)
document.getElementById('grandparent').addEventListener('click', function() {
  console.log('Grandparent capturing');
}, true);

document.getElementById('parent').addEventListener('click', function() {
  console.log('Parent capturing');
}, true);

// Target phase (implicitly handled)
document.getElementById('child').addEventListener('click', function(event) {
  console.log('Child target');
  // Uncomment to stop propagation
  // event.stopPropagation();
  // Uncomment to stop immediate propagation
  // event.stopImmediatePropagation();
  // Uncomment to prevent default action
  // event.preventDefault();
});

// Bubbling phase (third parameter is false or omitted)
document.getElementById('parent').addEventListener('click', function() {
  console.log('Parent bubbling');
});

document.getElementById('grandparent').addEventListener('click', function() {
  console.log('Grandparent bubbling');
});
```

When the "child" element is clicked, the output will demonstrate the phases of event propagation:
```
Grandparent capturing
Parent capturing
Child target
Parent bubbling
Grandparent bubbling
```

By understanding and utilizing event propagation, you can create more efficient and manageable event handling in your web applications.