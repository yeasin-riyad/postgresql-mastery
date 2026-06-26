# 📚 Transactions in SQL

## 🎯 Introduction

ধরো তুমি একটি Banking Application তৈরি করছো।

Rahim-এর Account থেকে **1000 টাকা** কেটে Karim-এর Account-এ **1000 টাকা** যোগ করতে হবে।

এটি আসলে দুটি আলাদা SQL Query।

```text
1. Rahim-এর Balance থেকে 1000 টাকা কমানো

2. Karim-এর Balance-এ 1000 টাকা যোগ করা
```

এখন যদি প্রথম Query সফল হয় কিন্তু দ্বিতীয় Query ব্যর্থ হয়, তাহলে কী হবে?

```text
Rahim-এর Account থেকে টাকা কেটে গেছে ❌

Karim টাকা পায়নি ❌

Database ভুল অবস্থায় চলে গেছে ❌
```

এই ধরনের সমস্যা এড়ানোর জন্য SQL-এ **Transaction** ব্যবহার করা হয়।

---

# 📖 What is a Transaction?

**Transaction** হলো এক বা একাধিক SQL Statement-এর একটি Group, যা Database একটি **Single Unit of Work** হিসেবে Execute করে।

Transaction-এর মূল নিয়ম হলো—

- সব Statement সফল হলে → **COMMIT**
- যেকোনো একটি Statement ব্যর্থ হলে → **ROLLBACK**

```text
All Queries Successful
        │
        ▼
     COMMIT

OR

Any Query Failed
        │
        ▼
    ROLLBACK
```

---

# 🤔 Why Do We Need Transactions?

Transactions ব্যবহার করার প্রধান কারণগুলো হলো—

- Data Consistency বজায় রাখা
- Partial Update প্রতিরোধ করা
- Data Loss এড়ানো
- Multiple Queries-কে Safe করা
- Database Integrity নিশ্চিত করা

---

# 🏦 Real-Life Example: Bank Transfer

ধরো Rahim-এর Account থেকে Karim-এর Account-এ টাকা Transfer করা হচ্ছে।

```text
Step 1
Check Balance

↓

Step 2
Deduct Money

↓

Step 3
Add Money

↓

Step 4
Save Changes
```

যদি Step 3-এ Error হয়?

```text
Deduct হয়েছে ✔

Add হয়নি ❌
```

Database ভুল হয়ে যাবে।

Transaction এই সমস্যার সমাধান করে।

---

# Transaction Flow

```text
BEGIN

   │

Execute Queries

   │

Success?

 ┌───────────┐

Yes         No

│            │

▼            ▼

COMMIT   ROLLBACK

│            │

▼            ▼

Save Data   Undo Changes
```

---

# Basic Syntax

## Commit Example

```sql
BEGIN;

-- SQL Statements

COMMIT;
```

---

## Rollback Example

```sql
BEGIN;

-- SQL Statements

ROLLBACK;
```

---

# Example 1: Money Transfer

ধরো Accounts Table

| Name | Balance |
|------|---------|
| Rahim | 10000 |
| Karim | 5000 |

Transfer 1000 টাকা।

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 1000
WHERE name = 'Rahim';

UPDATE accounts
SET balance = balance + 1000
WHERE name = 'Karim';

COMMIT;
```

---

## Result

| Name | Balance |
|------|---------|
| Rahim | 9000 |
| Karim | 6000 |

---

# Example 2: Rollback

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 1000
WHERE name = 'Rahim';

-- Something went wrong

ROLLBACK;
```

Result

```text
Rahim-এর Balance আগের মতোই থাকবে।
```

---

# COMMIT

COMMIT মানে—

```text
সব পরিবর্তন Permanent করে দাও।
```

```sql
BEGIN;

UPDATE students
SET gpa = 4.00
WHERE student_id = 1;

COMMIT;
```

---

# ROLLBACK

ROLLBACK মানে—

```text
সব পরিবর্তন বাতিল করো।
```

```sql
BEGIN;

DELETE FROM students;

ROLLBACK;
```

Data Delete হবে না।

---

# SAVEPOINT

SAVEPOINT Transaction-এর ভিতরে একটি Checkpoint তৈরি করে।

```sql
BEGIN;

UPDATE accounts
SET balance = balance - 500
WHERE id = 1;

SAVEPOINT deduct_done;

UPDATE accounts
SET balance = balance + 500
WHERE id = 2;
```

---

## Rollback to Savepoint

```sql
ROLLBACK TO SAVEPOINT deduct_done;
```

এতে পুরো Transaction Cancel হবে না।

শুধু Savepoint-এর পরের পরিবর্তনগুলো Undo হবে।

---

## Commit শেষে

```sql
COMMIT;
```

---

# ACID Properties

Transaction-এর সবচেয়ে গুরুত্বপূর্ণ বৈশিষ্ট্য হলো **ACID**।

---

## A — Atomicity

সব হবে অথবা কিছুই হবে না।

```text
Money Deduct ✔

Money Add ✘

↓

Everything Undo
```

---

## C — Consistency

