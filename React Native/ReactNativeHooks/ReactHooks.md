# Introducing Hooks in React Native

Hooks are a new feature addition in React Native version 16.8, which allows you to use React Native features without writing a class. These built-in functions let React Native developers use state and lifecycle methods inside functional components

## React Native Hooks Lifecycle

### 1. Initial Render

```javascript
getDerivedStateFromProps;
useEffect(() => {}, [propp1, prop2]);
componentDidMount;
useEffect(() => {}, []);
```

### 2. Updates

```javascript
getDerivedStateFromProps
   		useEffect( ()=>{},[propp1, prop2])

shouldComponentUpdate()
	useMemo()

componentdidUpdate()
	useEffect( ()=>{})

getSnapshotBeforeUpdate
	custom Hook to hold previous state
```

### 3. Unmount

```javascript
	useEffect( ()=>{return()=>{//cleanup}},[])
```

## Hooks in React Native: Classification

### 1. useState

useState is like this.state() in class. We are going to use useState instead of this.state() to update the state value. Unlike the class, the state is not an object here. We have to initialize the useState() with some value. It can be a number or string, whatever we want. If you have to store multiple values, then for each value, you have to call useState().

```javascript
Const [data, setData] = useState( // value )
```

### 2. useEffect

useEffect is worked as per class lifecycle componentDidMount, componentWillUnMount, componentdidUpdate. useEffect is just re-render the Component and changing the state variable’s value. uesEffect accepts two arguments and doesn’t return anything.

The first argument is a function that holds the code whatever you want to execute at run time. The second argument is optional when you want to execute the hooks. If you do not pass anything to this argument, your function will be called on mount and every update.

```javascript
import React, { useState, useEffect } from "react";
import { View, Text } from "react-native",

const Example = (props) => {
const [count, setCount] = useState(0)

useEffect(() => {
setInterval(() => {
setCount(count + 1);
   }, 1000);
})

return(
  <View
style={{
flex: 1,
alignItems: “center”,
justifyContent: “center”}}
   >
	<Text style={{ fontSize: 50 }}>
Count is incremented {count} times
</Text>
  </View>
 );
}

export default Example;
```

### 3. useContext

This is another hook for anyone unfamiliar with context API in react native. First, let’s have a look at it. Consider the below image that shows an application has many components.

App Component is our parent component, and within the App component, there are various child components.

![alt text](/images/image-1.png)

You can see the dependency tree in the image above. Here, we have a limitation of a three-level hierarchy. Imagine if we have a 10 to 20-level hierarchy. In such cases, the useContext hook reduces our efforts from passing props to every level.

```javascript
const value = useContext(MyContext);
```

### 4. useReducer

useReducer additional hook used as a state management tool. Okay, now don’t we already have useState for state management? Yes, we do have. But, under a few conditions and requirements, it is advisable to use useReducer rather than useState. The next question would be these requirements and the difference between hooks.

```javascript
import React, { useReducer } from "react";
import { View, Text ,Button) from "react-native",
import { reducer } from "redux-form";

const initialState = 0;
const reducer = (state, action) => {
     switch(action){
case 'increment':
    return state + 1;
case 'decrement':
                return state - 1;
case 'reset':
                return initialState;
default:
     return state;
          }
   }

 const Example = (props) => {
 const [count, dispatch) = useReducer( reducer, initialState),

 return (
	<View
   style={{
flex: 1,
alignItems: “center”,
justifyContent: “center”
         }}
      >
	   <Text>Count = {count}</Text>
    	   <Button title=’Increment’ onPress= {()=> dispatch(‘increment’)} />
         <Button title=’Decrement’ onPress= {()=> dispatch(‘decrement’)} />
         <Button title=Reset onPress= {()=> dispatch(reset)} />



</View>
    );
  }

export default Example;
```

### useReducer vs. useState

1. Depends on the type of state. If you need to use string, boolean or number value, then choose use useState. And if array or object, then go with the useReducer.

2. The second scenario depends on the number of transitions. If you are updating one or two states, then use useState. And if there are too many updates, then use useReducer.

3. The third one depends on the business logic for the state transition. If you do the complex transition or transfer value old to the new, then better to use useReducer.

4. Fourth is for local or global states. If your state is within the one component, you can use useState, and if your state is at a global level, you must go with useReducer.

## useCallback
The next hook is useCallback. With each component rendering, functions are recreated. useCallback always returns the memoized version of the function. After using the useCallback function, it will only be changed when one of the dependencies has.

It is useful when some callbacks are passed to the child component, and with that, you can prevent unnecessary renders every time. Like useEffect, useCallback takes a function and an array of dependencies as a parameter. If one of the dependencies’ values changes, the function’s return value will be changed; otherwise, it will always return the cached value.

Assume we have a parent-child component and pass a prop from parent to child component. In such a case, the props within the child component will be called unnecessary whenever the parent component is re-rendered. We can use the useCallback() hook to prevent such unwanted re-renders.

```javascript
const increment = useCallback(() => { 
      setCount(count + 1) 
}, [count]) 
const decrement = useCallback(() => { 
      setCount(count - 1) 
}, [count]) 
const reset = useCallback(O) => { 
     resetCount(reset) 
}, (reset)
```

So now you click any of the counters, the related state will be changed and re-initialized. for the better and to prevent optimization, we can use the useCallback() hook.

## useMemo
useMemo() hook is just like useCallback() hook. The difference is that useCallback returns memoized callback, and useMemo returns a memoized value. If you are creating an application that includes extensive data processing, then using the useMemo() hook is a better choice.

So, it will work once at the first render in the application, and then the cached value will be returned every time. If you have userName to pass every time in the application components, then the operation will be done just once with the help of useMemo().

Then state value will be stored in a memoized value, and when you want to use it, you will get it much faster.

```javascript
useMemo(()=>{
	dosomething()
},[dependencies])
```

If you don’t want to pass arguments, remember to add an empty array as a parameter to useMemo(); otherwise, memoization will not happen. And if you wish to pass arguments, you can also pass them.

## useRef
useRef is like a container that can store mutable values in its .current property. With Ref, we can access all the DOM nodes and elements and keep a mutable variable. We all know about a ref in React Native.

```javascript
const refContainer = useRef(initialValue);
```

Creating createRef in the functional component will create a new instance at every render of DOM. Updating a ref is a side effect. It must be done inside the useEffect() or an event handler. However, the component will not re-render when the useRef value changes. For that, we can use useState().

### Some Rules
* “Only call Hooks at the top level.”
*  Don’t call hooks inside loops, conditions, or nested functions.

* “Only call Hooks from react-native functions.”
*  Call hooks from React Native Components or Custom Hooks; don’t call them from regular functions.
