# React-Native - Part 1

## 1. What is Virtual DOM and how it is executed with read DOM ?

- ## Virtual DOM

  - Virtual DOM is a light weight, in-memory respresentation of the actual DOM `Document Object Model` tree.
  - It is essentially a javaScript object that mirrors the structure of the real DOM but doesn't have any real UI Representation.
  - Every React component has its own Virtual DOM representation.

- ## How does it works

  - Upon renderering component , `React` creates a Virtual DOM representation of that component and its children.
  - Upon state and prop change, React re-renders the component, generating a new Virtual DOM representation.
  - `React` than compares the new Virtual DOM with the previous one to determine the differences `(changes)`.
  - This process is called **reconcillation**.

- ## Execution with the Real DOM

  - After determining the differences between the old and new Virtual DOM representations, React updates the real DOM efficiently.
  - `React` uses a process called **reconcilliation** to calcualte the minimal set of changes needed to update the real DOM.
  - Ony the changes part of real DOM that changed are updated, resulting in better performance compared to re-rendering the entire UI.

- ## Efficiency and Performance Benefits
  - Manipulating the Virtual DOM is much faster than manipulating the real DOM because the Virtual DOM is just a lightweight Javascript object.
  - React batches updates to Virtual DOM, minimizing the number of actual DOM manipulations, which are costly operations in terms of performance.
  - React also employs various optimization techniques, such as key-based reconciliation, to further improve performance.

## 2. How to handle componentWillUnmount in functional component ?

- `useEffect` hook with an empty dependency array (`[]`) means the effect runs only once after the component mounts, simulating the behaviour of `componentDidMount`.
- Return a cleanup function from the effect. This function will be executed when the component unmounts, similar to `componentWillUnmount`.
- Inside the cleanup function, you can perform any cleanup tasks necessary, such as clearing timers or subscription.

```javascript

import React, { useEffect } from `react`;

function MyComponent() {
    // Use effect with an empty dependency array acts like componentDidMount

    useEffecr(()=>{
        // Code here will run when the component mounts

        //Return a cleanup function to be executed when the component unmounts
        return () => {
            // Code here will run when the component unmounts
            // You can perform any cleanup tasks here, such as clearing timers or subscriptions
        };
    },[]);

    return (
        //Your component JSX
        
    )
}
```
