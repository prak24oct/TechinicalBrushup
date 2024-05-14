# Lifecycle of React Native Component
 A component’s life cycle in React Native can be divided into 4 phases:

 ![Lifecycle](image.png)

1. Mounting: In this phase, component instance is created and inserted into the DOM.
2. Updating: In updating phase, a react component is said to be born and it start growing by receiving new updates.
3. Unmounting: In this phase, a react component gets removed from actual DOM.
4. Error Handling: It is called when any error occurs while rendering the component.


## Mounting phase

Below are the methods which gets called when instance of component is created and inserted into the DOM.

1. Constructor()
2. static getDerivedStateFromProps()
3. render()
4. ComponentDidMount()

### Constructor()
* It is first method which gets called in the lifecycle of react native component. It is used to initialise the component with initial state. In constructor no UI rendering is done. It receives props as an argument and we can set state in this method.

### static getDerivedStateFromProps()
* It is called just before the render method, both on the initial mount and the subsequent update. It is the replacement of componentWillReceiveProps method. We cannot update state inside this method. If we want to update the state then we should return and object else return null.

### render()
* It is the only required method in react component. It tells what to display on the screen. render() method is pure function which means it doesn’t modify the state. It returns the same result each time it is invoked and it does not directly interact with the browser.

### ComponentDidMount()
* This method gets called when react native component has finished the rendering part. It is good place to load data from remote endpoint and update the state with the result. This will refresh the UI of our mobile screen. Whenever we make any change in the state then render() methods gets called which will ultimately reflect the changes on the screen.

## Updating phase
* Whenever there is any change in the state or props then updating process of the component get started. Below are the methods which gets called in the updating phase of react component.

### static getDerivedStateFromProps()
As we already discussed above, this method gets called whenever any changes occurred in state or props.

### shouldComponentUpdate()
it is called before rendering when new props or states are being received. Default value of this method is true. This method doesn’t get called on initial render or when forceUpdate is used. If we want to stop re-rendering on changing state or props then we can return false in shouldComponentUpdate() method.

### render()
Whenever there is any change in the state or props then render methods gets called again.

### getSnapshotBeforeUpdate()
This method gets called right before the most recently rendered output is committed. It enables our component to some information from the DOM before it is potentially changed.

### componentDidUpdate()
componentDidUpdate() method is invoked immediately after re-rendering of the component gets completed. It is important to note here that it is not called for the initial render.

## Unmounting phase

### componentWillUnmount()
componentWillUnmount() method gets invoked when component is removed from the DOM. We can perform clean up tasks in this method like invalidating timers, cancelling ongoing network request.

### Error handling phase
Whenever any error occurred while rendering the component then error handling phase of react gets called with below methods.

* static getDerivedStateFromError()
* componentDidCatch()

### getDerivedStateFromError()
It is called whenever any error occurred while rendering. It receives the error as a parameter and returns the value to update the state.

### componentDidCatch()

This is invoked when any error is thrown by descendant component. It receives two parameter

* error: The error that was thrown
* info: It is an object having information about which component threw that error.