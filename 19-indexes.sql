/*
====================================================
 FILE: 19-indexes.sql
 TOPIC: Indexes in PostgreSQL
 DATABASE: PostgreSQL
====================================================

An Index is a special database object that helps
PostgreSQL find rows much faster.

Without Index:
---------------
Full Table Scan

With Index:
-----------
Index Scan

Advantages:
✔ Faster SELECT
✔ Faster WHERE
✔ Faster JOIN
✔ Faster ORDER BY

Disadvantages:
✘ Extra Storage
✘ Slower INSERT
✘ Slower UPDATE
✘ Slower DELETE
*/

-- ==================================================
-- STEP 1: Drop Existing Table
-- ==================================================

DROP TABLE IF EXISTS students;

-- ==================================================
-- STEP 2: Create Students Table
-- ==================================================

CREATE TABLE students (

    student_id SERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    email VARCHAR(100) UNIQUE,

    department VARCHAR(50),

    city VARCHAR(50),

    gpa DECIMAL(3,2),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

-- ==================================================
-- STEP 3: Insert Sample Data
-- ==================================================

INSERT INTO students
(name,email,department,city,gpa)
VALUES
('Rahim','rahim@gmail.com','CSE','Dhaka',3.80),
('Karim','karim@gmail.com','CSE','Dhaka',3.50),
('Hasan','hasan@gmail.com','EEE','Chattogram',3.70),
('Jannat','jannat@gmail.com','BBA','Sylhet',3.90),
('Mim','mim@gmail.com','CSE','Dhaka',3.60),
('Sakib','sakib@gmail.com','EEE','Khulna',3.40),
('Nusrat','nusrat@gmail.com','BBA','Rajshahi',3.85);

-- ==================================================
-- STEP 4: View All Data
-- ==================================================

SELECT *
FROM students;

-- ==================================================
-- PRIMARY KEY INDEX
-- ==================================================

/*
PostgreSQL automatically creates
a UNIQUE B-Tree Index
for PRIMARY KEY.
*/

-- Verify Existing Indexes

SELECT *
FROM pg_indexes
WHERE tablename = 'students';

-- ==================================================
-- UNIQUE INDEX
-- ==================================================

/*
PostgreSQL automatically creates
a UNIQUE Index
for UNIQUE constraints.
*/

-- Email already has a UNIQUE Index.

-- ==================================================
-- CREATE SIMPLE INDEX
-- ==================================================

CREATE INDEX idx_students_name
ON students(name);

-- Search by Name

SELECT *
FROM students
WHERE name = 'Rahim';

-- ==================================================
-- CREATE INDEX ON DEPARTMENT
-- ==================================================

CREATE INDEX idx_students_department
ON students(department);

SELECT *
FROM students
WHERE department = 'CSE';

-- ==================================================
-- CREATE INDEX ON GPA
-- ==================================================

CREATE INDEX idx_students_gpa
ON students(gpa);

SELECT *
FROM students
WHERE gpa > 3.70;

-- ==================================================
-- COMPOSITE INDEX
-- ==================================================

/*
Useful when queries
filter by multiple columns.
*/

CREATE INDEX idx_name_department
ON students(name, department);

SELECT *
FROM students
WHERE name = 'Rahim'
AND department = 'CSE';

-- ==================================================
-- PARTIAL INDEX
-- ==================================================

/*
Only indexes rows
matching the condition.
*/

CREATE INDEX idx_cse_students
ON students(name)
WHERE department = 'CSE';

SELECT *
FROM students
WHERE department = 'CSE'
AND name = 'Rahim';

-- ==================================================
-- EXPRESSION INDEX
-- ==================================================

/*
Useful for case-insensitive search.
*/

CREATE INDEX idx_lower_email
ON students(LOWER(email));

SELECT *
FROM students
WHERE LOWER(email) = 'rahim@gmail.com';

-- ==================================================
-- HASH INDEX
-- ==================================================

/*
Best for equality (=) searches.

Note:
B-Tree is usually sufficient.
Hash indexes are less commonly used.
*/

CREATE INDEX idx_hash_email
ON students
USING HASH(email);

SELECT *
FROM students
WHERE email = 'rahim@gmail.com';

-- ==================================================
-- INDEX WITH ORDER BY
-- ==================================================

SELECT *
FROM students
ORDER BY gpa DESC;

-- ==================================================
-- INDEX WITH JOIN
-- ==================================================

DROP TABLE IF EXISTS departments;

CREATE TABLE departments (

    department_id SERIAL PRIMARY KEY,

    department_name VARCHAR(50) UNIQUE

);

INSERT INTO departments(department_name)
VALUES
('CSE'),
('EEE'),
('BBA');

ALTER TABLE students
ADD COLUMN department_id INT;

UPDATE students
SET department_id =
CASE
    WHEN department='CSE' THEN 1
    WHEN department='EEE' THEN 2
    WHEN department='BBA' THEN 3
END;

ALTER TABLE students
ADD CONSTRAINT fk_department
FOREIGN KEY(department_id)
REFERENCES departments(department_id);

-- Create Index on Foreign Key

CREATE INDEX idx_department_id
ON students(department_id);

-- JOIN Query

SELECT

    s.student_id,

    s.name,

    d.department_name

FROM students s

JOIN departments d

ON s.department_id = d.department_id;

-- ==================================================
-- CHECK QUERY EXECUTION PLAN
-- ==================================================

/*
EXPLAIN
Shows estimated execution plan.

EXPLAIN ANALYZE
Executes query and shows actual plan.
*/

EXPLAIN

SELECT *
FROM students
WHERE email='rahim@gmail.com';

-----------------------------------------------------

EXPLAIN ANALYZE

SELECT *
FROM students
WHERE email='rahim@gmail.com';

-- ==================================================
-- DROP INDEX
-- ==================================================

DROP INDEX idx_students_name;

-- ==================================================
-- RECREATE INDEX
-- ==================================================

CREATE INDEX idx_students_name
ON students(name);

-- ==================================================
-- LIST ALL INDEXES
-- ==================================================

SELECT *

FROM pg_indexes

WHERE schemaname='public';

-- ==================================================
-- SHOW INDEXES FOR STUDENTS TABLE
-- ==================================================

SELECT *

FROM pg_indexes

WHERE tablename='students';

-- ==================================================
-- COMMON SEARCH QUERIES
-- ==================================================

-- Search by Email

SELECT *
FROM students
WHERE email='rahim@gmail.com';

-----------------------------------------------------

-- Search by Department

SELECT *
FROM students
WHERE department='CSE';

-----------------------------------------------------

-- Search by GPA

SELECT *
FROM students
WHERE gpa > 3.70;

-----------------------------------------------------

-- Search by Name

SELECT *
FROM students
WHERE name='Karim';

-----------------------------------------------------

-- Order by GPA

SELECT *
FROM students
ORDER BY gpa DESC;

-----------------------------------------------------

-- Join Query

SELECT

    s.name,

    d.department_name

FROM students s

JOIN departments d

ON s.department_id=d.department_id;

-- ==================================================
-- PRACTICE TASKS
-- ==================================================

/*

Task 1
-------
Create an index on city.

Task 2
-------
Create a composite index
on department and GPA.

Task 3
-------
Create a partial index
for only BBA students.

Task 4
-------
Create an expression index
using LOWER(name).

Task 5
-------
Display all indexes
of the students table.

Task 6
-------
Drop idx_students_gpa.

Task 7
-------
Recreate idx_students_gpa.

Task 8
-------
Run EXPLAIN
for searching by email.

Task 9
-------
Run EXPLAIN ANALYZE
for searching by department.

Task 10
--------
Find which indexes were
automatically created by PostgreSQL.

*/

-- ==================================================
-- END OF FILE
-- ==================================================