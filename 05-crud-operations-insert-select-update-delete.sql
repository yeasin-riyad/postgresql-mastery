/*
====================================================
 FILE: 05-crud-operations-insert-select-update-delete.sql
 TOPIC: INSERT, SELECT, UPDATE, DELETE (CRUD)
 DATABASE: PostgreSQL
====================================================
*/

-- ==================================================
-- STEP 1: Create Sample Table
-- ==================================================

/*
We will use a Students table for all CRUD operations
*/

CREATE TABLE students (

    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50)

);

-- ==================================================
-- STEP 2: INSERT (Create Data)
-- ==================================================

/*
INSERT = Add new records into the table
*/

INSERT INTO students (student_id, name, department)
VALUES (101, 'Rahim', 'CSE');

INSERT INTO students (student_id, name, department)
VALUES (102, 'Karim', 'EEE');

-- Insert Multiple Rows at Once

INSERT INTO students (student_id, name, department)
VALUES
(103, 'Jannat', 'CSE'),
(104, 'Hasan', 'BBA'),
(105, 'Nusrat', 'CSE');

-- Insert Without Column Names (Must follow order)

INSERT INTO students
VALUES (106, 'Sakib', 'EEE');


-- ==================================================
-- STEP 3: SELECT (Read Data)
-- ==================================================

/*
SELECT = Retrieve data from table
*/

-- Select all columns
SELECT *
FROM students;

-- Select specific columns
SELECT name, department
FROM students;

-- Select with WHERE condition
SELECT *
FROM students
WHERE department = 'CSE';

-- Select with alias
SELECT
    name AS student_name,
    department AS dept
FROM students;


-- ==================================================
-- STEP 4: UPDATE (Modify Data)
-- ==================================================

/*
UPDATE = Modify existing records
IMPORTANT: Always use WHERE to avoid updating all rows
*/

-- Update single record
UPDATE students
SET department = 'Computer Science'
WHERE student_id = 101;

-- Update multiple columns
UPDATE students
SET
    name = 'Md. Rahim',
    department = 'CSE'
WHERE student_id = 101;


-- ==================================================
-- DANGEROUS UPDATE (DO NOT RUN WITHOUT WHERE)
-- ==================================================

/*

UPDATE students
SET department = 'Unknown';

This will update ALL rows in the table!
*/


-- ==================================================
-- STEP 5: DELETE (Remove Data)
-- ==================================================

/*
DELETE = Remove records from table
IMPORTANT: Always use WHERE to avoid deleting all data
*/

-- Delete single record
DELETE FROM students
WHERE student_id = 105;

-- View remaining data
SELECT *
FROM students;


-- ==================================================
-- DANGEROUS DELETE (DO NOT RUN WITHOUT WHERE)
-- ==================================================

/*

DELETE FROM students;

This will delete ALL rows in the table!
*/


-- ==================================================
-- STEP 6: DELETE vs DROP (IMPORTANT CONCEPT)
-- ==================================================

/*

DELETE:
- Removes data only
- Table remains

DROP:
- Removes entire table
- Structure + data both removed

Example:

DROP TABLE students;

*/


-- ==================================================
-- STEP 7: FINAL DATA CHECK
-- ==================================================

SELECT *
FROM students;


-- ==================================================
-- END OF FILE
-- ==================================================