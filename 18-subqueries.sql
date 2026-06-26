/*
====================================================
 FILE: 18-subqueries.sql
 TOPIC: SQL Subqueries
 DATABASE: PostgreSQL
====================================================

A Subquery is a query inside another query.

Also known as:
- Nested Query
- Inner Query

Subqueries can be used in:
✔ SELECT
✔ FROM
✔ WHERE
✔ HAVING
✔ INSERT
✔ UPDATE
✔ DELETE
*/

-- ==================================================
-- STEP 1: Remove Existing Tables
-- ==================================================

DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS departments;

-- ==================================================
-- STEP 2: Create Departments Table
-- ==================================================

CREATE TABLE departments (

    department_id SERIAL PRIMARY KEY,

    department_name VARCHAR(50) UNIQUE NOT NULL

);

-- ==================================================
-- STEP 3: Create Students Table
-- ==================================================

CREATE TABLE students (

    student_id SERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    department_id INT REFERENCES departments(department_id),

    gpa DECIMAL(3,2)

);

-- ==================================================
-- STEP 4: Insert Departments
-- ==================================================

INSERT INTO departments (department_name)
VALUES
('CSE'),
('EEE'),
('BBA'),
('English');

-- ==================================================
-- STEP 5: Insert Students
-- ==================================================

INSERT INTO students
(name, department_id, gpa)
VALUES
('Rahim',1,3.80),
('Karim',1,3.50),
('Mim',1,3.60),
('Hasan',2,3.70),
('Jannat',3,3.90);

-- ==================================================
-- STEP 6: View Data
-- ==================================================

SELECT * FROM departments;

SELECT * FROM students;

-- ==================================================
-- SINGLE ROW SUBQUERY
-- ==================================================

-- Find Highest GPA

SELECT MAX(gpa)
FROM students;

-- ==================================================
-- Student Having Highest GPA
-- ==================================================

SELECT *
FROM students
WHERE gpa = (

    SELECT MAX(gpa)
    FROM students

);

-- ==================================================
-- Student Having Lowest GPA
-- ==================================================

SELECT *
FROM students
WHERE gpa = (

    SELECT MIN(gpa)
    FROM students

);

-- ==================================================
-- Students Above Average GPA
-- ==================================================

SELECT *
FROM students
WHERE gpa >

(

    SELECT AVG(gpa)
    FROM students

);

-- ==================================================
-- Students Below Average GPA
-- ==================================================

SELECT *
FROM students
WHERE gpa <

(

    SELECT AVG(gpa)
    FROM students

);

-- ==================================================
-- MULTI ROW SUBQUERY
-- ==================================================

-- Find all students from CSE Department

SELECT *
FROM students
WHERE department_id IN (

    SELECT department_id
    FROM departments
    WHERE department_name='CSE'

);

-- ==================================================
-- Find Students From CSE or EEE
-- ==================================================

SELECT *
FROM students
WHERE department_id IN (

    SELECT department_id
    FROM departments
    WHERE department_name IN ('CSE','EEE')

);

-- ==================================================
-- EXISTS Example
-- ==================================================

-- Departments Having Students

SELECT *
FROM departments d
WHERE EXISTS (

    SELECT 1
    FROM students s
    WHERE s.department_id=d.department_id

);

-- ==================================================
-- NOT EXISTS Example
-- ==================================================

-- Departments Without Students

SELECT *
FROM departments d
WHERE NOT EXISTS (

    SELECT 1
    FROM students s
    WHERE s.department_id=d.department_id

);

-- ==================================================
-- CORRELATED SUBQUERY
-- ==================================================

-- Highest GPA Student From Each Department

SELECT *
FROM students s1
WHERE gpa = (

    SELECT MAX(gpa)
    FROM students s2
    WHERE s1.department_id=s2.department_id

);

-- ==================================================
-- SCALAR SUBQUERY
-- ==================================================

SELECT

    name,

    gpa,

    (

        SELECT AVG(gpa)
        FROM students

    ) AS average_gpa

FROM students;

-- ==================================================
-- SUBQUERY INSIDE SELECT
-- ==================================================

SELECT

    name,

    (

        SELECT MAX(gpa)
        FROM students

    ) AS highest_gpa

FROM students;

-- ==================================================
-- SUBQUERY INSIDE FROM
-- ==================================================

SELECT *

FROM

(

    SELECT

        department_id,

        AVG(gpa) AS average_gpa

    FROM students

    GROUP BY department_id

) AS department_statistics;

-- ==================================================
-- SUBQUERY WITH HAVING
-- ==================================================

SELECT

    department_id,

    AVG(gpa)

FROM students

GROUP BY department_id

HAVING AVG(gpa) >

(

    SELECT AVG(gpa)

    FROM students

);

-- ==================================================
-- SUBQUERY WITH UPDATE
-- ==================================================

-- Increase GPA by 0.10
-- for students below average GPA

UPDATE students

SET gpa = gpa + 0.10

WHERE gpa <

(

    SELECT AVG(gpa)

    FROM students

)

RETURNING *;

-- ==================================================
-- SUBQUERY WITH DELETE
-- ==================================================

-- Delete Students
-- whose GPA is minimum

DELETE FROM students

WHERE gpa =

(

    SELECT MIN(gpa)

    FROM students

)

RETURNING *;

-- ==================================================
-- SUBQUERY WITH INSERT
-- ==================================================

DROP TABLE IF EXISTS top_students;

CREATE TABLE top_students (

    student_id INT,

    name VARCHAR(100),

    gpa DECIMAL(3,2)

);

INSERT INTO top_students

SELECT

    student_id,

    name,

    gpa

FROM students

WHERE gpa >

(

    SELECT AVG(gpa)

    FROM students

);

SELECT *
FROM top_students;

-- ==================================================
-- REAL WORLD EXAMPLES
-- ==================================================

-- Employee With Highest Salary

/*
SELECT *
FROM employees
WHERE salary = (

    SELECT MAX(salary)
    FROM employees

);
*/

------------------------------------------------------

-- Products Above Average Price

/*
SELECT *
FROM products
WHERE price >

(

    SELECT AVG(price)
    FROM products

);
*/

------------------------------------------------------

-- Customers Who Placed Orders

/*
SELECT *
FROM customers
WHERE customer_id IN (

    SELECT customer_id
    FROM orders

);
*/

------------------------------------------------------

-- Products Never Ordered

/*
SELECT *
FROM products p
WHERE NOT EXISTS (

    SELECT 1
    FROM order_items oi
    WHERE oi.product_id=p.product_id

);
*/

-- ==================================================
-- PRACTICE TASKS
-- ==================================================

/*

Task 1
-------
Find the student with the highest GPA.

Task 2
-------
Find the student with the lowest GPA.

Task 3
-------
Find students whose GPA is above average.

Task 4
-------
Find students whose GPA is below average.

Task 5
-------
Find all students from the CSE department.

Task 6
-------
Find all students from CSE and EEE departments.

Task 7
-------
Find departments that have at least one student.

Task 8
-------
Find departments that have no students.

Task 9
-------
Find the highest GPA student from each department.

Task 10
--------
Display every student's GPA along with the overall average GPA.

Task 11
--------
Increase GPA by 0.20 for students whose GPA is below average.

Task 12
--------
Delete students having the minimum GPA.

Task 13
--------
Insert students with GPA above average into another table.

*/

-- ==================================================
-- END OF FILE
-- ==================================================