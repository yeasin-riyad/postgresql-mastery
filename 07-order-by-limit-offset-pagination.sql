/*
====================================================
 FILE: 08-order-by-limit-offset-pagination.sql
 TOPIC: ORDER BY, LIMIT, OFFSET & PAGINATION
 DATABASE: PostgreSQL
====================================================
*/

-- ==================================================
-- STEP 1: Create Sample Table
-- ==================================================

DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    gpa DECIMAL(3,2)
);

-- ==================================================
-- STEP 2: Insert Sample Data
-- ==================================================

INSERT INTO students
VALUES
(101, 'Rahim',  'CSE', 3.80),
(102, 'Karim',  'EEE', 3.50),
(103, 'Jannat', 'CSE', 3.90),
(104, 'Hasan',  'BBA', 3.20),
(105, 'Nusrat', 'CSE', 3.70),
(106, 'Sakib',  'EEE', 3.60),
(107, 'Mim',    'BBA', 3.40),
(108, 'Rifat',  'CSE', 3.85),
(109, 'Tonmoy', 'EEE', 3.65),
(110, 'Nayeem', 'CSE', 3.75);

-- ==================================================
-- STEP 3: View All Data
-- ==================================================

SELECT *
FROM students;

-- ==================================================
-- STEP 4: ORDER BY ASC (Ascending)
-- ==================================================

/*
Sort GPA from lowest to highest
*/

SELECT *
FROM students
ORDER BY gpa ASC;

-- ASC is optional

SELECT *
FROM students
ORDER BY gpa;

-- ==================================================
-- STEP 5: ORDER BY DESC (Descending)
-- ==================================================

/*
Sort GPA from highest to lowest
*/

SELECT *
FROM students
ORDER BY gpa DESC;

-- ==================================================
-- STEP 6: ORDER BY Name Alphabetically
-- ==================================================

SELECT *
FROM students
ORDER BY name ASC;

-- ==================================================
-- STEP 7: Multiple Column Sorting
-- ==================================================

/*
First sort by department

Then sort GPA within department
*/

SELECT *
FROM students
ORDER BY department ASC, gpa DESC;

-- ==================================================
-- STEP 8: LIMIT
-- ==================================================

/*
Return only first 3 rows
*/

SELECT *
FROM students
LIMIT 3;

-- ==================================================
-- STEP 9: Top N Records
-- ==================================================

/*
Top 5 students based on GPA
*/

SELECT *
FROM students
ORDER BY gpa DESC
LIMIT 5;

-- ==================================================
-- STEP 10: OFFSET
-- ==================================================

/*
Skip first 3 rows
Return remaining rows
*/

SELECT *
FROM students
OFFSET 3;

-- ==================================================
-- STEP 11: LIMIT + OFFSET
-- ==================================================

/*
Skip first 3 rows

Return next 3 rows
*/

SELECT *
FROM students
LIMIT 3
OFFSET 3;

-- ==================================================
-- STEP 12: Pagination Example
-- ==================================================

/*
Page Size = 3

Page 1
*/

SELECT *
FROM students
ORDER BY student_id
LIMIT 3
OFFSET 0;

-- ==================================================
-- Page 2
-- ==================================================

SELECT *
FROM students
ORDER BY student_id
LIMIT 3
OFFSET 3;

-- ==================================================
-- Page 3
-- ==================================================

SELECT *
FROM students
ORDER BY student_id
LIMIT 3
OFFSET 6;

-- ==================================================
-- Page 4
-- ==================================================

SELECT *
FROM students
ORDER BY student_id
LIMIT 3
OFFSET 9;

-- ==================================================
-- STEP 13: Pagination Formula
-- ==================================================

/*

OFFSET = (PageNumber - 1) * PageSize

Example:

Page Size = 10

Page 1
OFFSET = (1 - 1) * 10 = 0

Page 2
OFFSET = (2 - 1) * 10 = 10

Page 3
OFFSET = (3 - 1) * 10 = 20

*/

-- ==================================================
-- STEP 14: Practical Search Result Example
-- ==================================================

/*
Show top 5 students
from CSE department
*/

SELECT *
FROM students
WHERE department = 'CSE'
ORDER BY gpa DESC
LIMIT 5;

-- ==================================================
-- STEP 15: Top Student
-- ==================================================

SELECT *
FROM students
ORDER BY gpa DESC
LIMIT 1;

-- ==================================================
-- STEP 16: Lowest GPA Student
-- ==================================================

SELECT *
FROM students
ORDER BY gpa ASC
LIMIT 1;

-- ==================================================
-- STEP 17: Keyset Pagination (Better for Large Data)
-- ==================================================

/*
Instead of OFFSET

Use last seen ID
*/

SELECT *
FROM students
WHERE student_id > 105
ORDER BY student_id
LIMIT 3;

-- ==================================================
-- WHY KEYSET PAGINATION?
-- ==================================================

/*

OFFSET Pagination:

LIMIT 10 OFFSET 100000

Database skips 100000 rows ❌


Keyset Pagination:

WHERE student_id > 100000

Directly jumps to matching rows ✅

Faster for large tables

*/

-- ==================================================
-- PRACTICE TASKS
-- ==================================================

/*

Task 1:
Show all students sorted by GPA DESC.

Task 2:
Show top 3 GPA students.

Task 3:
Show students sorted by Name.

Task 4:
Show page 2 with page size 4.

Task 5:
Show first 5 CSE students.

Task 6:
Show lowest GPA student.

Task 7:
Show highest GPA student.

Task 8:
Sort by department ASC and GPA DESC.

*/

-- ==================================================
-- END OF FILE
-- ==================================================