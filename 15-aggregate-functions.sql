/*
====================================================
 FILE: 15-aggregate-functions.sql
 TOPIC: Aggregate Functions in SQL
 DATABASE: PostgreSQL
====================================================
*/

/*
Aggregate Functions:

1. COUNT()
2. SUM()
3. AVG()
4. MAX()
5. MIN()

Aggregate Functions multiple rows
কে summarize করে একটি single value return করে।
*/

-- ==================================================
-- STEP 1: Clean Up Existing Table
-- ==================================================

DROP TABLE IF EXISTS students;

-- ==================================================
-- STEP 2: Create Students Table
-- ==================================================

CREATE TABLE students (

    student_id SERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    department VARCHAR(50),

    gpa DECIMAL(3,2),

    fee NUMERIC(10,2)

);

-- ==================================================
-- STEP 3: Insert Sample Data
-- ==================================================

INSERT INTO students (
    name,
    department,
    gpa,
    fee
)
VALUES
('Rahim',  'CSE', 3.80, 1000),
('Karim',  'CSE', 3.50, 1500),
('Hasan',  'EEE', 3.70, 1200),
('Jannat', 'BBA', 3.90, 2000),
('Nusrat', 'CSE', NULL, 1800);

-- ==================================================
-- STEP 4: View All Data
-- ==================================================

SELECT *
FROM students;

-- ==================================================
-- COUNT()
-- ==================================================

/*
COUNT(*)
Counts all rows.
*/

SELECT COUNT(*)
FROM students;

/*
Expected Output:

5
*/

-- ==================================================
-- COUNT(column_name)
-- ==================================================

/*
Counts non-NULL values only.
*/

SELECT COUNT(gpa)
FROM students;

/*
Expected Output:

4

Because one GPA is NULL.
*/

-- ==================================================
-- COUNT(DISTINCT)
-- ==================================================

/*
Count unique departments.
*/

SELECT COUNT(DISTINCT department)
FROM students;

/*
Expected Output:

3

CSE
EEE
BBA
*/

-- ==================================================
-- SUM()
-- ==================================================

/*
Calculate total fee.
*/

SELECT SUM(fee)
FROM students;

/*
Expected Output:

7500
*/

-- ==================================================
-- AVG()
-- ==================================================

/*
Calculate average GPA.
NULL values are ignored.
*/

SELECT AVG(gpa)
FROM students;

/*
Calculation:

3.80 + 3.50 + 3.70 + 3.90
= 14.90

14.90 / 4
= 3.725
*/

-- ==================================================
-- MAX()
-- ==================================================

/*
Highest GPA.
*/

SELECT MAX(gpa)
FROM students;

/*
Expected Output:

3.90
*/

-- ==================================================
-- MIN()
-- ==================================================

/*
Lowest GPA.
*/

SELECT MIN(gpa)
FROM students;

/*
Expected Output:

3.50
*/

-- ==================================================
-- Multiple Aggregate Functions Together
-- ==================================================

SELECT
    COUNT(*) AS total_students,
    AVG(gpa) AS average_gpa,
    MAX(gpa) AS highest_gpa,
    MIN(gpa) AS lowest_gpa,
    SUM(fee) AS total_fee
FROM students;

-- ==================================================
-- Aggregate Functions With WHERE
-- ==================================================

/*
Average GPA of CSE students.
*/

SELECT AVG(gpa)
FROM students
WHERE department = 'CSE';

/*
Calculation:

3.80 + 3.50
= 7.30

7.30 / 2
= 3.65
*/

-- ==================================================
-- COUNT Students in CSE
-- ==================================================

SELECT COUNT(*)
FROM students
WHERE department = 'CSE';

-- ==================================================
-- SUM Fee of CSE Students
-- ==================================================

SELECT SUM(fee)
FROM students
WHERE department = 'CSE';

-- ==================================================
-- Aggregate Functions With GROUP BY
-- ==================================================

/*
Count students by department.
*/

SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department;

-- ==================================================
-- Average GPA By Department
-- ==================================================

SELECT
    department,
    AVG(gpa) AS average_gpa
FROM students
GROUP BY department;

-- ==================================================
-- Total Fee By Department
-- ==================================================

SELECT
    department,
    SUM(fee) AS total_fee
FROM students
GROUP BY department;

-- ==================================================
-- Highest GPA By Department
-- ==================================================

SELECT
    department,
    MAX(gpa) AS highest_gpa
FROM students
GROUP BY department;

-- ==================================================
-- Lowest GPA By Department
-- ==================================================

SELECT
    department,
    MIN(gpa) AS lowest_gpa
FROM students
GROUP BY department;

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
-- NULL Handling Example
-- ==================================================

/*
AVG ignores NULL values.
*/

SELECT AVG(gpa)
FROM students;

-- ==================================================
-- Using COALESCE With Aggregate Functions
-- ==================================================

/*
Replace NULL GPA with 0 before averaging.
*/

SELECT AVG(COALESCE(gpa, 0))
FROM students;

-- ==================================================
-- Real World Examples
-- ==================================================

-- Total Revenue

SELECT SUM(fee) AS total_revenue
FROM students;

-- Total Students

SELECT COUNT(*) AS total_students
FROM students;

-- Highest Fee

SELECT MAX(fee) AS highest_fee
FROM students;

-- Lowest Fee

SELECT MIN(fee) AS lowest_fee
FROM students;

-- Average Fee

SELECT AVG(fee) AS average_fee
FROM students;

-- ==================================================
-- Practice Tasks
-- ==================================================

/*

Task 1:
Count total students.

Task 2:
Find average GPA.

Task 3:
Find highest GPA.

Task 4:
Find lowest GPA.

Task 5:
Find total fee collected.

Task 6:
Count students in each department.

Task 7:
Find average GPA by department.

Task 8:
Find total fee by department.

Task 9:
Count unique departments.

Task 10:
Find department with highest student count.

*/

-- ==================================================
-- END OF FILE
-- ==================================================