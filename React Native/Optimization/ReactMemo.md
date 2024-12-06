In React, you can use `React.memo` to optimize functional components by memoizing them. This prevents unnecessary re-renders if the props do not change. To compare props and restrict the component from being re-rendered, you can provide a custom `areEqual` function as the second argument to `React.memo`. 

Here's how it works:

### Example of `React.memo` with Custom Comparison Function

```jsx
import React from 'react';

const MyComponent = ({ name, age }) => {
  console.log('Component rendered');
  return (
    <div>
      <p>Name: {name}</p>
      <p>Age: {age}</p>
    </div>
  );
};

// Custom comparison function
const arePropsEqual = (prevProps, nextProps) => {
  // Compare specific props to prevent re-render
  return prevProps.name === nextProps.name && prevProps.age === nextProps.age;
};

// Memoized component
const MemoizedComponent = React.memo(MyComponent, arePropsEqual);

export default MemoizedComponent;
```

### Explanation:
1. **Component**: The `MyComponent` functional component renders some props.
2. **`React.memo`**: Wraps `MyComponent` to memoize it.
3. **Custom Comparison**: The `arePropsEqual` function compares the previous and next props.
   - If it returns `true`, the component will not re-render.
   - If it returns `false`, the component will re-render.

### When to Use:
- Use `React.memo` with a custom comparison when your component re-renders unnecessarily due to shallow prop changes.
- Be cautious as the custom comparison can introduce performance overhead if it's computationally expensive.

### Note:
React.memo performs a shallow comparison of props by default if no custom `areEqual` function is provided. Use a custom function only if specific conditions or deep comparisons are needed.