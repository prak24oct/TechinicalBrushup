CREATE TABLE customer 
(
	CustId int8 PRIMARY KEY,
	CustName varchar(50),
	Age int NOT NULL,
	City char(50),
	Slary numeric
);

Select * from customer

INSERT INTO customer
(
	CustID,CustName,Age,City,Slary
)
VALUES
(1,'Sam',26,'Delhi',9000),
(2,'Ram',19,'Banglore',11000),
(3,'Pam',26,'Mumbai',6000),
(4,'Jam',26,'Pune',10000);

SELECT * FROM customer

UPDATE customer 
SET CustName = 'Xam', Age=32
WHERE CustID = 4;

SELECT * FROM customer

DELETE FROM customer WHERE CustID = 3;

SELECT * FROM customer

TRUNCATE TABLE customer;

SELECT * FROM customer;

CREATE TABLE classroom 
(
	rollno int8 PRIMARY KEY,
	name varchar(50) NOT NULL,
	house char(12) NOT NULL,
	grade char(1)
);

INSERT INTO classroom
(rollno, name, house, grade)
VALUES
(1,'Sam','Akash','B'),
(2,'Ram','Agni','A'),
(3,'Shyam','Jal','B'),
(4,'Sundar','Agni','A'),
(5,'Ram','Yayu','B');

SELECT * from classroom

SELECT name from classroom

SELECT DISTINCT house from classroom

SELECT name from classroom WHERE grade = 'A'

SELECT name from classroom LIMIT 2;

SELECT * FROM classroom ORDER BY grade ASC;
SELECT * FROM classroom ORDER BY grade DESC;

SELECT house from classroom GROUP BY house

SELECT rollno, name, house, grade, 
       FLOOR(RANDOM() * 51 + 50) AS marks
FROM classroom;

SELECT house,
	ROUND(AVG(marks),2) AS average_marks
FROM (
	SELECT 
	rollno, name , house, grade,
	-- house,
		FLOOR(RANDOM() * 51 + 51) AS marks
	FROM classroom
) AS temp 
GROUP BY house;

SELECT grade, 
       COUNT(*) AS total_students, 
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM classroom), 2) AS percentage
FROM classroom
GROUP BY grade;

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


Upper String function
SELECT rollno, UPPER(name) AS name_uppercase, house , grade
FROM classroom;

Lowercase String function
SELECT rollno, name, LOWER(house) AS house_lowercase, grade
FROM classroom;

Concat String function
SELECT rollno, CONCAT(name,' from ',house) AS description
FROM classroom;

Length string function
SELECT rollno, name, LENGTH(name) AS name_length
FROM classroom;

Substring string function
SELECT rollno, name, SUBSTRING(name,1,3) AS short_name 
FROM classroom

Replace a substring function
SELECT rollno, name , REPLACE(house, 'A', '@') AS house_replace
FROM classroom;

Pad string function
SELECT rollno, name, LPAD(name, 10, '-') AS left_padded
FROM classroom

SELECT rollno, name, RPAD(name, 10, '*') AS left_padded
FROM classroom

Trim, ltrim, rtrim function
SELECT rollno, name, TRIM(BOTH ' ' FROM name) AS trimmed_name
FROM classroom;

Position string function
SELECT rollno, name, POSITION ('am' IN name) AS substring_position
FROM classroom;

GROUP BY
SELECT house, COUNT(*) AS student_count
FROM classroom
GROUP BY house;

MAX function
SELECT grade , MAX(rollno) AS highest_rollno
FROM classroom
GROUP BY grade;

Array Aggregation function
SELECT house, ARRAY_AGG(grade) AS grades
FROM classroom
GROUP BY house;

Count function
SELECT grade, COUNT(*) AS student_count
FROM classroom
GROUP BY grade;

Group multiple values
SELECT house, grade, COUNT(*) AS student_count
FROM classroom
GROUP BY house, grade;

Average function
SELECT grade, ROUND(AVG(rollno),2) AS avg_rollno
FROM classroom
GROUP BY grade;

HAVING using GROUP BY
SELECT grade, ROUND(AVG(rollno),2) AS avg_rollno
FROM classroom
GROUP BY grade
HAVING AVG(rollno) > 2;

SELECT house, COUNT(*) AS student_count
FROM classroom
WHERE grade = 'B'
GROUP BY house
HAVING COUNT(*) >= 1

Alter table command
ALTER TABLE classroom
ADD COLUMN Age INT;

SELECT * from classroom

Drop Column
ALTER TABLE classroom
DROP COLUMN age

SELECT * from classroom

ALTER TABLE classroom
RENAME COLUMN nick_name TO name

Modify cloumn data type
ALTER TABLE classroom
ALTER COLUMN age TYPE SMALLINT;

Add a constraint ( Unique )
ALTER TABLE classroom
ADD CONSTRAINT unique_name UNIQUE(name);

Drop constraint
ALTER TABLE classroom
DROP CONSTRAINT unique_name;

Rename table
ALTER TABLE classroom
RENAME TO students

SELECT * from classroom









