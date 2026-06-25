/*
====================================================
 FILE: 17-count-distinct.sql
 TOPIC: COUNT DISTINCT
 DATABASE: PostgreSQL
====================================================

COUNT(*)
---------
Counts all rows.

COUNT(column)
--------------
Counts non-NULL values.

DISTINCT
---------
Removes duplicate values.

COUNT(DISTINCT column)
-----------------------
Counts unique non-NULL values.
*/

-- ==================================================
-- STEP 1: Remove Existing Table
-- ==================================================

DROP TABLE IF EXISTS students;

-- ==================================================
-- STEP 2: Create Table
-- ==================================================

CREATE TABLE students (

    student_id SERIAL PRIMARY KEY,

    name VARCHAR(100),

    department VARCHAR(50),

    gpa DECIMAL(3,2),

    city VARCHAR(50)

);

-- ==================================================
-- STEP 3: Insert Sample Data
-- ==================================================

INSERT INTO students
(name, department, gpa, city)
VALUES
('Rahim',  'CSE', 3.80, 'Dhaka'),
('Karim',  'CSE', 3.50, 'Dhaka'),
('Hasan',  'EEE', 3.70, 'Chattogram'),
('Jannat', 'BBA', 3.90, 'Sylhet'),
('Nusrat', 'CSE', 3.80, 'Dhaka'),
('Sakib',  'EEE', NULL, 'Khulna'),
('Mim',    NULL, 3.60, 'Sylhet');

-- ==================================================
-- STEP 4: View All Data
-- ==================================================

SELECT *
FROM students;

-- ==================================================
-- COUNT(*)
-- Counts all rows
-- ==================================================

SELECT COUNT(*)
FROM students;

/*
Expected Output:

7
*/

-- ==================================================
-- COUNT(column)
-- Counts non-NULL values only
-- ==================================================

SELECT COUNT(department)
FROM students;

/*
Expected Output:

6

One department is NULL.
*/

-- ==================================================
-- COUNT(DISTINCT department)
-- Count unique departments
-- ==================================================

SELECT COUNT(DISTINCT department)
FROM students;

/*
Departments:

CSE
CSE
EEE
BBA
CSE
EEE
NULL

Unique:

CSE
EEE
BBA

Output:

3
*/

-- ==================================================
-- Show Unique Departments
-- ==================================================

SELECT DISTINCT department
FROM students;

/*
Output:

CSE
EEE
BBA
NULL
*/

-- ==================================================
-- COUNT(DISTINCT city)
-- ==================================================

SELECT COUNT(DISTINCT city)
FROM students;

/*
Cities:

Dhaka
Dhaka
Chattogram
Sylhet
Dhaka
Khulna
Sylhet

Unique:

Dhaka
Chattogram
Sylhet
Khulna

Output:

4
*/

-- ==================================================
-- COUNT(DISTINCT GPA)
-- ==================================================

SELECT COUNT(DISTINCT gpa)
FROM students;

/*
GPA Values:

3.80
3.50
3.70
3.90
3.80
NULL
3.60

Unique:

3.80
3.50
3.70
3.90
3.60

Output:

5
*/

-- ==================================================
-- COUNT(DISTINCT) + WHERE
-- ==================================================

SELECT COUNT(DISTINCT gpa)
FROM students
WHERE department = 'CSE';

/*
CSE GPA:

3.80
3.50
3.80

Unique:

3.80
3.50

Output:

2
*/

-- ==================================================
-- DISTINCT Multiple Columns
-- ==================================================

SELECT DISTINCT
    department,
    city
FROM students;

/*
Returns unique department-city combinations.
*/

-- ==================================================
-- GROUP BY + COUNT(DISTINCT)
-- ==================================================

SELECT
    department,
    COUNT(DISTINCT gpa) AS unique_gpa_count
FROM students
GROUP BY department;

/*
Example Output:

CSE -> 2
EEE -> 1
BBA -> 1
*/

-- ==================================================
-- GROUP BY + COUNT(DISTINCT city)
-- ==================================================

SELECT
    department,
    COUNT(DISTINCT city) AS unique_city_count
FROM students
GROUP BY department;

-- ==================================================
-- Real World Example
-- Count Unique Customers
-- ==================================================

/*
SELECT COUNT(DISTINCT customer_id)
FROM orders;
*/

-- ==================================================
-- Real World Example
-- Count Unique Products Sold
-- ==================================================

/*
SELECT COUNT(DISTINCT product_id)
FROM order_items;
*/

-- ==================================================
-- Real World Example
-- Count Unique Website Visitors
-- ==================================================

/*
SELECT COUNT(DISTINCT user_id)
FROM website_visits;
*/

-- ==================================================
-- Real World Example
-- Count Unique Countries
-- ==================================================

/*
SELECT COUNT(DISTINCT country)
FROM users;
*/

-- ==================================================
-- NULL Handling Example
-- ==================================================

SELECT DISTINCT department
FROM students;

/*
DISTINCT returns NULL as a unique value.
*/

SELECT COUNT(DISTINCT department)
FROM students;

/*
COUNT(DISTINCT)
ignores NULL values.
*/

-- ==================================================
-- Common Mistake #1
-- ==================================================

/*
❌ Wrong Idea

SELECT DISTINCT COUNT(department)
FROM students;

This does NOT count unique departments.
*/

-- ==================================================
-- Correct Version
-- ==================================================

SELECT COUNT(DISTINCT department)
FROM students;

-- ==================================================
-- Practice Tasks
-- ==================================================

/*

Task 1:
Count total students.

Task 2:
Count unique departments.

Task 3:
Count unique cities.

Task 4:
Count unique GPA values.

Task 5:
Show all unique departments.

Task 6:
Show all unique cities.

Task 7:
Count unique GPA values for CSE students.

Task 8:
Count unique cities per department.

Task 9:
Count unique GPA values per department.

Task 10:
Find how many unique department-city combinations exist.

*/

-- ==================================================
-- END OF FILE
-- ==================================================