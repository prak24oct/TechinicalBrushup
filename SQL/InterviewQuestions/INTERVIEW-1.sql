Create Tables: Employee and EmployeeDetail

CREATE TABLE Employee ( EmpID int NOT NULL,
EmpName Varchar, Gender Char, Salary int, City Char(20) )

CREATE TABLE EmployeeDetail ( EmpID int NOT NULL,
Project Varchar,
EmpPosition Char(20),
DOJ date )

INSERT INTO Employee
VALUES (1, 'Arjun', 'M', 75000, 'Pune'),
(2, 'Ekadanta', 'M', 125000, 'Bangalore'), (3, 'Lalita', 'F', 150000 , 'Mathura'),
(4, 'Madhav', 'M', 250000 , 'Delhi'),
(5, 'Visakha', 'F', 120000 , 'Mathura')

INSERT INTO EmployeeDetail
VALUES (1, 'P1', 'Executive', '2024-01-26'),
       (2, 'P2', 'Executive', '2020-05-04'),
       (3, 'P1', 'Lead', '2024-10-21'),
       (4, 'P3', 'Manager', '2019-11-29'),
       (5, 'P2', 'Manager', '2024-08-01');

SELECT * from Employee
SELECT * from EmployeeDetail

-- Q1(a): Find the list of employees whose salary ranges between 2L to 3L.
SELECT * from Employee WHERE salary > 200000 AND salary < 300000
SELECT EmpName, Salary FROM Employee
WHERE salary BETWEEN 200000 AND 300000

-- Q1(b): Write a query to retrieve the list of employees from the same city.
SELECT E1.EmpID, E1.EmpName, E1.City
FROM Employee E1, Employee E2
-- WHERE E1.City = E2.City
WHERE E1.City = E2.City AND E1.EmpID !=E2.EmpID


-- Q1(c): Query to find the null values in the Employee table.
SELECT * FROM Employee
WHERE EmpId = Null

-- Q2(a): Query to find the cumulative sum of employee’s salary.
SELECT ROUND(AVG(salary),2) from Employee (Not a solution)
SELECT EmpID, Salary, 
SUM(Salary) OVER (ORDER BY EmpID) AS CommulativeSum
FROM Employee

-- Q2(b): What’s the male and female employees ratio.
SELECT
(COUNT(*) FILTER (WHERE Gender = 'M') * 100.0 / Count(*)) AS MalePct,
(COUNT(*) FILTER (WHERE Gender = 'F') * 100.0 / Count(*)) AS FemalePct
FROM Employee;

-- Q2(c): Write a query to fetch 50% records from the Employee table.
SELECT * FROM Employee
WHERE EmpID <= (SELECT COUNT(EmpID) /2 FROM Employee)
SELECT * FROM Employee LIMIT(SELECT (COUNT(*) FROM Employee / 2) from Employee) (Wrong)
SELECT * FROM Employee LIMIT( SELECT COUNT(*)/2 FROM Employee) (Right)

-----------------------------------------------------------------------------------
-- Query to fetch the employee’s salary but 
-- replace the LAST 2 digits with ‘XX’ i.e 12345 will be 123XX

SELECT Salary,
CONCAT(SUBSTRING(Salary::text, 1, LENGTH(Salary::text)-2),'XX') as maked_number 
FROM Employee

Select Salary, CONCAT(LEFT(CAST(Salary AS Text),LENGTH(CAST(Salary AS text))-2),'XX')
AS maked_number
FROM Employee

----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Q4: Write a query to fetch even and odd rows from Employee table.
SELECT * FROM Employee WHERE EmpId % 2 != 0 
SELECT * FROM Employee WHERE EmpId % 2 = 0 (Not generic)
For Even Row
SELECT * FROM 
 		 (SELECT *, ROW_NUMBER() OVER(ORDER BY EmpId) AS
		  RowNumber
		  FROM Employee) AS Emp
WHERE Emp.RowNumber % 2 = 0

-- For ODD Rows
SELECT * FROM 
 		 (SELECT *, ROW_NUMBER() OVER(ORDER BY EmpId) AS
		  RowNumber
		  FROM Employee) AS Emp
WHERE Emp.RowNumber % 2 != 0

-- USING MOD function
-- For Even Rows
SELECT * FROM Employee WHERE MOD(EmpID,2) = 0 
-- For Ood Rows
SELECT * FROM Employee WHERE MOD(EmpID,2) = 1

-----------------------------------------------------------------------------------



