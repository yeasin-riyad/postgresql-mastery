/*
====================================================
 FILE: 16-group-by-and-having.sql
 TOPIC: GROUP BY and HAVING
 DATABASE: PostgreSQL
====================================================

GROUP BY:
---------
Used to group rows that have the same values.

HAVING:
--------
Used to filter grouped data after GROUP BY.

Execution Order:
----------------
FROM
 ↓
WHERE
 ↓
GROUP BY
 ↓
HAVING
 ↓
SELECT
 ↓
ORDER BY
*/

-- ==================================================
-- STEP 1: Remove Existing Table
-- ==================================================

DROP TABLE IF EXISTS students;

-- ==================================================
-- STEP 2: Create Students Table
-- ==================================================

CREATE TABLE students (

    student_id SERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    department VARCHAR(50) NOT NULL,

    gpa DECIMAL(3,2),

    fee NUMERIC(10,2)

);

-- ==================================================
-- STEP 3: Insert Sample Data
-- ==================================================

INSERT INTO students
(name, department, gpa, fee)
VALUES
('Rahim',  'CSE', 3.80, 1000),
('Karim',  'CSE', 3.50, 1500),
('Nusrat', 'CSE', 3.60, 1200),
('Hasan',  'EEE', 3.70, 1300),
('Jannat', 'BBA', 3.90, 2000),
('Sakib',  'EEE', 3.40, 1100),
('Mim',    'BBA', 3.85, 1800);

-- ==================================================
-- STEP 4: View All Students
-- ==================================================

SELECT *
FROM students;

-- ==================================================
-- GROUP BY Example 1
-- Count Students by Department
-- ==================================================

SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department;

-- ==================================================
-- Expected Output
--
-- CSE  -> 3
-- EEE  -> 2
-- BBA  -> 2
-- ==================================================

-- ==================================================
-- GROUP BY Example 2
-- Average GPA by Department
-- ==================================================

SELECT
    department,
    AVG(gpa) AS average_gpa
FROM students
GROUP BY department;

-- ==================================================
-- GROUP BY Example 3
-- Total Fees by Department
-- ==================================================

SELECT
    department,
    SUM(fee) AS total_fee
FROM students
GROUP BY department;

-- ==================================================
-- GROUP BY Example 4
-- Highest GPA by Department
-- ==================================================

SELECT
    department,
    MAX(gpa) AS highest_gpa
FROM students
GROUP BY department;

-- ==================================================
-- GROUP BY Example 5
-- Lowest GPA by Department
-- ==================================================

SELECT
    department,
    MIN(gpa) AS lowest_gpa
FROM students
GROUP BY department;

-- ==================================================
-- GROUP BY Example 6
-- Multiple Aggregate Functions Together
-- ==================================================

SELECT
    department,
    COUNT(*) AS total_students,
    AVG(gpa) AS average_gpa,
    MAX(gpa) AS highest_gpa,
    MIN(gpa) AS lowest_gpa,
    SUM(fee) AS total_fee
FROM students
GROUP BY department;

-- ==================================================
-- GROUP BY Multiple Columns
-- ==================================================

SELECT
    department,
    gpa,
    COUNT(*) AS total_students
FROM students
GROUP BY department, gpa
ORDER BY department;

-- ==================================================
-- GROUP BY + ORDER BY
-- ==================================================

SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department
ORDER BY total_students DESC;

-- ==================================================
-- WHERE + GROUP BY
-- Only Students with GPA >= 3.5
-- ==================================================

SELECT
    department,
    COUNT(*) AS total_students
FROM students
WHERE gpa >= 3.5
GROUP BY department;

-- ==================================================
-- HAVING Example 1
-- Departments with More Than 2 Students
-- ==================================================

SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department
HAVING COUNT(*) > 2;

-- ==================================================
-- Expected Output
--
-- CSE -> 3
-- ==================================================

-- ==================================================
-- HAVING Example 2
-- Departments with Average GPA > 3.7
-- ==================================================

SELECT
    department,
    AVG(gpa) AS average_gpa
FROM students
GROUP BY department
HAVING AVG(gpa) > 3.7;

-- ==================================================
-- HAVING Example 3
-- Departments with Total Fees > 3000
-- ==================================================

SELECT
    department,
    SUM(fee) AS total_fee
FROM students
GROUP BY department
HAVING SUM(fee) > 3000;

-- ==================================================
-- HAVING Example 4
-- Departments with Highest GPA > 3.8
-- ==================================================

SELECT
    department,
    MAX(gpa) AS highest_gpa
FROM students
GROUP BY department
HAVING MAX(gpa) > 3.8;

-- ==================================================
-- WHERE + GROUP BY + HAVING
-- ==================================================

SELECT
    department,
    COUNT(*) AS total_students
FROM students
WHERE gpa >= 3.5
GROUP BY department
HAVING COUNT(*) >= 2;

-- ==================================================
-- Real World Example 1
-- Departments Having More Than 1 Student
-- ==================================================

SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department
HAVING COUNT(*) > 1;

-- ==================================================
-- Real World Example 2
-- Departments with Average GPA Above 3.6
-- ==================================================

SELECT
    department,
    AVG(gpa) AS avg_gpa
FROM students
GROUP BY department
HAVING AVG(gpa) > 3.6;

-- ==================================================
-- Real World Example 3
-- Departments Generating More Than 2500 Fees
-- ==================================================

SELECT
    department,
    SUM(fee) AS total_fee
FROM students
GROUP BY department
HAVING SUM(fee) > 2500;

-- ==================================================
-- Common Mistake
-- ==================================================

/*
❌ Wrong Query

SELECT
    name,
    department,
    COUNT(*)
FROM students
GROUP BY department;

Reason:
'name' is neither aggregated nor grouped.

This query will produce an error.
*/

-- ==================================================
-- Correct Version
-- ==================================================

SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department;

-- ==================================================
-- Practice Tasks
-- ==================================================

/*

Task 1:
Count students in each department.

Task 2:
Find average GPA by department.

Task 3:
Find total fees by department.

Task 4:
Find highest GPA in each department.

Task 5:
Find departments having more than 2 students.

Task 6:
Find departments with average GPA above 3.7.

Task 7:
Find departments whose total fees exceed 3000.

Task 8:
Find departments with minimum GPA above 3.5.

Task 9:
Show departments ordered by student count.

Task 10:
Show departments having at least 2 students
with GPA greater than or equal to 3.5.

*/

-- ==================================================
-- END OF FILE
-- ==================================================