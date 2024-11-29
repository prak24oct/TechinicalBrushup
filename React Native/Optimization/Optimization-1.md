Both `useCallback` and `useMemo` are React hooks used for memoization, but they serve different purposes and are used in distinct scenarios.

---

### **1. `useCallback`**
#### **Purpose**: Memoizes a function so that it does not get re-created on every render unless its dependencies change.

#### **Usage Scenario**:
- When you pass a function as a prop to a child component and want to avoid unnecessary re-creations of the function on each render.
- To optimize the performance of components that depend on callbacks, especially if those components are wrapped in `React.memo`.

#### **Syntax**:
```javascript
const memoizedCallback = useCallback(() => {
  // Your function logic
}, [dependencies]);
```

#### **Example**:
```javascript
import React, { useState, useCallback } from 'react';
import { Button, View } from 'react-native';

const ChildComponent = React.memo(({ onIncrement }) => {
  console.log('Child rendered');
  return <Button title="Increment" onPress={onIncrement} />;
});

const ParentComponent = () => {
  const [count, setCount] = useState(0);

  const increment = useCallback(() => {
    setCount((prev) => prev + 1);
  }, []); // The function will be memoized unless dependencies change.

  return (
    <View>
      <ChildComponent onIncrement={increment} />
    </View>
  );
};

export default ParentComponent;
```

#### **Key Point**:
Without `useCallback`, the `increment` function would be recreated on every render, causing `ChildComponent` to re-render unnecessarily.

---

### **2. `useMemo`**
#### **Purpose**: Memoizes the result of a computation or calculation so that it does not re-run unless its dependencies change.

#### **Usage Scenario**:
- When you want to optimize expensive calculations or derived state in your components.
- To prevent unnecessary re-computation of values on every render.

#### **Syntax**:
```javascript
const memoizedValue = useMemo(() => {
  // Your calculation logic
  return computedValue;
}, [dependencies]);
```

#### **Example**:
```javascript
import React, { useState, useMemo } from 'react';
import { Text, View, Button } from 'react-native';

const ParentComponent = () => {
  const [count, setCount] = useState(0);
  const [text, setText] = useState('');

  // Expensive calculation
  const expensiveCalculation = useMemo(() => {
    console.log('Expensive calculation running...');
    return count * 1000;
  }, [count]);

  return (
    <View>
      <Text>Count: {count}</Text>
      <Text>Expensive Value: {expensiveCalculation}</Text>
      <Button title="Increment Count" onPress={() => setCount(count + 1)} />
      <Button title="Update Text" onPress={() => setText('Updated!')} />
    </View>
  );
};

export default ParentComponent;
```

#### **Key Point**:
Without `useMemo`, the expensive calculation would re-run on every render, even when only `text` changes.

---

### **Differences Between `useCallback` and `useMemo`**

| Aspect                   | `useCallback`                                | `useMemo`                                   |
|--------------------------|-----------------------------------------------|--------------------------------------------|
| **Purpose**              | Memoizes a **function**                      | Memoizes a **computed value**              |
| **Return Value**         | Returns a memoized function                  | Returns a memoized value                   |
| **Primary Use Case**     | Avoid re-creating functions unnecessarily    | Avoid re-computing expensive calculations  |
| **Dependencies**         | Dependencies array determines re-creation    | Dependencies array determines re-calculation |

---

### **When to Use in React Native**

#### **Use `useCallback`**:
- For event handlers (e.g., `onPress`, `onChange`) that are passed down as props to child components.
- To prevent child components wrapped in `React.memo` from unnecessary re-renders.

#### **Use `useMemo`**:
- For performance optimization when you have expensive calculations (e.g., filtering large datasets, sorting lists).
- To derive memoized values used within the component.

By using these hooks effectively, you can optimize your React Native application by reducing unnecessary computations and renders.
