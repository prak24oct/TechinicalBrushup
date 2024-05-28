# Design Patterns for React Native Applications

- Design patterns in React-Native are reusable solutions to common problems that arise when building applications.

## 1. Component Composition
- Component composition is a fundamental concept in React development, allowing you to build complex UIs by combining smaller, reusable components. Rather than creating monolithic components that handle every aspect of the UI, you break down your UI into smaller, self-contained components that handle specific tasks or represent specific elements. This approach promotes code reuse, improves code readability, and makes your application easier to maintain.

### Example
```javascript
import React from 'react';
import { View, Text } from 'react-native';

const Header = () => <Text style={{ fontSize: 24 }}>Welcome to My App</Text>;

const App = () => (
  <View>
    <Header />
    {/* Other components */}
  </View>
);

export default App;
```

## 2. Container/Presentational Components
- Separating container components (responsible for data fetching and state management) from presentational components (responsible for rendering UI) is a common practice in React development. Container components are connected to your application's data store and handle logic, while presentational components focus solely on rendering UI based on the props they receive. This separation of concerns improves code organization, reusability, and testability.

### Example 
```javascript
// Container Component
import React, { useState } from 'react';
import { View, Button } from 'react-native';

const CounterContainer = () => {
  const [count, setCount] = useState(0);

  const increment = () => setCount(count + 1);
  const decrement = () => setCount(count - 1);

  return (
    <View>
      <Counter count={count} />
      <Button title="Increment" onPress={increment} />
      <Button title="Decrement" onPress={decrement} />
    </View>
  );
};

export default CounterContainer;

// Presentational Component
import React from 'react';
import { Text } from 'react-native';

const Counter = ({ count }) => <Text>{count}</Text>;

export default Counter;
```

## 3. Stateful/Stateless Components
- In React, components can be classified as stateful or stateless. Stateful components manage their own state, meaning they can hold data and update it over time. In contrast, stateless components are purely presentational and receive data via props from their parent components. By separating components based on their responsibility for managing state, you can create a clear and maintainable codebase.

### Example 
```javascript
// Stateful Component
import React, { useState } from 'react';
import { Button } from 'react-native';

const ToggleButton = () => {
  const [isOn, setIsOn] = useState(false);

  const toggle = () => setIsOn(!isOn);

  return (
    <Button title={isOn ? 'ON' : 'OFF'} onPress={toggle} />
  );
};

export default ToggleButton;

// Stateless Component
import React from 'react';
import { Text } from 'react-native';

const Greeting = ({ name }) => <Text>Hello, {name}!</Text>;

export default Greeting;
```

## 4.Atomic Design
- Atomic design is a methodology for creating design systems that break down UI elements into smaller, reusable components. The basic idea is to start with simple components (atoms) and gradually build more complex components (molecules, organisms, templates, and pages) by combining them. This approach promotes consistency, scalability, and reusability in your UI architecture.

### Example
```javascript
// Atom - Button
import React from 'react';
import { TouchableOpacity, Text } from 'react-native';

const Button = ({ onPress, text }) => (
  <TouchableOpacity onPress={onPress}>
    <Text>{text}</Text>
  </TouchableOpacity>
);

export default Button;

// Molecule - Header
import React from 'react';
import { View, Text } from 'react-native';

const Header = ({ title }) => (
  <View>
    <Text style={{ fontSize: 24 }}>{title}</Text>
  </View>
);

export default Header;

// Organism - Form
import React from 'react';
import { View, TextInput, Button } from 'react-native';

const Form = ({ onSubmit }) => (
  <View>
    <TextInput placeholder="Username" />
    <TextInput placeholder="Password" secureTextEntry />
    <Button title="Submit" onPress={onSubmit} />
  </View>
);

export default Form;
```

## 5. Higher-Order Components (HOC)
- Higher-order components (HOC) are functions that take a component and return a new component with additional functionality. They enable you to encapsulate common logic and behaviour in a reusable wrapper component that can be applied to other components. HOCs are particularly useful for cross-cutting concerns such as authentication, logging, and data fetching.

### Example
```javascript
import React from 'react';
import { View, Text } from 'react-native';

const withLogger = (WrappedComponent) => {
  return (props) => {
    console.log('Props:', props);
    return <WrappedComponent {...props} />;
  };
};

const MyComponent = ({ message }) => (
  <View>
    <Text>{message}</Text>
  </View>
);

export default withLogger(MyComponent);
```

## 6.Render Prop
- Render props is a technique for sharing code between React components using a prop whose value is a function. Instead of relying on higher-order components, render props allow components to provide data or behaviour to other components via a render function. This pattern enhances reusability and composability by allowing components to be more flexible and customizable.

### Example
```javascript
import React from 'react';
import { View, Button } from 'react-native';

const ToggleButton = ({ render }) => {
  const [isOn, setIsOn] = React.useState(false);

  const toggle = () => setIsOn(!isOn);

  return (
    <View>
      {render({ isOn, toggle })}
    </View>
  );
};

const App = () => (
  <ToggleButton
    render={({ isOn, toggle }) => (
      <Button title={isOn ? 'ON' : 'OFF'} onPress={toggle} />
    )}
  />
);

export default App;
```