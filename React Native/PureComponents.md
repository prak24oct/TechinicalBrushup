### What is a pure component in React?

Based on the concept of purity in functional programming paradigms, a function is said to be pure if it meets the following two conditions:
* Its return value is only determined by its input values
* Its return value is always the same for the same input values

A React component is considered pure if it renders the same output for the same state and props.
For this type of class component, React provides the PureComponent base class. Class components that extend the React.PureComponent class are treated as pure components.

* Pure components have some performance improvements and render optimizations because React implements the shouldComponentUpdate() method for them with a shallow comparison of props and state.

* If you want React to treat a functional component as a pure component, you’ll have to convert the functional component to a class component that extends React.PureComponent.

While functional components don’t have direct lifecycle methods, they still go through the same three phases as class components:

1. Mounting: useEffect(() => {}, []): This Hook is similar to componentDidMount in class components. The function inside useEffect runs after the component is first rendered
2. Updating: useEffect(() => {}): If you omit the dependency array ([]), useEffect will run after every render (similar to componentDidUpdate)
3. Unmounting: useEffect(() => { return () => {} }): The function returned inside useEffect (the cleanup function) is equivalent to componentWillUnmount in class components and is used to clean up resources when the component unmounts or before it re-renders

## Using the { pure } HOC from Recompose
The Recompose package provides a broad collection of higher-order components (HOCs) that are very useful for dealing with functional components. The Recompose package exports a [[{ pure }]] HOC that tries to optimize a React component by preventing updates on the component unless a prop has changed, using shallowEqual() to test for changes.

```javascript
// Wrap component using the `pure` HOC from recompose
export default pure(PercentageStat);
```

## How to use React.memo

With React.memo, you can create memoized functional components that prevent unnecessary updates. This functionality is particularly useful when dealing with components that receive the same set of props. React.memo does this by comparing the new and previous props using a shallow comparison.

* Using the React.memo API, the previous functional component can be wrapped as follows:

```javascript
// Wrap component using `React.memo()`
export default memo(PercentageStat);
```

There are a few things worth considering about the implementation of the React.memo API.

* For one, React.memo is a higher-order component. It takes a React component as its first argument and returns a special type of React component that allows the renderer to render the component while memoizing the output. Therefore, if the component’s props are shallowly equal, the React.memo component will bail out the updates.

* React.memo works with all React components. The first argument passed to React.memo can be any type of React component. However, for class components, you should use React.PureComponent instead of React.memo. React.memo also works with components rendered from the server using ReactDOMServer.