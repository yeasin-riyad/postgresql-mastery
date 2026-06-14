/*
====================================================
 FILE: 12-table-aliases.sql
 TOPIC: Table Aliases in SQL
 DATABASE: PostgreSQL
====================================================
*/

-- ==================================================
-- STEP 1: Clean Up Existing Tables
-- ==================================================

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS departments;

-- ==================================================
-- STEP 2: Create Departments Table
-- ==================================================

CREATE TABLE departments (

    department_id SERIAL PRIMARY KEY,

    department_name VARCHAR(100)
    NOT NULL UNIQUE

);

-- ==================================================
-- STEP 3: Create Students Table
-- ==================================================

CREATE TABLE students (

    student_id SERIAL PRIMARY KEY,

    name VARCHAR(100)
    NOT NULL,

    email VARCHAR(255)
    UNIQUE,

    department_id INT,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)

);

-- ==================================================
-- STEP 4: Insert Seed Data
-- ==================================================

INSERT INTO departments (
    department_name
)
VALUES
('CSE'),
('EEE'),
('BBA');

INSERT INTO students (
    name,
    email,
    department_id
)
VALUES
('Rahim', 'rahim@gmail.com', 1),
('Karim', 'karim@gmail.com', 1),
('Hasan', 'hasan@gmail.com', 2),
('Nusrat', 'nusrat@gmail.com', 3);

-- ==================================================
-- STEP 5: Query Without Alias
-- ==================================================

/*
Without alias we have to repeatedly
write the table name.
*/

SELECT
    students.student_id,
    students.name,
    students.email
FROM students;

-- ==================================================
-- STEP 6: Query With Table Alias
-- ==================================================

/*
students → s
*/

SELECT
    s.student_id,
    s.name,
    s.email
FROM students AS s;

-- AS keyword is optional

SELECT
    s.student_id,
    s.name
FROM students s;

-- ==================================================
-- STEP 7: JOIN Without Alias
-- ==================================================

SELECT
    students.name,
    departments.department_name
FROM students
JOIN departments
    ON students.department_id =
       departments.department_id;

-- ==================================================
-- STEP 8: JOIN With Alias
-- ==================================================

/*
students    → s
departments → d
*/

SELECT
    s.student_id,
    s.name,
    d.department_name
FROM students s
JOIN departments d
    ON s.department_id = d.department_id;

-- ==================================================
-- STEP 9: Filter Using Alias
-- ==================================================

/*
Find all students from CSE department
*/

SELECT
    s.student_id,
    s.name,
    d.department_name
FROM students s
JOIN departments d
    ON s.department_id = d.department_id
WHERE d.department_name = 'CSE';

-- ==================================================
-- STEP 10: Sorting Using Alias
-- ==================================================

SELECT
    s.student_id,
    s.name,
    d.department_name
FROM students s
JOIN departments d
    ON s.department_id = d.department_id
ORDER BY s.name ASC;

-- ==================================================
-- STEP 11: Column Alias Example
-- ==================================================

SELECT
    s.name AS student_name,
    d.department_name AS department
FROM students s
JOIN departments d
    ON s.department_id = d.department_id;

-- ==================================================
-- STEP 12: Multiple Aliases Together
-- ==================================================

SELECT
    s.student_id AS id,
    s.name AS student,
    d.department_name AS dept
FROM students s
JOIN departments d
    ON s.department_id = d.department_id;

-- ==================================================
-- STEP 13: Create Employee Table
-- ==================================================

/*
Used for Self Join example
*/

CREATE TABLE employees (

    employee_id SERIAL PRIMARY KEY,

    name VARCHAR(100)
    NOT NULL,

    manager_id INT,

    FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)

);

-- ==================================================
-- STEP 14: Insert Employee Data
-- ==================================================

INSERT INTO employees (
    name,
    manager_id
)
VALUES
('Rahim', NULL), -- Manager
('Karim', 1),
('Hasan', 1),
('Nusrat', 2);

-- ==================================================
-- STEP 15: Self Join Using Alias
-- ==================================================

/*
e = employee
m = manager

Same table joined twice.
*/

SELECT
    e.name AS employee,
    m.name AS manager
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id;

-- ==================================================
-- Expected Output
-- ==================================================

/*

employee | manager
---------+---------
Rahim    | NULL
Karim    | Rahim
Hasan    | Rahim
Nusrat   | Karim

*/

-- ==================================================
-- STEP 16: Count Students Per Department
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
-- STEP 17: Show All Data
-- ==================================================

SELECT * FROM departments;
SELECT * FROM students;
SELECT * FROM employees;

-- ==================================================
-- PRACTICE TASKS
-- ==================================================

/*

Task 1:
Use alias to show
student name and email.

Task 2:
Find all students
from EEE department.

Task 3:
Display student name
and department name.

Task 4:
Sort students by name.

Task 5:
Show employee and manager.

Task 6:
Count students in each department.

Task 7:
Use custom column aliases.

*/

-- ==================================================
-- END OF FILE
-- ==================================================