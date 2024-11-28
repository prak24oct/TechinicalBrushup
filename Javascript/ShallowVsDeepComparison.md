### Deep vs. Shallow Comparison in JavaScript

**Shallow Comparison**:
- In a shallow comparison, only the first level of the objects is compared.
- If the objects contain nested objects, the references to those nested objects are compared rather than their values.
- This means that nested objects are not compared deeply.

**Deep Comparison**:
- In a deep comparison, all levels of the objects are recursively compared.
- This means that nested objects and arrays are also compared by value, rather than by reference.

### Shallow Comparison Polyfill
In a shallow comparison, we check if the keys and values of two objects are the same at the top level.

```javascript
function shallowEqual(obj1, obj2) {
  if (obj1 === obj2) return true; // If both are the same reference, return true
  if (typeof obj1 !== 'object' || obj1 === null || typeof obj2 !== 'object' || obj2 === null) {
    return false; // If either is not an object or is null, return false
  }
  
  const keys1 = Object.keys(obj1);
  const keys2 = Object.keys(obj2);
  
  if (keys1.length !== keys2.length) return false; // If number of keys are different
  
  // Check if values of the same keys are equal
  for (let key of keys1) {
    if (obj1[key] !== obj2[key]) {
      return false;
    }
  }
  
  return true;
}
```

### Deep Comparison Polyfill
In a deep comparison, we recursively compare all properties, including nested objects and arrays.

```javascript
function deepEqual(obj1, obj2) {
  if (obj1 === obj2) return true; // If both are the same reference or primitive, return true
  if (typeof obj1 !== 'object' || obj1 === null || typeof obj2 !== 'object' || obj2 === null) {
    return false; // If either is not an object or is null, return false
  }
  
  const keys1 = Object.keys(obj1);
  const keys2 = Object.keys(obj2);
  
  if (keys1.length !== keys2.length) return false; // If number of keys are different
  
  for (let key of keys1) {
    // Recursively compare nested objects
    if (!deepEqual(obj1[key], obj2[key])) {
      return false;
    }
  }
  
  return true;
}
```

### Key Differences
1. **Shallow Comparison** checks only the first-level properties of the objects.
2. **Deep Comparison** checks all properties, including nested ones, and compares them recursively.

### Example of Use:
```javascript
const obj1 = { a: 1, b: { c: 2 } };
const obj2 = { a: 1, b: { c: 2 } };
const obj3 = { a: 1, b: { c: 3 } };

console.log(shallowEqual(obj1, obj2)); // false (different references for nested objects)
console.log(deepEqual(obj1, obj2));    // true (values match, even nested)
console.log(deepEqual(obj1, obj3));    // false (nested values are different)
```


In JavaScript, **shallow cloning** and **deep cloning** refer to the ways of creating copies of objects or arrays.

### Shallow Clone
A **shallow clone** creates a new object or array, but does not copy the nested objects or arrays within it. Instead, it only copies the references to those nested elements. Therefore, if you modify a nested element in the cloned object, it will affect the original object.

### Deep Clone
A **deep clone** creates a complete copy of the object or array, including all nested objects or arrays. This means that the original and cloned objects do not share any references, and changes to one will not affect the other.

### Shallow Clone Example
In JavaScript, a shallow clone can be created using:
1. `Object.assign()`
2. The spread operator (`...`)
3. `Array.prototype.slice()` (for arrays)

#### Shallow Clone using `Object.assign()`:
```javascript
const original = { name: 'Alice', address: { city: 'New York' } };
const shallowClone = Object.assign({}, original);
shallowClone.address.city = 'Los Angeles';

console.log(original.address.city); // Los Angeles (affected the original object)
console.log(shallowClone.address.city); // Los Angeles
```

#### Shallow Clone using Spread Operator:
```javascript
const original = { name: 'Alice', address: { city: 'New York' } };
const shallowClone = { ...original };
shallowClone.address.city = 'Los Angeles';

console.log(original.address.city); // Los Angeles
console.log(shallowClone.address.city); // Los Angeles
```

### Deep Clone Example
To perform a deep clone, you can recursively copy each object or array. A simple method is to use `JSON.parse` and `JSON.stringify`, which works for objects without methods or circular references.

#### Deep Clone using `JSON.parse` and `JSON.stringify`:
```javascript
const original = { name: 'Alice', address: { city: 'New York' } };
const deepClone = JSON.parse(JSON.stringify(original));
deepClone.address.city = 'Los Angeles';

console.log(original.address.city); // New York (not affected)
console.log(deepClone.address.city); // Los Angeles
```

This method will not handle functions, special objects (like `Date`, `RegExp`), or circular references.

### Polyfill for Shallow Clone and Deep Clone

#### Shallow Clone Polyfill
For shallow cloning, a simple polyfill using `Object.assign` can be created:
```javascript
if (!Object.prototype.shallowClone) {
  Object.prototype.shallowClone = function() {
    return Object.assign({}, this);
  };
}

const original = { name: 'Alice', address: { city: 'New York' } };
const shallowClone = original.shallowClone();
shallowClone.address.city = 'Los Angeles';

console.log(original.address.city); // Los Angeles (affects the original object)
console.log(shallowClone.address.city); // Los Angeles
```

#### Deep Clone Polyfill
For deep cloning, here's a recursive polyfill function:
```javascript
if (!Object.prototype.deepClone) {
  Object.prototype.deepClone = function() {
    if (this === null || typeof this !== 'object') {
      return this; // Non-object values are returned as-is
    }

    // Handle array case
    if (Array.isArray(this)) {
      return this.map(item => item.deepClone());
    }

    // Handle object case
    const clonedObject = {};
    for (const key in this) {
      if (this.hasOwnProperty(key)) {
        clonedObject[key] = this[key].deepClone();
      }
    }
    return clonedObject;
  };
}

const original = { name: 'Alice', address: { city: 'New York' } };
const deepClone = original.deepClone();
deepClone.address.city = 'Los Angeles';

console.log(original.address.city); // New York (not affected)
console.log(deepClone.address.city); // Los Angeles
```

### Summary
- **Shallow Clone** copies the top-level properties, but nested objects or arrays are shared by reference.
- **Deep Clone** creates a fully independent copy, recursively cloning all nested objects and arrays.
- Polyfills can be created for shallow and deep cloning using `Object.assign()` and recursion, respectively.

