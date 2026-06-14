/*
====================================================
 FILE: 10-relationships-and-seed-data.sql
 TOPIC: Relationships and Seed Data
 DATABASE: PostgreSQL
====================================================
*/

-- ==================================================
-- CLEANUP (DROP TABLES IF EXISTS)
-- ==================================================

/*
Drop child tables first because they
depend on parent tables via foreign keys.
*/

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS passports;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS persons;

-- ==================================================
-- 1. ONE-TO-ONE RELATIONSHIP (1:1)
-- ==================================================

/*
Example:

Person ↔ Passport

One person has one passport.
One passport belongs to one person.
*/

CREATE TABLE persons (

    person_id SERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL

);

CREATE TABLE passports (

    passport_id VARCHAR(20) PRIMARY KEY,

    person_id INT UNIQUE,

    issue_country VARCHAR(100),

    FOREIGN KEY (person_id)
        REFERENCES persons(person_id)

);

-- ==================================================
-- Seed Data for One-to-One
-- ==================================================

INSERT INTO persons(name)
VALUES
('Rahim'),
('Karim');

INSERT INTO passports(
    passport_id,
    person_id,
    issue_country
)
VALUES
('BD12345', 1, 'Bangladesh'),
('BD67890', 2, 'Bangladesh');

-- View Relationship

SELECT
    p.person_id,
    p.name,
    pp.passport_id,
    pp.issue_country
FROM persons p
JOIN passports pp
    ON p.person_id = pp.person_id;

-- ==================================================
-- 2. ONE-TO-MANY RELATIONSHIP (1:N)
-- ==================================================

/*
Example:

Department → Students

One department has many students.
One student belongs to one department.
*/

CREATE TABLE departments (

    department_id SERIAL PRIMARY KEY,

    department_name VARCHAR(100) UNIQUE NOT NULL

);

CREATE TABLE students (

    student_id SERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    email VARCHAR(255) UNIQUE,

    department_id INT,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)

);

-- ==================================================
-- Seed Data for Departments
-- ==================================================

INSERT INTO departments(department_name)
VALUES
('CSE'),
('EEE'),
('BBA');

-- ==================================================
-- Seed Data for Students
-- ==================================================

INSERT INTO students(
    name,
    email,
    department_id
)
VALUES
('Rahim', 'rahim@gmail.com', 1),
('Karim', 'karim@gmail.com', 1),
('Hasan', 'hasan@gmail.com', 2),
('Nusrat', 'nusrat@gmail.com', 3);

-- View One-to-Many Relationship

SELECT
    s.student_id,
    s.name,
    d.department_name
FROM students s
JOIN departments d
    ON s.department_id = d.department_id;

-- ==================================================
-- 3. MANY-TO-MANY RELATIONSHIP (M:N)
-- ==================================================

/*
Example:

Students ↔ Courses

A student can take many courses.
A course can have many students.

Solution:
Use a Junction Table (Enrollments)
*/

CREATE TABLE courses (

    course_id SERIAL PRIMARY KEY,

    course_name VARCHAR(100) NOT NULL

);

CREATE TABLE enrollments (

    student_id INT,

    course_id INT,

    enrolled_at TIMESTAMP
    DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (
        student_id,
        course_id
    ),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
        ON DELETE CASCADE

);

-- ==================================================
-- Seed Data for Courses
-- ==================================================

INSERT INTO courses(course_name)
VALUES
('DBMS'),
('OOP'),
('Algorithms'),
('Operating Systems');

-- ==================================================
-- Seed Data for Enrollments
-- ==================================================

INSERT INTO enrollments(
    student_id,
    course_id
)
VALUES
(1, 1), -- Rahim → DBMS
(1, 2), -- Rahim → OOP
(2, 1), -- Karim → DBMS
(2, 3), -- Karim → Algorithms
(3, 2), -- Hasan → OOP
(4, 4); -- Nusrat → Operating Systems

-- ==================================================
-- View Many-to-Many Relationship
-- ==================================================

SELECT
    s.name AS student_name,
    c.course_name
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN courses c
    ON e.course_id = c.course_id
ORDER BY s.name;

-- ==================================================
-- Example: Find Courses Taken by Rahim
-- ==================================================

SELECT
    s.name,
    c.course_name
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN courses c
    ON e.course_id = c.course_id
WHERE s.name = 'Rahim';

-- ==================================================
-- Example: Find Students in DBMS Course
-- ==================================================

SELECT
    c.course_name,
    s.name
FROM enrollments e
JOIN students s
    ON e.student_id = s.student_id
JOIN courses c
    ON e.course_id = c.course_id
WHERE c.course_name = 'DBMS';

-- ==================================================
-- Seed Data Purpose
-- ==================================================

/*

Seed Data is used for:

✔ Development
✔ Testing
✔ Demo Purposes
✔ Local Environment Setup

Usually project structure:

database/
│
├── schema.sql
├── seed.sql
└── queries.sql

*/

-- ==================================================
-- FINAL DATA CHECK
-- ==================================================

SELECT * FROM persons;
SELECT * FROM passports;

SELECT * FROM departments;
SELECT * FROM students;

SELECT * FROM courses;
SELECT * FROM enrollments;

-- ==================================================
-- PRACTICE TASKS
-- ==================================================

/*

Task 1:
Add a new department named "Physics".

Task 2:
Insert a student into Physics department.

Task 3:
Create a new course named "Machine Learning".

Task 4:
Enroll Rahim into Machine Learning.

Task 5:
Find all students of CSE department.

Task 6:
Find all courses taken by Karim.

Task 7:
Find all students enrolled in OOP.

*/

-- ==================================================
-- END OF FILE
-- ==================================================