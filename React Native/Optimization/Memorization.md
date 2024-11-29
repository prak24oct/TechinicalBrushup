### **Understanding Memoization in React**

Memoization is an optimization technique used to avoid recomputing or recreating something if its inputs (dependencies) haven't changed. In React, memoization ensures that the component or function avoids unnecessary re-renders or recalculations, which can improve performance.

---

### **`useCallback`: Memoizing a Function**
#### **What Does It Mean?**
When you "memoize a function" with `useCallback`, React saves the **reference to that function** and reuses it across renders **until the dependencies change**. Without memoization, a new function reference is created on every render, which can lead to unnecessary re-renders of child components or event handler recreation.

#### **Why Prevent Unnecessary Re-Creation of Functions?**
In React, if a child component receives a new function as a prop (even if the logic of the function is unchanged), it will consider that as a prop change and re-render the child component. This happens because functions in JavaScript are objects, and every time a new function is created, it gets a new reference.

#### **Example:**
```javascript
import React, { useState, useCallback } from 'react';
import { Button, View, Text } from 'react-native';

const ChildComponent = React.memo(({ onIncrement }) => {
  console.log('ChildComponent rendered');
  return <Button title="Increment" onPress={onIncrement} />;
});

const ParentComponent = () => {
  const [count, setCount] = useState(0);

  // Without useCallback, this function is re-created on every render
  const increment = useCallback(() => {
    setCount((prev) => prev + 1);
  }, []); // Memoized function reference

  return (
    <View>
      <Text>Count: {count}</Text>
      <ChildComponent onIncrement={increment} />
    </View>
  );
};

export default ParentComponent;
```

#### **What Happens Without `useCallback`?**
- The `increment` function gets a **new reference** on every render.
- This causes `ChildComponent` to re-render unnecessarily, even though its behavior hasn't changed.

#### **What Happens With `useCallback`?**
- The `increment` function is **memoized**, so it keeps the same reference unless its dependencies change.
- `ChildComponent` avoids unnecessary re-renders.

---

### **`useMemo`: Memoizing a Value**
#### **What Does It Mean?**
When you "memoize a value" with `useMemo`, React saves the **computed value** and reuses it across renders **until the dependencies change**. Without memoization, the calculation will run on every render, even if the inputs are the same.

#### **Why Prevent Unnecessary Re-Computation of Values?**
In React, expensive computations or derived values can slow down performance if they are recalculated on every render, even when the inputs (dependencies) haven't changed.

#### **Example:**
```javascript
import React, { useState, useMemo } from 'react';
import { Button, View, Text } from 'react-native';

const ParentComponent = () => {
  const [count, setCount] = useState(0);
  const [text, setText] = useState('');

  // Expensive calculation
  const expensiveValue = useMemo(() => {
    console.log('Expensive calculation running...');
    return count * 1000;
  }, [count]); // Only re-calculated when `count` changes

  return (
    <View>
      <Text>Count: {count}</Text>
      <Text>Expensive Value: {expensiveValue}</Text>
      <Button title="Increment Count" onPress={() => setCount(count + 1)} />
      <Button title="Update Text" onPress={() => setText('Updated!')} />
    </View>
  );
};

export default ParentComponent;
```

#### **What Happens Without `useMemo`?**
- The expensive calculation (`count * 1000`) runs on **every render**, even when `count` hasn’t changed.

#### **What Happens With `useMemo`?**
- The expensive calculation is **memoized**, so the result is reused unless the `count` value changes.

---

### **Preventing Unnecessary Re-Renders**

#### **Re-Render Triggers in React**
A component re-renders when:
1. Its **state** changes.
2. Its **props** change.
3. Its **parent component** re-renders.

---

#### **How `useCallback` and `useMemo` Help?**

| Without Memoization                 | With Memoization                      |
|-------------------------------------|---------------------------------------|
| Functions are re-created on every render. | Functions retain the same reference across renders unless dependencies change (`useCallback`). |
| Derived values (e.g., calculations) are recomputed every render. | Derived values are reused across renders unless dependencies change (`useMemo`). |
| Child components may re-render unnecessarily if passed new function props. | Child components avoid unnecessary re-renders due to stable function references. |

---

### **Summary: When to Use**
- Use `**useCallback**` for memoizing **functions**, especially for event handlers or props passed to `React.memo` components.
- Use `**useMemo**` for memoizing **values**, particularly for expensive computations or derived state.

By using these hooks effectively, you ensure React renders only what is necessary, improving performance, especially in complex or resource-intensive React Native applications.