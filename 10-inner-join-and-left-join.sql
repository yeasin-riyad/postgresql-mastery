/*
====================================================
 FILE: 11-inner-join-and-left-join.sql
 TOPIC: INNER JOIN and LEFT JOIN
 DATABASE: PostgreSQL
====================================================
*/

-- ==================================================
-- STEP 1: Clean Up Existing Tables
-- ==================================================

DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS departments;

-- ==================================================
-- STEP 2: Create Departments Table
-- ==================================================

CREATE TABLE departments (

    department_id SERIAL PRIMARY KEY,

    department_name VARCHAR(100) UNIQUE NOT NULL

);

-- ==================================================
-- STEP 3: Create Students Table
-- ==================================================

CREATE TABLE students (

    student_id SERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    department_id INT,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)

);

-- ==================================================
-- STEP 4: Insert Seed Data into Departments
-- ==================================================

INSERT INTO departments (
    department_name
)
VALUES
('CSE'),
('EEE'),
('BBA');

-- ==================================================
-- STEP 5: Insert Seed Data into Students
-- ==================================================

INSERT INTO students (
    name,
    department_id
)
VALUES
('Rahim', 1),
('Karim', 1),
('Hasan', 2),
('Jannat', NULL), -- No department assigned
('Nusrat', 3);

-- ==================================================
-- STEP 6: View All Data
-- ==================================================

SELECT *
FROM departments;

SELECT *
FROM students;

-- ==================================================
-- STEP 7: INNER JOIN
-- ==================================================

/*
INNER JOIN returns only matching rows
from both tables.
*/

SELECT
    s.student_id,
    s.name,
    d.department_name
FROM students s
INNER JOIN departments d
    ON s.department_id = d.department_id;

-- ==================================================
-- Expected Result
-- ==================================================

/*

student_id | name   | department_name
-----------+--------+----------------
1          | Rahim  | CSE
2          | Karim  | CSE
3          | Hasan  | EEE
5          | Nusrat | BBA

Jannat is missing because
department_id = NULL

*/

-- ==================================================
-- STEP 8: INNER JOIN with WHERE Clause
-- ==================================================

/*
Find all students of CSE department
*/

SELECT
    s.student_id,
    s.name,
    d.department_name
FROM students s
INNER JOIN departments d
    ON s.department_id = d.department_id
WHERE d.department_name = 'CSE';

-- ==================================================
-- STEP 9: LEFT JOIN
-- ==================================================

/*
LEFT JOIN returns ALL rows
from the left table.

If no match exists,
NULL values are returned.
*/

SELECT
    s.student_id,
    s.name,
    d.department_name
FROM students s
LEFT JOIN departments d
    ON s.department_id = d.department_id;

-- ==================================================
-- Expected Result
-- ==================================================

/*

student_id | name    | department_name
-----------+---------+----------------
1          | Rahim   | CSE
2          | Karim   | CSE
3          | Hasan   | EEE
4          | Jannat  | NULL
5          | Nusrat  | BBA

*/

-- ==================================================
-- STEP 10: Find Students Without Departments
-- ==================================================

/*
Find students whose department
has not been assigned yet.
*/

SELECT
    s.student_id,
    s.name
FROM students s
LEFT JOIN departments d
    ON s.department_id = d.department_id
WHERE d.department_id IS NULL;

-- Alternative

SELECT
    student_id,
    name
FROM students
WHERE department_id IS NULL;

-- ==================================================
-- STEP 11: Count Students Per Department
-- ==================================================

SELECT
    d.department_name,
    COUNT(s.student_id) AS total_students
FROM departments d
LEFT JOIN students s
    ON d.department_id = s.department_id
GROUP BY d.department_name
ORDER BY total_students DESC;

-- ==================================================
-- STEP 12: Show Student + Department Information
-- ==================================================

SELECT
    s.student_id,
    s.name AS student_name,
    d.department_name
FROM students s
LEFT JOIN departments d
    ON s.department_id = d.department_id
ORDER BY s.student_id;

-- ==================================================
-- STEP 13: Aliases Example
-- ==================================================

/*
s = students
d = departments

Aliases make queries shorter
and easier to read.
*/

SELECT
    s.name,
    d.department_name
FROM students AS s
JOIN departments AS d
    ON s.department_id = d.department_id;

-- ==================================================
-- PRACTICE TASKS
-- ==================================================

/*

Task 1:
Find all students from EEE department.

Task 2:
Find all students without departments.

Task 3:
Show all departments and
their student counts.

Task 4:
Show all students sorted by name.

Task 5:
Find all students of BBA department.

Task 6:
Display student name and department.

Task 7:
Use LEFT JOIN to show all students.

*/

-- ==================================================
-- END OF FILE
-- ==================================================