### PostgreSQL Concepts Explained for SQL Statements

This document provides an explanation of the PostgreSQL concepts involved in the SQL statements listed.

---

#### **1. Table Creation and Data Types**

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

- **CREATE TABLE**: This command creates a new table in the database.
- **Data Types**:
  - `int8`: A 64-bit integer (bigint).
  - `varchar(n)`: A variable-length string with a maximum length of `n` characters.
  - `char(n)`: A fixed-length string of `n` characters.
  - `numeric`: A number with arbitrary precision (can store decimal values).
- **PRIMARY KEY**: A unique identifier for each row in the table, which ensures that the `CustId` column has unique values.
- **NOT NULL**: This constraint ensures that the `Age` column cannot have null values.

---

#### **2. Selecting Data**

```sql
SELECT * FROM customer;
```

- **SELECT**: Retrieves data from a table.
- **`*`**: A wildcard that selects all columns in the table.

---

#### **3. Inserting Data**

```sql
INSERT INTO customer
(CustID, CustName, Age, City, Slary)
VALUES
(1, 'Sam', 26, 'Delhi', 9000),
(2, 'Ram', 19, 'Banglore', 11000),
(3, 'Pam', 26, 'Mumbai', 6000),
(4, 'Jam', 26, 'Pune', 10000);
```

- **INSERT INTO**: Adds new rows to a table.
- **VALUES**: Specifies the values to be inserted into the respective columns.

---

#### **4. Updating Data**

```sql
UPDATE customer 
SET CustName = 'Xam', Age = 32
WHERE CustID = 4;
```

- **UPDATE**: Modifies existing rows in a table.
- **SET**: Specifies the columns to be updated and their new values.
- **WHERE**: Filters the rows that need to be updated.

---

#### **5. Deleting Data**

```sql
DELETE FROM customer WHERE CustID = 3;
```

- **DELETE**: Removes rows from a table.
- **WHERE**: Filters the rows to be deleted.

---

#### **6. Truncating Data**

```sql
TRUNCATE TABLE customer;
```

- **TRUNCATE**: Removes all rows from a table but retains the structure of the table. It is faster than DELETE because it does not log individual row deletions.

---

#### **7. Creating Another Table**

```sql
CREATE TABLE classroom 
(
	rollno int8 PRIMARY KEY,
	name varchar(50) NOT NULL,
	house char(12) NOT NULL,
	grade char(1)
);
```

- Similar to the `CREATE TABLE` statement for the `customer` table, this creates a new table called `classroom`.

---

#### **8. Selecting Data with Conditions**

```sql
SELECT name FROM classroom WHERE grade = 'A';
```

- **WHERE**: Filters rows based on a condition (e.g., selecting students with grade 'A').

---

#### **9. DISTINCT**

```sql
SELECT DISTINCT house FROM classroom;
```

- **DISTINCT**: Removes duplicate values from the result set.

---

#### **10. LIMIT**

```sql
SELECT name FROM classroom LIMIT 2;
```

- **LIMIT**: Restricts the number of rows returned by the query.

---

#### **11. Ordering Data**

```sql
SELECT * FROM classroom ORDER BY grade ASC;
SELECT * FROM classroom ORDER BY grade DESC;
```

- **ORDER BY**: Sorts the result set by one or more columns.
- **ASC**: Sorts in ascending order (default).
- **DESC**: Sorts in descending order.

---

#### **12. Aggregation Functions**

```sql
SELECT house, ROUND(AVG(marks), 2) AS average_marks
FROM (
    SELECT rollno, name, house, grade,
           FLOOR(RANDOM() * 51 + 51) AS marks
    FROM classroom
) AS temp 
GROUP BY house;
```

- **AVG()**: Calculates the average value of a column.
- **ROUND()**: Rounds a numeric value to a specified number of decimal places.
- **GROUP BY**: Groups rows that have the same values in specified columns into summary rows.

---

#### **13. Window Functions (RANK)**

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

- **WITH**: Defines a common table expression (CTE) that can be referred to within the main query.
- **RANK()**: A window function that assigns a rank to each row within a partition (in this case, by `house`).
- **PARTITION BY**: Divides the result set into partitions to perform window functions on each partition.

---

#### **14. String Functions**

- **UPPER()**: Converts a string to uppercase.
- **LOWER()**: Converts a string to lowercase.
- **CONCAT()**: Concatenates two or more strings.
- **LENGTH()**: Returns the length of a string.
- **SUBSTRING()**: Extracts a substring from a string.
- **REPLACE()**: Replaces a substring within a string with another string.
- **LPAD()**: Pads a string on the left with a specified character.
- **RPAD()**: Pads a string on the right with a specified character.
- **TRIM()**: Removes leading and trailing spaces from a string.
- **POSITION()**: Returns the position of a substring within a string.

---

#### **15. Grouping Data and Aggregating**

```sql
SELECT house, COUNT(*) AS student_count
FROM classroom
GROUP BY house;
```

- **COUNT()**: Returns the number of rows in a group.
- **GROUP BY**: Groups rows based on a specified column(s).

---

#### **16. HAVING Clause**

```sql
SELECT grade, ROUND(AVG(rollno), 2) AS avg_rollno
FROM classroom
GROUP BY grade
HAVING AVG(rollno) > 2;
```

- **HAVING**: Filters groups after aggregation, similar to `WHERE`, but for aggregated results.

---

#### **17. ALTER TABLE**

```sql
ALTER TABLE classroom ADD COLUMN Age INT;
ALTER TABLE classroom DROP COLUMN age;
ALTER TABLE classroom RENAME COLUMN nick_name TO name;
ALTER TABLE classroom ALTER COLUMN age TYPE SMALLINT;
```

- **ALTER TABLE**: Modifies the structure of an existing table.
  - **ADD COLUMN**: Adds a new column.
  - **DROP COLUMN**: Removes an existing column.
  - **RENAME COLUMN**: Changes the name of an existing column.
  - **ALTER COLUMN TYPE**: Modifies the data type of a column.

---

#### **18. Constraints**

```sql
ALTER TABLE classroom ADD CONSTRAINT unique_name UNIQUE(name);
ALTER TABLE classroom DROP CONSTRAINT unique_name;
```

- **UNIQUE**: Ensures that all values in a column are distinct.
- **CONSTRAINT**: Defines rules for table columns, such as uniqueness or foreign key relationships.

---

#### **19. Renaming a Table**

```sql
ALTER TABLE classroom RENAME TO students;
```

- **RENAME TO**: Changes the name of a table.

---

This document covers fundamental PostgreSQL concepts like data types, table operations, data retrieval, filtering, aggregation, and table structure modifications.