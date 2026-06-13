/*
====================================================
 PostgreSQL: Creating Databases & Schemas
 File: 01-creating-databases-and-schemas.sql
====================================================
*/

/*
====================================================
 STEP 1: Create a New Database
====================================================
*/

-- Create a database named university_db
CREATE DATABASE university_db;

-- Connect to the database from psql
-- \c university_db


/*
====================================================
 STEP 2: Check Current Database
====================================================
*/

SELECT current_database();


/*
====================================================
 STEP 3: Create Schemas
====================================================
*/

-- Academic related objects
CREATE SCHEMA academic;

-- Human Resources related objects
CREATE SCHEMA hr;

-- Finance related objects
CREATE SCHEMA finance;


/*
====================================================
 STEP 4: View All Schemas
====================================================
*/

SELECT schema_name
FROM information_schema.schemata;


/*
====================================================
 STEP 5: Create Tables Inside Academic Schema
====================================================
*/

CREATE TABLE academic.students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE academic.courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credit INTEGER NOT NULL
);


/*
====================================================
 STEP 6: Create Enrollment Table
====================================================
*/

CREATE TABLE academic.enrollments (
    enrollment_id SERIAL PRIMARY KEY,

    student_id INTEGER NOT NULL,

    course_id INTEGER NOT NULL,

    enrollment_date DATE DEFAULT CURRENT_DATE,

    CONSTRAINT fk_student
        FOREIGN KEY(student_id)
        REFERENCES academic.students(student_id),

    CONSTRAINT fk_course
        FOREIGN KEY(course_id)
        REFERENCES academic.courses(course_id)
);


/*
====================================================
 STEP 7: Create Tables Inside HR Schema
====================================================
*/

CREATE TABLE hr.employees (
    employee_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    salary NUMERIC(10,2),
    hired_at DATE DEFAULT CURRENT_DATE
);


/*
====================================================
 STEP 8: Create Tables Inside Finance Schema
====================================================
*/

CREATE TABLE finance.payments (
    payment_id SERIAL PRIMARY KEY,

    amount NUMERIC(10,2) NOT NULL,

    payment_date DATE DEFAULT CURRENT_DATE
);


/*
====================================================
 STEP 9: Insert Sample Student Data
====================================================
*/

INSERT INTO academic.students
(name, email)
VALUES
('Rahim', 'rahim@gmail.com'),
('Karim', 'karim@gmail.com'),
('Jannat', 'jannat@gmail.com');


/*
====================================================
 STEP 10: Insert Course Data
====================================================
*/

INSERT INTO academic.courses
(course_name, credit)
VALUES
('Database Management System', 3),
('Object Oriented Programming', 3),
('Data Structures', 4);


/*
====================================================
 STEP 11: Insert Enrollment Data
====================================================
*/

INSERT INTO academic.enrollments
(student_id, course_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3);


/*
====================================================
 STEP 12: Query Student Data
====================================================
*/

SELECT *
FROM academic.students;


/*
====================================================
 STEP 13: Query Course Data
====================================================
*/

SELECT *
FROM academic.courses;


/*
====================================================
 STEP 14: Query Enrollment Data
====================================================
*/

SELECT *
FROM academic.enrollments;


/*
====================================================
 STEP 15: Join Example
====================================================
*/

SELECT
    s.student_id,
    s.name,
    c.course_name
FROM academic.enrollments e
INNER JOIN academic.students s
    ON e.student_id = s.student_id
INNER JOIN academic.courses c
    ON e.course_id = c.course_id;


/*
====================================================
 STEP 16: Set Default Schema
====================================================
*/

SET search_path TO academic;

-- Now PostgreSQL automatically looks inside
-- the academic schema

SELECT *
FROM students;


/*
====================================================
 STEP 17: Create Another Schema
====================================================
*/

CREATE SCHEMA alumni;


/*
====================================================
 STEP 18: Same Table Name In Different Schemas
====================================================
*/

CREATE TABLE alumni.students (
    alumni_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    graduation_year INTEGER
);


/*
====================================================
 STEP 19: Rename Schema
====================================================
*/

ALTER SCHEMA alumni
RENAME TO graduates;


/*
====================================================
 STEP 20: Check Search Path
====================================================
*/

SHOW search_path;


/*
====================================================
 STEP 21: Drop Schema
====================================================
*/

-- Delete schema and everything inside it

-- DROP SCHEMA graduates CASCADE;


/*
====================================================
 STEP 22: Drop Database
====================================================
*/

-- Must disconnect from the database first

-- DROP DATABASE university_db;


/*
====================================================
 END OF FILE
====================================================
*/