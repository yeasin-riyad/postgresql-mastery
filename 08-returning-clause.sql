/*
====================================================
 FILE: 09-returning-clause.sql
 TOPIC: PostgreSQL RETURNING Clause
 DATABASE: PostgreSQL
====================================================
*/

-- ==================================================
-- STEP 1: Create Table
-- ==================================================

DROP TABLE IF EXISTS students;

CREATE TABLE students (

    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    gpa DECIMAL(3,2)

);

-- ==================================================
-- STEP 2: INSERT without RETURNING
-- ==================================================

INSERT INTO students (
    name,
    email,
    gpa
)
VALUES (
    'Rahim',
    'rahim@gmail.com',
    3.80
);

-- Output:
-- INSERT 0 1

/*
Problem:
We do not know:

1. Generated student_id
2. Inserted row data
*/


-- ==================================================
-- STEP 3: INSERT with RETURNING *
-- ==================================================

INSERT INTO students (
    name,
    email,
    gpa
)
VALUES (
    'Karim',
    'karim@gmail.com',
    3.50
)
RETURNING *;

-- Returns the complete inserted row


-- ==================================================
-- STEP 4: RETURN Specific Columns
-- ==================================================

INSERT INTO students (
    name,
    email,
    gpa
)
VALUES (
    'Jannat',
    'jannat@gmail.com',
    3.90
)
RETURNING
    student_id,
    name;

-- Returns only selected columns


-- ==================================================
-- STEP 5: View Current Data
-- ==================================================

SELECT *
FROM students;


-- ==================================================
-- STEP 6: UPDATE without RETURNING
-- ==================================================

UPDATE students
SET gpa = 4.00
WHERE student_id = 1;

-- Output:
-- UPDATE 1


-- ==================================================
-- STEP 7: UPDATE with RETURNING *
-- ==================================================

UPDATE students
SET gpa = 3.95
WHERE student_id = 2
RETURNING *;

-- Returns updated row


-- ==================================================
-- STEP 8: UPDATE Returning Selected Columns
-- ==================================================

UPDATE students
SET gpa = 3.85
WHERE student_id = 3
RETURNING
    student_id,
    name,
    gpa;

-- ==================================================
-- STEP 9: UPDATE with Aliases
-- ==================================================

UPDATE students
SET gpa = 4.00
WHERE student_id = 1
RETURNING
    student_id AS id,
    name AS student_name,
    gpa;

-- ==================================================
-- STEP 10: RETURNING Expressions
-- ==================================================

INSERT INTO students (
    name,
    email,
    gpa
)
VALUES (
    'Sakib',
    'sakib@gmail.com',
    3.70
)
RETURNING
    student_id,
    name,
    gpa,
    gpa * 25 AS percentage;

-- Example:
-- 3.70 × 25 = 92.50


-- ==================================================
-- STEP 11: DELETE without RETURNING
-- ==================================================

DELETE FROM students
WHERE student_id = 2;

-- Output:
-- DELETE 1


-- ==================================================
-- STEP 12: DELETE with RETURNING *
-- ==================================================

DELETE FROM students
WHERE student_id = 3
RETURNING *;

-- Returns deleted row


-- ==================================================
-- STEP 13: DELETE Returning Specific Columns
-- ==================================================

DELETE FROM students
WHERE student_id = 4
RETURNING
    student_id,
    name;

-- Useful for audit logs


-- ==================================================
-- STEP 14: Real Backend Example
-- ==================================================

/*
Node.js Example:

const result = await pool.query(
`
INSERT INTO students(name,email)
VALUES($1,$2)
RETURNING *
`,
['Rahim', 'rahim@gmail.com']
);

console.log(result.rows[0]);

*/


-- ==================================================
-- STEP 15: Why RETURNING?
-- ==================================================

/*

Without RETURNING:

INSERT
   ↓
SELECT

Requires 2 queries ❌


With RETURNING:

INSERT + RETURNING

Requires only 1 query ✅

Benefits:

✔ Faster
✔ Cleaner code
✔ Less database round trips
✔ Better API design

*/


-- ==================================================
-- STEP 16: Final Data Check
-- ==================================================

SELECT *
FROM students;


-- ==================================================
-- PRACTICE TASKS
-- ==================================================

/*

Task 1:
Insert a new student and
return the generated ID.

Task 2:
Update GPA of Rahim
and return the updated row.

Task 3:
Delete a student
and return deleted data.

Task 4:
Insert a student and
return GPA percentage
using expression.

Task 5:
Use aliases in RETURNING.

*/


-- ==================================================
-- END OF FILE
-- ==================================================