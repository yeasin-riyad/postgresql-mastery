/*
====================================================
 FILE: 06-where-clause-and-filtering.sql
 TOPIC: SQL WHERE Clause & Filtering
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
    gpa DECIMAL(3,2),
    phone VARCHAR(20)

);

-- ==================================================
-- STEP 2: Insert Sample Data
-- ==================================================

INSERT INTO students
VALUES
(101, 'Rahim',  'CSE', 3.80, NULL),
(102, 'Karim',  'EEE', 3.50, '01711111111'),
(103, 'Jannat', 'CSE', 3.90, NULL),
(104, 'Hasan',  'BBA', 3.20, '01822222222'),
(105, 'Nusrat', 'CSE', 3.70, '01933333333');

-- View All Data

SELECT *
FROM students;

-- ==================================================
-- STEP 3: Equal (=)
-- ==================================================

/*
Find all students from CSE department
*/

SELECT *
FROM students
WHERE department = 'CSE';

-- ==================================================
-- STEP 4: Not Equal (!=)
-- ==================================================

/*
Find students who are NOT from CSE
*/

SELECT *
FROM students
WHERE department != 'CSE';

-- Alternative syntax

SELECT *
FROM students
WHERE department <> 'CSE';

-- ==================================================
-- STEP 5: Greater Than (>)
-- ==================================================

/*
Find students with GPA greater than 3.70
*/

SELECT *
FROM students
WHERE gpa > 3.70;

-- ==================================================
-- STEP 6: Less Than (<)
-- ==================================================

SELECT *
FROM students
WHERE gpa < 3.50;

-- ==================================================
-- STEP 7: Greater Than or Equal (>=)
-- ==================================================

SELECT *
FROM students
WHERE gpa >= 3.80;

-- ==================================================
-- STEP 8: Less Than or Equal (<=)
-- ==================================================

SELECT *
FROM students
WHERE gpa <= 3.50;

-- ==================================================
-- STEP 9: AND Operator
-- ==================================================

/*
Both conditions must be TRUE
*/

SELECT *
FROM students
WHERE department = 'CSE'
AND gpa > 3.75;

-- ==================================================
-- STEP 10: OR Operator
-- ==================================================

/*
At least one condition must be TRUE
*/

SELECT *
FROM students
WHERE department = 'EEE'
OR department = 'BBA';

-- ==================================================
-- STEP 11: IN Operator
-- ==================================================

/*
Find students from multiple departments
*/

SELECT *
FROM students
WHERE department IN (
    'CSE',
    'EEE',
    'BBA'
);

-- Equivalent OR version

SELECT *
FROM students
WHERE department = 'CSE'
OR department = 'EEE'
OR department = 'BBA';

-- ==================================================
-- STEP 12: BETWEEN Operator
-- ==================================================

/*
Find students whose GPA is between
3.50 and 3.90
*/

SELECT *
FROM students
WHERE gpa BETWEEN 3.50 AND 3.90;

-- Equivalent version

SELECT *
FROM students
WHERE gpa >= 3.50
AND gpa <= 3.90;

-- ==================================================
-- STEP 13: LIKE Operator
-- ==================================================

/*
Starts with R
*/

SELECT *
FROM students
WHERE name LIKE 'R%';

-- Ends with m

SELECT *
FROM students
WHERE name LIKE '%m';

-- Contains "im"

SELECT *
FROM students
WHERE name LIKE '%im%';

-- ==================================================
-- STEP 14: ILIKE Operator (PostgreSQL)
-- ==================================================

/*
Case-insensitive search
*/

SELECT *
FROM students
WHERE name ILIKE 'rahim';

-- ==================================================
-- STEP 15: NOT Operator
-- ==================================================

SELECT *
FROM students
WHERE NOT department = 'CSE';

-- ==================================================
-- STEP 16: IS NULL
-- ==================================================

/*
Find students with no phone number
*/

SELECT *
FROM students
WHERE phone IS NULL;

-- ==================================================
-- STEP 17: IS NOT NULL
-- ==================================================

/*
Find students who have phone numbers
*/

SELECT *
FROM students
WHERE phone IS NOT NULL;

-- ==================================================
-- STEP 18: Complex Filtering
-- ==================================================

/*
Department must be:
CSE OR EEE

AND

GPA >= 3.50
*/

SELECT *
FROM students
WHERE
(
    department = 'CSE'
    OR department = 'EEE'
)
AND gpa >= 3.50;

-- ==================================================
-- STEP 19: WHERE with UPDATE
-- ==================================================

/*
Update only one student
*/

UPDATE students
SET gpa = 4.00
WHERE student_id = 101;

-- Verify

SELECT *
FROM students
WHERE student_id = 101;

-- ==================================================
-- STEP 20: WHERE with DELETE
-- ==================================================

/*
Delete only one student
*/

DELETE FROM students
WHERE student_id = 105;

-- Verify

SELECT *
FROM students;

-- ==================================================
-- DANGEROUS EXAMPLES (DO NOT RUN)
-- ==================================================

/*

-- Updates every row

UPDATE students
SET department = 'Unknown';


-- Deletes every row

DELETE FROM students;

*/

-- ==================================================
-- PRACTICE TASKS
-- ==================================================

/*
Task 1:
Find all students from CSE.

Task 2:
Find all students whose GPA > 3.50.

Task 3:
Find students from CSE or EEE.

Task 4:
Find students whose name starts with 'K'.

Task 5:
Find students whose phone number is NULL.

Task 6:
Update Hasan's GPA to 3.75.

Task 7:
Delete Karim from the table.
*/

-- ==================================================
-- END OF FILE
-- ==================================================