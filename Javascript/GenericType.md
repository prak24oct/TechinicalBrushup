Generics in TypeScript are powerful and used in many real-world scenarios to create reusable, type-safe code. Below are some common examples:

---

### 1. **Array and List Processing**
A generic function can process arrays of any type.

#### Example:
```typescript
function getFirstElement<T>(arr: T[]): T | undefined {
  return arr.length > 0 ? arr[0] : undefined;
}

// Usage:
const numbers = [1, 2, 3];
const firstNumber = getFirstElement(numbers); // Type: number

const strings = ["a", "b", "c"];
const firstString = getFirstElement(strings); // Type: string
```
This function works with arrays of any type while maintaining type safety.

---

### 2. **API Responses**
Generics are often used to handle varying API response types.

#### Example:
```typescript
interface ApiResponse<T> {
  status: string;
  data: T;
}

function fetchData<T>(url: string): Promise<ApiResponse<T>> {
  return fetch(url)
    .then((response) => response.json())
    .then((data) => ({ status: "success", data }));
}

// Usage:
interface User {
  id: number;
  name: string;
}

fetchData<User>("https://api.example.com/user/1").then((response) => {
  console.log(response.data.name); // Type-safe access to `name`
});
```
The `ApiResponse` interface is generic, and `fetchData` adapts to the type of the data being fetched.

---

### 3. **React Components**
Generics are frequently used in libraries like React for reusable components.

#### Example: A Dropdown Component
```tsx
import React from "react";

interface DropdownProps<T> {
  items: T[];
  onSelect: (item: T) => void;
}

function Dropdown<T>({ items, onSelect }: DropdownProps<T>) {
  return (
    <select onChange={(e) => onSelect(items[Number(e.target.value)])}>
      {items.map((item, index) => (
        <option key={index} value={index}>
          {JSON.stringify(item)}
        </option>
      ))}
    </select>
  );
}

// Usage:
const users = [
  { id: 1, name: "John" },
  { id: 2, name: "Jane" },
];

<Dropdown
  items={users}
  onSelect={(user) => console.log(user.name)}
/>;
```
The dropdown works with any type of `items`, ensuring type safety in the `onSelect` callback.

---

### 4. **Custom Hooks in React**
Custom hooks can be made generic to handle different types of data.

#### Example: `useFetch` Hook
```typescript
import { useState, useEffect } from "react";

function useFetch<T>(url: string): { data: T | null; error: string | null } {
  const [data, setData] = useState<T | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetch(url)
      .then((res) => res.json())
      .then((data) => setData(data))
      .catch((err) => setError(err.message));
  }, [url]);

  return { data, error };
}

// Usage:
interface Post {
  id: number;
  title: string;
}

const { data, error } = useFetch<Post[]>("/api/posts");
if (data) console.log(data.map((post) => post.title));
```
This hook works for any type of data fetched from the API.

---

### 5. **CRUD Operations**
Generic functions can simplify CRUD operations in data services.

#### Example:
```typescript
class Repository<T> {
  private data: T[] = [];

  add(item: T): void {
    this.data.push(item);
  }

  findById(predicate: (item: T) => boolean): T | undefined {
    return this.data.find(predicate);
  }

  remove(predicate: (item: T) => boolean): void {
    this.data = this.data.filter((item) => !predicate(item));
  }
}

// Usage:
interface Product {
  id: number;
  name: string;
}

const productRepo = new Repository<Product>();

productRepo.add({ id: 1, name: "Laptop" });
console.log(productRepo.findById((product) => product.id === 1)); // { id: 1, name: "Laptop" }
```

---

### 6. **Utility Functions**
For example, a generic function to merge two objects.

#### Example:
```typescript
function mergeObjects<T, U>(obj1: T, obj2: U): T & U {
  return { ...obj1, ...obj2 };
}

// Usage:
const person = { name: "Alice" };
const job = { title: "Engineer" };

const employee = mergeObjects(person, job); // Type: { name: string; title: string }
console.log(employee);
```

---

### Benefits of Generics in These Examples:
1. **Type Reuse**: Reusable code works with multiple types.
2. **Type Safety**: Ensures correct type usage, reducing runtime errors.
3. **Code Clarity**: Explicit types make the code easier to read and maintain.

These examples demonstrate how generics enhance flexibility while ensuring type safety, especially in scenarios involving data manipulation, APIs, or reusable components.