Transaction-এর আগে এবং পরে Database Valid থাকবে।

```text
Before Transaction

Valid

↓

After Transaction

Still Valid
```

---

## I — Isolation

একাধিক Transaction একসাথে চললেও তারা একে অপরকে প্রভাবিত করবে না।

---

## D — Durability

COMMIT হয়ে গেলে Data Permanent হয়ে যাবে।

Server Crash হলেও Data হারাবে না।

---

# Auto Commit

PostgreSQL-এ Defaultভাবে প্রতিটি Statement Automatically Commit হয়।

```sql
UPDATE students
SET gpa = 3.90;
```

এটি Execute হওয়ার সাথে সাথেই Save হয়ে যায়।

---

# Explicit Transaction

```sql
BEGIN;

UPDATE students
SET gpa = 4.00
WHERE student_id = 1;

DELETE FROM students
WHERE student_id = 5;

COMMIT;
```

---

# Implicit Transaction

একটি Single SQL Statement নিজেই একটি Transaction।

```sql
INSERT INTO students(name)
VALUES ('Rahim');
```

---

# Transaction with INSERT

```sql
BEGIN;

INSERT INTO students(name, department)
VALUES ('Mim','CSE');

COMMIT;
```

---

# Transaction with UPDATE

```sql
BEGIN;

UPDATE students
SET gpa = 3.95
WHERE student_id = 2;

COMMIT;
```

---

# Transaction with DELETE

```sql
BEGIN;

DELETE FROM students
WHERE department = 'EEE';

ROLLBACK;
```

Delete হবে না।

---

# Real World Examples

## Banking System

```text
Deduct Balance

↓

Credit Receiver

↓

Update Ledger

↓

COMMIT
```

---

## E-Commerce

```text
Reduce Product Stock

↓

Create Order

↓

Create Invoice

↓

Receive Payment

↓

COMMIT
```

---

## Online Ticket Booking

```text
Reserve Seat

↓

Take Payment

↓

Generate Ticket

↓

COMMIT
```

---

## Payroll System

```text
Calculate Salary

↓

Deduct Tax

↓

Transfer Salary

↓

COMMIT
```

---

# Transaction Commands

| Command | Purpose |
|----------|---------|
| BEGIN | Starts a Transaction |
| COMMIT | Saves Changes Permanently |
| ROLLBACK | Cancels All Changes |
| SAVEPOINT | Creates a Checkpoint |
| ROLLBACK TO SAVEPOINT | Undo Changes After Savepoint |

---

# Advantages

- ✅ Ensures Data Consistency
- ✅ Prevents Partial Updates
- ✅ Easy Error Recovery
- ✅ Maintains Data Integrity
- ✅ Makes Multiple Queries Safe

---

# Disadvantages

- ❌ Long Transactions may lock rows/tables
- ❌ Consumes More Resources
- ❌ Can Reduce Concurrency
- ❌ Large Transactions may be Slow

---

# 📊 Summary

| Command | Description |
|----------|-------------|
| BEGIN | Start Transaction |
| COMMIT | Save Changes |
| ROLLBACK | Undo Everything |
| SAVEPOINT | Create Checkpoint |
| ROLLBACK TO SAVEPOINT | Undo Until Checkpoint |

---

# 🎤 Interview Answer

### What is a Transaction in SQL?

A Transaction is a sequence of one or more SQL statements executed as a single unit of work. It ensures that either all operations succeed and are committed, or if any operation fails, all changes are rolled back.

Transactions follow the **ACID** properties:

- **Atomicity** – All or nothing.
- **Consistency** – Database remains valid.
- **Isolation** – Transactions do not interfere with each other.
- **Durability** – Committed changes are permanent.

Common Transaction commands include:

- `BEGIN`
- `COMMIT`
- `ROLLBACK`
- `SAVEPOINT`
- `ROLLBACK TO SAVEPOINT`

---

# 🧠 Easy Memory Trick

```text
BEGIN
   │
Execute Queries
   │
Success?
 ┌────┴────┐
 │         │
Yes        No
 │         │
 ▼         ▼
COMMIT  ROLLBACK
```

Remember:

```text
COMMIT
=
Save

ROLLBACK
=
Undo

SAVEPOINT
=
Checkpoint
```

---

# 🚀 Conclusion

```text
Start Transaction
        │
        ▼
Execute SQL Statements
        │
        ▼
Any Error?
   ┌────────────┐
 No           Yes
 │             │
 ▼             ▼
COMMIT     ROLLBACK
 │             │
 ▼             ▼
Saved      Changes Undone
```

Transactions হলো SQL এবং PostgreSQL-এর সবচেয়ে গুরুত্বপূর্ণ Feature-গুলোর একটি। Banking System, E-commerce, Inventory Management, Payment Gateway, Airline Booking এবং Financial Applications-এ Data Integrity নিশ্চিত করতে Transaction অপরিহার্য। একজন Database Developer-এর জন্য Transactions এবং ACID Properties ভালোভাবে বোঝা অত্যন্ত গুরুত্বপূর্ণ।