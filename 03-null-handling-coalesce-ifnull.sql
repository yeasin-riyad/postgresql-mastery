/*
====================================================
 FILE: 03-null-handling-coalesce-ifnull.sql
 TOPIC: NULL Handling with COALESCE and IFNULL
 DATABASE: PostgreSQL
====================================================
*/

-- ==================================================
-- STEP 1: Create Employees Table
-- ==================================================

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary NUMERIC(10,2),
    phone VARCHAR(20),
    office_phone VARCHAR(20),
    personal_phone VARCHAR(20),
    emergency_phone VARCHAR(20)
);

-- ==================================================
-- STEP 2: Insert Sample Data
-- ==================================================

INSERT INTO employees (
    name,
    salary,
    phone,
    office_phone,
    personal_phone,
    emergency_phone
)
VALUES
(
    'Rahim',
    50000,
    '01711111111',
    '021234567',
    NULL,
    NULL
),
(
    'Karim',
    NULL,
    NULL,
    NULL,
    '01888888888',
    NULL
),
(
    'Jannat',
    65000,
    NULL,
    NULL,
    NULL,
    '01999999999'
);

-- ==================================================
-- STEP 3: View Original Data
-- ==================================================

SELECT *
FROM employees;

-- ==================================================
-- STEP 4: COALESCE Example
-- Replace NULL Salary with 0
-- ==================================================

SELECT
    employee_id,
    name,
    salary,
    COALESCE(salary, 0) AS salary_after_coalesce
FROM employees;

-- Expected:
--
-- Rahim  -> 50000
-- Karim  -> 0
-- Jannat -> 65000


-- ==================================================
-- STEP 5: Replace NULL Phone Number
-- ==================================================

SELECT
    name,
    COALESCE(phone, 'Not Provided') AS phone_number
FROM employees;

-- Expected:
--
-- Rahim  -> 01711111111
-- Karim  -> Not Provided
-- Jannat -> Not Provided


-- ==================================================
-- STEP 6: Multiple Value COALESCE
-- Return First Available Contact Number
-- ==================================================

SELECT
    name,

    COALESCE(
        office_phone,
        personal_phone,
        emergency_phone,
        'No Contact Available'
    ) AS contact_number

FROM employees;

-- Logic:
--
-- 1. office_phone
-- 2. personal_phone
-- 3. emergency_phone
-- 4. default value


-- ==================================================
-- STEP 7: COALESCE with Text Values
-- ==================================================

SELECT
    name,
    COALESCE(phone, 'Unknown') AS user_phone
FROM employees;


-- ==================================================
-- STEP 8: COALESCE with Arithmetic Operations
-- ==================================================

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price NUMERIC(10,2),
    discount NUMERIC(10,2)
);

INSERT INTO products (
    product_name,
    price,
    discount
)
VALUES
('Laptop', 80000, 5000),
('Mouse', 1000, NULL),
('Keyboard', 2500, NULL);

-- View Products

SELECT *
FROM products;


-- ==================================================
-- WRONG APPROACH
-- NULL Discount Causes Final Price to Become NULL
-- ==================================================

SELECT
    product_name,
    price,
    discount,
    price - discount AS final_price
FROM products;

-- Mouse -> NULL
-- Keyboard -> NULL


-- ==================================================
-- CORRECT APPROACH
-- Use COALESCE
-- ==================================================

SELECT
    product_name,
    price,
    discount,

    price - COALESCE(discount, 0)
        AS final_price

FROM products;

-- Laptop  -> 75000
-- Mouse   -> 1000
-- Keyboard-> 2500


-- ==================================================
-- STEP 9: COALESCE with Aggregate Functions
-- ==================================================

SELECT
    AVG(COALESCE(salary, 0))
        AS average_salary
FROM employees;


-- ==================================================
-- STEP 10: COALESCE Inside WHERE Clause
-- ==================================================

SELECT *
FROM employees
WHERE COALESCE(salary, 0) > 40000;

-- Returns employees with salary > 40000


-- ==================================================
-- STEP 11: COALESCE with Dates
-- ==================================================

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    join_date DATE
);

INSERT INTO users(name, join_date)
VALUES
('Rahim', '2025-01-10'),
('Karim', NULL);

SELECT
    name,

    COALESCE(
        join_date,
        CURRENT_DATE
    ) AS effective_join_date

FROM users;


-- ==================================================
-- STEP 12: PostgreSQL Alternative to IFNULL
-- ==================================================

/*
PostgreSQL DOES NOT SUPPORT:

    IFNULL(value, replacement)

This works in MySQL but NOT PostgreSQL.

Wrong:

SELECT IFNULL(salary, 0)
FROM employees;

Use COALESCE instead.
*/

SELECT
    name,
    COALESCE(salary, 0)
FROM employees;


-- ==================================================
-- STEP 13: Practice Queries
-- ==================================================

-- Task 1:
-- Show employee name and salary
-- Replace NULL salary with 10000

SELECT
    name,
    COALESCE(salary, 10000)
FROM employees;


-- Task 2:
-- Show employee name and phone
-- Replace NULL phone with 'No Phone'

SELECT
    name,
    COALESCE(phone, 'No Phone')
FROM employees;


-- Task 3:
-- Show product final price
-- Handle NULL discount

SELECT
    product_name,
    price - COALESCE(discount, 0)
FROM products;


-- ==================================================
-- END OF FILE
-- ==================================================