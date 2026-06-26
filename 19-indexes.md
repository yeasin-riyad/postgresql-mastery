# 📚 Indexes in SQL

## 🎯 Introduction

ধরো তোমার কাছে **১০ লক্ষ (1,000,000)** ছাত্রের একটি রেজিস্টার আছে।

তুমি যদি **Student ID = 857643** খুঁজতে চাও, তাহলে দুইভাবে খুঁজতে পারো।

---

## ❌ Without Index

প্রথম পৃষ্ঠা থেকে একে একে সব দেখতে হবে।

```text
1
2
3
4
5
...
857643
```

এটিকে বলা হয় **Full Table Scan**।

যত বড় Table হবে, Search তত Slow হবে।

---

## ✅ With Index

বইয়ের শেষে যদি একটি Index Page থাকে—

```text
A → Page 5

B → Page 20

C → Page 35

...

R → Page 520
```

তাহলে পুরো বই পড়তে হবে না।

সরাসরি নির্দিষ্ট Page-এ চলে যেতে পারবে।

ঠিক Database-এও Index একইভাবে কাজ করে।

---

# 📖 What is an Index?

**Index** হলো Database-এর একটি Special Data Structure যা Data দ্রুত খুঁজে বের করতে সাহায্য করে।

Index Table-এর Data পরিবর্তন করে না।

বরং Data কোথায় আছে তার একটি Shortcut তৈরি করে।

```text
Without Index

Search
   │
   ▼
Row 1
Row 2
Row 3
...
Row 1000000

Result
```

```text
With Index

Search
   │
   ▼
Index
   │
   ▼
Correct Row

Result
```

---

# 🤔 Why Do We Need Index?

ছোট Table-এ Index না থাকলেও সমস্যা হয় না।

```text
10 Rows
```

Search খুব দ্রুত হবে।

---

কিন্তু যদি থাকে—

```text
10 Million Rows
```

তখন?

প্রতিবার পুরো Table Scan করলে অনেক সময় লাগবে।

Index Database-কে দ্রুত Data খুঁজে পেতে সাহায্য করে।

---

# 📚 Real Life Example

ধরো একটি Library-তে ৫ লক্ষ বই আছে।

Without Index

তোমাকে একে একে প্রতিটি বই দেখতে হবে।

---

With Index

Catalog দেখে

```text
Database Systems

Shelf 12
```

সরাসরি Shelf 12-এ চলে যাবে।

---

# ⚙️ How Index Works

ধরো Students Table

| student_id | name |
|------------|------|
| 5 | Rahim |
| 2 | Karim |
| 8 | Hasan |
| 1 | Mim |

Database Internalভাবে এমন Structure তৈরি করতে পারে—

```text
1 → Row 4

2 → Row 2

5 → Row 1

8 → Row 3
```

এখন Search অনেক দ্রুত হবে।

---

# Creating an Index

## Syntax

```sql
CREATE INDEX index_name
ON table_name(column_name);
```

---

## Example

```sql
CREATE INDEX idx_student_name
ON students(name);
```

এখন নিচের Query দ্রুত Execute হবে—

```sql
SELECT *
FROM students
WHERE name = 'Rahim';
```

---

# Multi-Column (Composite) Index

একাধিক Column-এর উপর Index তৈরি করা যায়।

```sql
CREATE INDEX idx_name_department
ON students(name, department);
```

এখন এই Query দ্রুত হতে পারে—

```sql
SELECT *
FROM students
WHERE name = 'Rahim'
AND department = 'CSE';
```

---

# Unique Index

Duplicate Value Allow করবে না।

```sql
CREATE UNIQUE INDEX idx_email
ON users(email);
```

ধরো—

```text
abc@gmail.com

abc@gmail.com
```

দ্বিতীয়বার Insert করতে গেলে Error হবে।

---

# Drop an Index

```sql
DROP INDEX idx_student_name;
```

---

# View Existing Indexes (PostgreSQL)

```sql
SELECT *
FROM pg_indexes
WHERE tablename = 'students';
```

---

# Primary Key and Index

PostgreSQL-এ যখন Primary Key তৈরি করা হয়—

```sql
CREATE TABLE students (

    student_id SERIAL PRIMARY KEY,

    name VARCHAR(100)

);
```

তখন PostgreSQL স্বয়ংক্রিয়ভাবে Primary Key-এর উপর একটি **Unique B-Tree Index** তৈরি করে।

অর্থাৎ আলাদা করে Index বানাতে হয় না।

---

# UNIQUE Constraint and Index

```sql
CREATE TABLE users (

    email VARCHAR(100) UNIQUE

);
```

এখানেও PostgreSQL Automatic Unique Index তৈরি করে।

---

# Which Columns Should Be Indexed?

নিচের Column-গুলো Index করার জন্য ভালো Candidate—

- ✅ Primary Key
- ✅ Foreign Key
- ✅ Frequently Searched Columns
- ✅ WHERE Clause
- ✅ JOIN Columns
- ✅ ORDER BY Columns (যখন প্রয়োজন)

---

## Example

```sql
SELECT *
FROM users
WHERE email = 'abc@gmail.com';
```

`email` Column-এ Index থাকলে Query দ্রুত হবে।

---

# Which Columns Should NOT Be Indexed?

সব Column-এ Index তৈরি করা উচিত নয়।

### ❌ Frequently Updated Columns

যেমন—

```text
Last Login Time
```

---

