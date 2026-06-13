/*
====================================================
 FILE: 04-constraints-and-primary-keys.sql
 TOPIC: Constraints and Primary Keys
 DATABASE: PostgreSQL
====================================================
*/

-- ==================================================
-- STEP 1: PRIMARY KEY Constraint
-- ==================================================

/*
Primary Key Rules:

1. Must be UNIQUE
2. Cannot be NULL
3. One Primary Key per table

Used to uniquely identify each row.
*/

CREATE TABLE students (

    student_id INT PRIMARY KEY,

    name VARCHAR(100)

);

-- Valid Insert

INSERT INTO students
VALUES (101, 'Rahim');

INSERT INTO students
VALUES (102, 'Karim');

-- View Data

SELECT *
FROM students;


-- ==================================================
-- INVALID EXAMPLE
-- Duplicate Primary Key
-- ==================================================

/*

This will fail because
student_id = 101 already exists

INSERT INTO students
VALUES (101, 'Jannat');

*/


-- ==================================================
-- INVALID EXAMPLE
-- NULL Primary Key
-- ==================================================

/*

This will fail because
Primary Key cannot be NULL

INSERT INTO students
VALUES (NULL, 'Hasan');

*/


-- ==================================================
-- STEP 2: NOT NULL Constraint
-- ==================================================

/*
NOT NULL ensures that a column
must contain a value.
*/

CREATE TABLE employees (

    employee_id SERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    department VARCHAR(100)

);

-- Valid

INSERT INTO employees(
    name,
    department
)
VALUES
(
    'Rahim',
    'IT'
);

-- Invalid

/*

INSERT INTO employees(
    name,
    department
)
VALUES
(
    NULL,
    'HR'
);

*/


-- ==================================================
-- STEP 3: UNIQUE Constraint
-- ==================================================

/*
UNIQUE prevents duplicate values.
*/

CREATE TABLE users (

    user_id SERIAL PRIMARY KEY,

    email VARCHAR(255) UNIQUE

);

-- Valid

INSERT INTO users(email)
VALUES ('rahim@gmail.com');

INSERT INTO users(email)
VALUES ('karim@gmail.com');

-- Invalid

/*

INSERT INTO users(email)
VALUES ('rahim@gmail.com');

*/


-- ==================================================
-- STEP 4: CHECK Constraint
-- ==================================================

/*
CHECK applies custom validation rules.
*/

CREATE TABLE university_students (

    student_id INT PRIMARY KEY,

    name VARCHAR(100),

    age INT CHECK(age >= 18)

);

-- Valid

INSERT INTO university_students
VALUES
(
    101,
    'Rahim',
    20
);

-- Invalid

/*

INSERT INTO university_students
VALUES
(
    102,
    'Karim',
    15
);

*/


-- ==================================================
-- STEP 5: DEFAULT Constraint
-- ==================================================

/*
DEFAULT provides a value automatically
when no value is supplied.
*/

CREATE TABLE accounts (

    account_id SERIAL PRIMARY KEY,

    username VARCHAR(100),

    is_active BOOLEAN DEFAULT TRUE

);

-- is_active automatically becomes TRUE

INSERT INTO accounts(username)
VALUES ('rahim');

SELECT *
FROM accounts;


-- ==================================================
-- STEP 6: Composite Primary Key
-- ==================================================

/*
Multiple columns together form
a Primary Key.
*/

CREATE TABLE enrollments (

    student_id INT,

    course_id INT,

    PRIMARY KEY (
        student_id,
        course_id
    )

);

-- Valid

INSERT INTO enrollments
VALUES (101, 1);

INSERT INTO enrollments
VALUES (101, 2);

-- Invalid

/*

INSERT INTO enrollments
VALUES (101, 1);

*/


-- ==================================================
-- STEP 7: Foreign Key Constraint
-- ==================================================

/*
Foreign Key creates relationships
between tables.
*/

CREATE TABLE departments (

    department_id INT PRIMARY KEY,

    department_name VARCHAR(100)

);

INSERT INTO departments
VALUES
(1, 'CSE'),
(2, 'EEE');


CREATE TABLE teachers (

    teacher_id INT PRIMARY KEY,

    teacher_name VARCHAR(100),

    department_id INT,

    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)

);

-- Valid

INSERT INTO teachers
VALUES
(
    101,
    'Tanvir',
    1
);

-- Invalid

/*

INSERT INTO teachers
VALUES
(
    102,
    'Hasan',
    99
);

*/

-- Department 99 does not exist


-- ==================================================
-- STEP 8: Multiple Constraints Together
-- ==================================================

/*
Real-world table using
multiple constraints.
*/

CREATE TABLE customers (

    customer_id SERIAL PRIMARY KEY,

    full_name VARCHAR(100) NOT NULL,

    email VARCHAR(255) UNIQUE NOT NULL,

    age INT CHECK(age >= 18),

    is_active BOOLEAN DEFAULT TRUE

);

-- Valid

INSERT INTO customers(
    full_name,
    email,
    age
)
VALUES
(
    'Rahim Uddin',
    'rahim@gmail.com',
    25
);

SELECT *
FROM customers;


-- ==================================================
-- STEP 9: Constraint Information
-- ==================================================

/*
Table contains:

PRIMARY KEY
NOT NULL
UNIQUE
CHECK
DEFAULT
FOREIGN KEY

These constraints help:

✔ Maintain Data Integrity
✔ Prevent Invalid Data
✔ Avoid Duplicate Records
✔ Enforce Relationships
*/


-- ==================================================
-- PRACTICE TASKS
-- ==================================================

/*
Task 1:
Create a products table with:

product_id -> Primary Key
product_name -> Not Null
price -> Check(price > 0)

*/


/*
Task 2:
Create a users table with:

email -> Unique
is_verified -> Default False

*/


/*
Task 3:
Create categories and products tables.

Use Foreign Key relationship.

*/


-- ==================================================
-- END OF FILE
-- ==================================================