Here’s a comprehensive document that explains all the PostgreSQL concepts involved in the SQL statements you provided, along with the code examples.

---

## PostgreSQL Concepts Explained

### 1. **Creating Tables**

The `CREATE TABLE` statement is used to create a new table in the database. Each column is defined with a name and a data type. In the following example, a table named `customer` is created with several columns:

```sql
CREATE TABLE customer 
(
    CustId int8 PRIMARY KEY,
    CustName varchar(50),
    Age int NOT NULL,
    City char(50),
    Slary numeric
);
```

- **CustId**: Integer type, set as the `PRIMARY KEY`, meaning it uniquely identifies each record.
- **CustName**: A string type with a maximum length of 50 characters.
- **Age**: An integer that cannot be `NULL` (i.e., it must have a value).
- **City**: A fixed-length string (50 characters).
- **Slary**: A numeric type used for salary, which can store numbers with decimals.

### 2. **Selecting Data**

The `SELECT` statement is used to retrieve data from a table. The wildcard `*` retrieves all columns:

```sql
SELECT * FROM customer;
```

### 3. **Inserting Data**

The `INSERT INTO` statement is used to add new rows into a table. You can insert multiple rows in a single statement:

```sql
INSERT INTO customer
(
    CustID, CustName, Age, City, Slary
)
VALUES
(1, 'Sam', 26, 'Delhi', 9000),
(2, 'Ram', 19, 'Banglore', 11000),
(3, 'Pam', 26, 'Mumbai', 6000),
(4, 'Jam', 26, 'Pune', 10000);
```

### 4. **Updating Data**

The `UPDATE` statement is used to modify existing records in a table:

```sql
UPDATE customer 
SET CustName = 'Xam', Age = 32
WHERE CustID = 4;
```

### 5. **Deleting Data**

The `DELETE` statement is used to remove rows from a table:

```sql
DELETE FROM customer WHERE CustID = 3;
```

### 6. **Truncating Data**

The `TRUNCATE TABLE` statement is used to delete all rows from a table, but it does not remove the table structure:

```sql
TRUNCATE TABLE customer;
```

### 7. **Creating Another Table**

The `CREATE TABLE` statement is again used to create a table named `classroom`:

```sql
CREATE TABLE classroom 
(
    rollno int8 PRIMARY KEY,
    name varchar(50) NOT NULL,
    house char(12) NOT NULL,
    grade char(1)
);
```

### 8. **Inserting Data into Another Table**

```sql
INSERT INTO classroom
(rollno, name, house, grade)
VALUES
(1, 'Sam', 'Akash', 'B'),
(2, 'Ram', 'Agni', 'A'),
(3, 'Shyam', 'Jal', 'B'),
(4, 'Sundar', 'Agni', 'A'),
(5, 'Ram', 'Yayu', 'B');
```

### 9. **Selecting Specific Columns**

```sql
SELECT name FROM classroom;
```

### 10. **Using DISTINCT**

The `DISTINCT` keyword is used to return only distinct (unique) values:

```sql
SELECT DISTINCT house FROM classroom;
```

### 11. **Filtering with WHERE**

```sql
SELECT name FROM classroom WHERE grade = 'A';
```

### 12. **Limiting Results**

The `LIMIT` clause is used to restrict the number of rows returned:

```sql
SELECT name FROM classroom LIMIT 2;
```

### 13. **Ordering Results**

The `ORDER BY` clause is used to sort the result set:

```sql
SELECT * FROM classroom ORDER BY grade ASC;
SELECT * FROM classroom ORDER BY grade DESC;
```

### 14. **Grouping Data**

The `GROUP BY` clause groups rows that have the same values into summary rows:

```sql
SELECT house FROM classroom GROUP BY house;
```

### 15. **Using Aggregate Functions**

Aggregate functions perform calculations on a set of values and return a single value. Examples include `COUNT`, `AVG`, `MAX`, etc.

#### Example 1: Generating Random Marks

```sql
SELECT rollno, name, house, grade, 
       FLOOR(RANDOM() * 51 + 50) AS marks
FROM classroom;
```

#### Example 2: Calculating Average Marks per House

```sql
SELECT house,
       ROUND(AVG(marks), 2) AS average_marks
FROM (
    SELECT rollno, name, house, grade,
           FLOOR(RANDOM() * 51 + 51) AS marks
    FROM classroom
) AS temp 
GROUP BY house;
```

#### Example 3: Counting Students per Grade

