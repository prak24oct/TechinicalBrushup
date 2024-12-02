### Learning Notes for Constructor and Prototype in JavaScript

---

#### **1. Adding Methods to Constructor Instances**
To add a method like `getFullName` to all instances of a constructor function, you can define it on the function's prototype. This approach ensures that the method is shared across all instances rather than being duplicated for every object created. For example:  

```javascript
function Person(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
}
Person.prototype.getFullName = function () {
  return `${this.firstName} ${this.lastName}`;
};
const member = new Person("Lydia", "Hallie");
console.log(member.getFullName()); // Output: "Lydia Hallie"
```

When you call `getFullName`, JavaScript looks up the prototype chain and uses the shared method, saving memory and ensuring consistent behavior.

---

#### **2. Constructor Function Behavior with and Without `new`**
When you call a constructor function with the `new` keyword, it creates a new object, assigns it to `this`, initializes the object’s properties, and returns the object. Without `new`, the function behaves like a regular function, and `this` refers to the global object in non-strict mode or becomes `undefined` in strict mode. For example:

```javascript
function Person(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
}
const lydia = new Person("Lydia", "Hallie"); // Correct
const sarah = Person("Sarah", "Smith");     // Incorrect
console.log(lydia); // Person { firstName: 'Lydia', lastName: 'Hallie' }
console.log(sarah); // undefined or error in strict mode
```

This difference makes it essential to always use `new` with constructor functions.

---

#### **3. Enforcing the Use of `new`**
To ensure that a constructor function is always called with the `new` keyword, you can add a check inside the function. If the function is called without `new`, it throws an error to prevent unintended behavior. For example:

```javascript
function Person(firstName, lastName) {
  if (!(this instanceof Person)) {
    throw new Error("Person must be called with 'new'");
  }
  this.firstName = firstName;
  this.lastName = lastName;
}
const lydia = new Person("Lydia", "Hallie"); // Works fine
const sarah = Person("Sarah", "Smith");     // Throws an error
```

This safeguard ensures that the function is always used correctly, avoiding unpredictable behavior.