### ❌ Low Cardinality Columns

যেমন—

```text
Gender

Male
Female
```

মাত্র কয়েকটি Unique Value থাকলে Index সাধারণত তেমন উপকার করে না।

---

# Advantages of Index

- ✅ Faster Search
- ✅ Faster WHERE Filtering
- ✅ Faster JOIN Operations
- ✅ Faster ORDER BY
- ✅ Better Query Performance

---

# Disadvantages of Index

- ❌ Extra Disk Space লাগে
- ❌ INSERT একটু Slow হয়
- ❌ UPDATE একটু Slow হয়
- ❌ DELETE একটু Slow হয়

কারণ প্রতিবার Data পরিবর্তনের সাথে সাথে Index-ও Update করতে হয়।

---

# Types of Indexes

## 1️⃣ B-Tree Index (Default)

PostgreSQL-এর Default Index।

```text
Supports

=

<

>

<=

>=

BETWEEN

ORDER BY
```

সবচেয়ে বেশি ব্যবহৃত Index।

---

## 2️⃣ Hash Index

Equality Search-এর জন্য।

```sql
SELECT *
FROM users
WHERE email = 'abc@gmail.com';
```

---

## 3️⃣ Composite Index

একাধিক Column-এর উপর Index।

```sql
CREATE INDEX idx_name_department
ON students(name, department);
```

---

## 4️⃣ Unique Index

Duplicate Values Prevent করে।

```sql
CREATE UNIQUE INDEX idx_email
ON users(email);
```

---

## 5️⃣ Partial Index

Table-এর নির্দিষ্ট Row-এর উপর Index তৈরি করে।

```sql
CREATE INDEX idx_active_users
ON users(email)
WHERE status = 'active';
```

---

## 6️⃣ Expression Index

Calculated Value-এর উপর Index।

```sql
CREATE INDEX idx_lower_email
ON users(LOWER(email));
```

---

# Query Execution Comparison

## Without Index

```text
Search

↓

Full Table Scan

↓

Result
```

---

## With Index

```text
Search

↓

Index Scan

↓

Result
```

---

# Real World Examples

## Find User by Email

```sql
SELECT *
FROM users
WHERE email = 'abc@gmail.com';
```

---

## Find Orders of a Customer

```sql
SELECT *
FROM orders
WHERE customer_id = 10;
```

---

## JOIN Query

```sql
SELECT *
FROM students s
JOIN departments d
ON s.department_id = d.department_id;
```

`department_id` Column Index করলে JOIN আরও Efficient হতে পারে।

---

## ORDER BY

```sql
SELECT *
FROM students
ORDER BY gpa DESC;
```

অনেক ক্ষেত্রে `gpa`-এর উপর Index থাকলে Sorting দ্রুত হতে পারে (যদিও Query Planner-এর সিদ্ধান্তের উপর এটি নির্ভর করে)।

---

# Index vs No Index

| Without Index | With Index |
|--------------|------------|
| Full Table Scan | Index Scan |
| Slow Search | Fast Search |
| Less Storage | More Storage |
| Faster INSERT | Slightly Slower INSERT |
| Faster UPDATE | Slightly Slower UPDATE |
| Faster DELETE | Slightly Slower DELETE |

---

# 📊 Types of Index Summary

| Index Type | Purpose |
|------------|---------|
| B-Tree | Default General Purpose Index |
| Hash | Equality Search |
| Composite | Multiple Columns |
| Unique | Prevent Duplicate Values |
| Partial | Selected Rows Only |
| Expression | Calculated Values |

---

# 📌 Best Practices

- Index শুধুমাত্র Frequently Queried Columns-এ তৈরি করুন।
- Primary Key এবং UNIQUE Constraint-এর জন্য আলাদা Index তৈরি করবেন না।
- Low Cardinality Columns-এ Index এড়িয়ে চলুন।
- অতিরিক্ত Index তৈরি করলে Write Performance কমে যায়।
- `EXPLAIN ANALYZE` ব্যবহার করে Query Performance পরীক্ষা করুন।

---

# 🎤 Interview Answer

### What is an Index in SQL?

An Index is a special database object that improves the speed of data retrieval operations. Instead of scanning every row, the database uses the index to locate the required data quickly.

Indexes improve the performance of `SELECT`, `WHERE`, `JOIN`, and `ORDER BY` queries, but they also require extra storage and can slow down `INSERT`, `UPDATE`, and `DELETE` operations because the index must be maintained.

---

# 🧠 Easy Memory Trick

```text
Without Index
=
Search Every Row

With Index
=
Jump Directly to the Data

Fast Read
Slow Write
```

---

# 🚀 Conclusion

```text
             Query
               │
               ▼
       Is Index Available?
          ┌──────────┐
      Yes │          │ No
          ▼          ▼
    Index Scan   Full Table Scan
          │          │
          └────┬─────┘
               ▼
             Result
```

Indexes হলো Database Performance Optimization-এর অন্যতম গুরুত্বপূর্ণ Feature। সঠিক Column-এ Index ব্যবহার করলে বড় Database-এ Query Performance অনেক গুণ বেড়ে যায়। তবে অপ্রয়োজনীয় Index তৈরি করলে Storage বাড়ে এবং `INSERT`, `UPDATE`, `DELETE` অপারেশন ধীর হয়ে যায়। তাই সবসময় প্রয়োজন অনুযায়ী পরিকল্পনা করে Index ব্যবহার করা উচিত।