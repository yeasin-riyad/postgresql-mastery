/*
====================================================
 FILE: 20-transactions.sql
 TOPIC: Transactions in PostgreSQL
 DATABASE: PostgreSQL
====================================================

A Transaction is a sequence of one or more SQL
statements executed as a single unit of work.

Transaction ensures:
✔ All statements succeed (COMMIT)
OR
✔ All changes are undone (ROLLBACK)

Transaction Commands:
---------------------
BEGIN
COMMIT
ROLLBACK
SAVEPOINT
ROLLBACK TO SAVEPOINT
*/

-- ==================================================
-- STEP 1: Drop Existing Table
-- ==================================================

DROP TABLE IF EXISTS accounts;

-- ==================================================
-- STEP 2: Create Accounts Table
-- ==================================================

CREATE TABLE accounts (

    account_id SERIAL PRIMARY KEY,

    account_holder VARCHAR(100) NOT NULL,

    balance DECIMAL(10,2) NOT NULL

);

-- ==================================================
-- STEP 3: Insert Sample Data
-- ==================================================

INSERT INTO accounts
(account_holder, balance)
VALUES
('Rahim',10000),
('Karim',5000),
('Mim',8000),
('Hasan',12000);

-- ==================================================
-- STEP 4: View Initial Data
-- ==================================================

SELECT *
FROM accounts;

-- ==================================================
-- STEP 5: SIMPLE TRANSACTION
-- ==================================================

/*
Transfer 1000 Tk
from Rahim to Karim
*/

BEGIN;

UPDATE accounts
SET balance = balance - 1000
WHERE account_holder = 'Rahim';

UPDATE accounts
SET balance = balance + 1000
WHERE account_holder = 'Karim';

COMMIT;

-- Verify Result

SELECT *
FROM accounts;

-- ==================================================
-- STEP 6: ROLLBACK EXAMPLE
-- ==================================================

/*
Suppose we mistakenly deducted
500 Tk from Mim.

ROLLBACK will undo it.
*/

BEGIN;

UPDATE accounts
SET balance = balance - 500
WHERE account_holder = 'Mim';

-- Check temporary result

SELECT *
FROM accounts;

ROLLBACK;

-- Verify rollback

SELECT *
FROM accounts;

-- ==================================================
-- STEP 7: SAVEPOINT EXAMPLE
-- ==================================================

BEGIN;

-- Deduct from Hasan

UPDATE accounts
SET balance = balance - 1000
WHERE account_holder = 'Hasan';

SAVEPOINT deduct_done;

-- Add money to Mim

UPDATE accounts
SET balance = balance + 1000
WHERE account_holder = 'Mim';

-- Suppose something went wrong...

ROLLBACK TO SAVEPOINT deduct_done;

-- Continue Transaction

COMMIT;

-- Verify Result

SELECT *
FROM accounts;

-- ==================================================
-- STEP 8: INSERT WITH TRANSACTION
-- ==================================================

BEGIN;

INSERT INTO accounts
(account_holder, balance)
VALUES
('Jannat',9000);

COMMIT;

SELECT *
FROM accounts;

-- ==================================================
-- STEP 9: INSERT WITH ROLLBACK
-- ==================================================

BEGIN;

INSERT INTO accounts
(account_holder, balance)
VALUES
('Temporary User',5000);

ROLLBACK;

-- User will not exist

SELECT *
FROM accounts;

-- ==================================================
-- STEP 10: UPDATE WITH COMMIT
-- ==================================================

BEGIN;

UPDATE accounts
SET balance = balance + 200
WHERE account_holder = 'Karim';

COMMIT;

SELECT *
FROM accounts;

-- ==================================================
-- STEP 11: UPDATE WITH ROLLBACK
-- ==================================================

BEGIN;

UPDATE accounts
SET balance = balance - 300
WHERE account_holder = 'Rahim';

ROLLBACK;

SELECT *
FROM accounts;

-- ==================================================
-- STEP 12: DELETE WITH ROLLBACK
-- ==================================================

BEGIN;

DELETE
FROM accounts
WHERE account_holder = 'Mim';

ROLLBACK;

SELECT *
FROM accounts;

-- ==================================================
-- STEP 13: DELETE WITH COMMIT
-- ==================================================

BEGIN;

DELETE
FROM accounts
WHERE account_holder = 'Temporary User';

COMMIT;

SELECT *
FROM accounts;

-- ==================================================
-- STEP 14: MULTIPLE OPERATIONS
-- ==================================================

BEGIN;

UPDATE accounts
SET balance = balance - 500
WHERE account_holder = 'Rahim';

UPDATE accounts
SET balance = balance + 500
WHERE account_holder = 'Karim';

INSERT INTO accounts
(account_holder, balance)
VALUES
('Sakib',7000);

COMMIT;

SELECT *
FROM accounts;

-- ==================================================
-- STEP 15: TRANSACTION WITH RETURNING
-- ==================================================

BEGIN;

UPDATE accounts

SET balance = balance + 100

WHERE account_holder = 'Rahim'

RETURNING *;

COMMIT;

-- ==================================================
-- STEP 16: CREATE ORDERS TABLE
-- ==================================================

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (

    order_id SERIAL PRIMARY KEY,

    customer_name VARCHAR(100),

    total_amount DECIMAL(10,2)

);

-- ==================================================
-- STEP 17: ORDER TRANSACTION
-- ==================================================

BEGIN;

INSERT INTO orders
(customer_name,total_amount)
VALUES
('Rahim',2500);

UPDATE accounts
SET balance = balance - 2500
WHERE account_holder = 'Rahim';

COMMIT;

SELECT *
FROM orders;

SELECT *
FROM accounts;

-- ==================================================
-- STEP 18: VIEW FINAL DATA
-- ==================================================

SELECT *
FROM accounts;

SELECT *
FROM orders;

-- ==================================================
-- STEP 19: PRACTICE TASKS
-- ==================================================

/*

Task 1
-------
Transfer 500 Tk
from Karim to Mim.

--------------------------------

Task 2
-------
Insert a new account
inside a transaction.

--------------------------------

Task 3
-------
Delete Hasan
then rollback.

--------------------------------

Task 4
-------
Increase everyone's balance
by 100 Tk
then commit.

--------------------------------

Task 5
-------
Create a SAVEPOINT
after deducting money.

--------------------------------

Task 6
-------
Rollback to SAVEPOINT.

--------------------------------

Task 7
-------
Delete all accounts
then rollback.

--------------------------------

Task 8
-------
Insert three accounts
inside one transaction.

--------------------------------

Task 9
-------
Update multiple accounts
and commit.

--------------------------------

Task 10
--------
Create an order
and deduct balance
inside one transaction.

--------------------------------

Task 11
--------
Use RETURNING with UPDATE.

--------------------------------

Task 12
--------
Explain why COMMIT
and ROLLBACK
are important.

*/

-- ==================================================
-- STEP 20: ACID SUMMARY
-- ==================================================

/*

A → Atomicity
--------------
All operations succeed,
or none succeed.

C → Consistency
---------------
Database remains valid.

I → Isolation
-------------
Transactions do not interfere
with each other.

D → Durability
--------------
Committed changes
are permanent.

*/

-- ==================================================
-- END OF FILE
-- ==================================================