```sql
SELECT grade, 
       COUNT(*) AS total_students, 
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM classroom), 2) AS percentage
FROM classroom
GROUP BY grade;
```

### 16. **Window Functions**

The `RANK()` function assigns a rank to each row within a partition of a result set:

```sql
WITH random_scores AS (
    SELECT rollno, name, house, grade, 
           FLOOR(RANDOM() * 51 + 50) AS marks
    FROM classroom
)
SELECT house, name, marks
FROM (
    SELECT house, name, marks, 
           RANK() OVER (PARTITION BY house ORDER BY marks DESC) AS rank
    FROM random_scores
) AS ranked
WHERE rank = 1;
```

### 17. **String Functions**

PostgreSQL provides various string functions to manipulate text data.

#### Uppercase String Function

```sql
SELECT rollno, UPPER(name) AS name_uppercase, house, grade
FROM classroom;
```

#### Lowercase String Function

```sql
SELECT rollno, name, LOWER(house) AS house_lowercase, grade
FROM classroom;
```

#### Concatenate Strings

```sql
SELECT rollno, CONCAT(name, ' from ', house) AS description
FROM classroom;
```

#### Length of String

```sql
SELECT rollno, name, LENGTH(name) AS name_length
FROM classroom;
```

#### Substring Function

```sql
SELECT rollno, name, SUBSTRING(name, 1, 3) AS short_name 
FROM classroom;
```

#### Replace a Substring

```sql
SELECT rollno, name, REPLACE(house, 'A', '@') AS house_replace
FROM classroom;
```

#### Pad Strings

```sql
SELECT rollno, name, LPAD(name, 10, '-') AS left_padded
FROM classroom;

SELECT rollno, name, RPAD(name, 10, '*') AS right_padded
FROM classroom;
```

#### Trim Functions

```sql
SELECT rollno, name, TRIM(BOTH ' ' FROM name) AS trimmed_name
FROM classroom;
```

#### Position of Substring

```sql
SELECT rollno, name, POSITION('am' IN name) AS substring_position
FROM classroom;
```

### 18. **GROUP BY with Aggregate Functions**

You can use `GROUP BY` to group data and perform aggregate functions like `COUNT`, `MAX`, `AVG`:

```sql
SELECT house, COUNT(*) AS student_count
FROM classroom
GROUP BY house;
```

#### MAX Function

```sql
SELECT grade, MAX(rollno) AS highest_rollno
FROM classroom
GROUP BY grade;
```

#### Array Aggregation

```sql
SELECT house, ARRAY_AGG(grade) AS grades
FROM classroom
GROUP BY house;
```

#### Count Function

```sql
SELECT grade, COUNT(*) AS student_count
FROM classroom
GROUP BY grade;
```

#### Grouping Multiple Values

```sql
SELECT house, grade, COUNT(*) AS student_count
FROM classroom
GROUP BY house, grade;
```

#### Average Function

```sql
SELECT grade, ROUND(AVG(rollno), 2) AS avg_rollno
FROM classroom
GROUP BY grade;
```

### 19. **HAVING Clause**

The `HAVING` clause is used to filter records after the `GROUP BY` operation:

```sql
SELECT grade, ROUND(AVG(rollno), 2) AS avg_rollno
FROM classroom
GROUP BY grade
HAVING AVG(rollno) > 2;
```

```sql
SELECT house, COUNT(*) AS student_count
FROM classroom
WHERE grade = 'B'
GROUP BY house
HAVING COUNT(*) >= 1;
```

### 20. **ALTER TABLE Commands**

The `ALTER TABLE` command is used to modify an existing table structure.

#### Add Column

```sql
ALTER TABLE classroom
ADD COLUMN Age INT;
```

#### Drop Column

```sql
ALTER TABLE classroom
DROP COLUMN age;
```

#### Rename Column

```sql
ALTER TABLE classroom
RENAME COLUMN nick_name TO name;
```

#### Modify Column Data Type

```sql
ALTER TABLE classroom
ALTER COLUMN age TYPE SMALLINT;
```

#### Add Constraint (Unique)

```sql
ALTER TABLE classroom
ADD CONSTRAINT unique_name UNIQUE(name);
```

#### Drop Constraint

```sql
ALTER TABLE classroom
DROP CONSTRAINT unique_name;
```

#### Rename Table

```sql
ALTER TABLE classroom
RENAME TO students;
```

---

This document covers the PostgreSQL concepts involved in the SQL statements, including table creation, data manipulation, aggregation, string functions, grouping, and altering tables.