# 📚 GROUP BY and HAVING in SQL

## 🎯 Introduction

Aggregate Functions (`COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()`) ব্যবহার করে যখন Data-কে বিভিন্ন Group-এ ভাগ করে Summary বের করতে হয়, তখন **GROUP BY** ব্যবহার করা হয়।

আর Aggregate Result-এর উপর Filter করতে চাইলে **HAVING** ব্যবহার করা হয়।

---

## 🤔 Why Do We Need GROUP BY?

ধরো আমাদের Students Table আছে।

| student_id | name | department | gpa |
| ---------- | ---- | ---------- | ---- |
| 1 | Rahim | CSE | 3.80 |
| 2 | Karim | CSE | 3.50 |
| 3 | Hasan | EEE | 3.70 |
| 4 | Jannat | BBA | 3.90 |
| 5 | Nusrat | CSE | 3.60 |

আমরা জানতে চাই:

```text
প্রতিটি Department-এ কতজন Student আছে?
```

এখানে Aggregate Function একা যথেষ্ট নয়।

আমাদের Data-কে Department অনুযায়ী Group করতে হবে।

---

# 1️⃣ GROUP BY

## 📖 Definition

`GROUP BY` একই ধরনের Value-গুলোকে Group করে Aggregate Function চালানোর সুযোগ দেয়।

---

## Basic Syntax

```sql
SELECT
    column_name,
    aggregate_function(column_name)
FROM table_name
GROUP BY column_name;
```

---

## Example: Count Students by Department

```sql
SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department;
```

### Output

| department | total_students |
|------------|---------------|
| CSE | 3 |
| EEE | 1 |
| BBA | 1 |

---

## How GROUP BY Works

```text
CSE
 ├─ Rahim
 ├─ Karim
 └─ Nusrat

COUNT = 3
```

```text
EEE
 └─ Hasan

COUNT = 1
```

```text
BBA
 └─ Jannat

COUNT = 1
```

---

# GROUP BY with AVG()

```sql
SELECT
    department,
    AVG(gpa) AS average_gpa
FROM students
GROUP BY department;
```

### Output

| department | average_gpa |
|------------|-------------|
| CSE | 3.63 |
| EEE | 3.70 |
| BBA | 3.90 |

---

# GROUP BY with SUM()

```sql
SELECT
    department,
    SUM(gpa) AS total_gpa
FROM students
GROUP BY department;
```

---

# GROUP BY with MAX()

```sql
SELECT
    department,
    MAX(gpa) AS highest_gpa
FROM students
GROUP BY department;
```

---

# GROUP BY with MIN()

```sql
SELECT
    department,
    MIN(gpa) AS lowest_gpa
FROM students
GROUP BY department;
```

---

# ⚠️ Important Rule

GROUP BY ব্যবহার করলে SELECT-এ থাকা Non-Aggregate Column অবশ্যই GROUP BY-এ থাকতে হবে।

---

## ❌ Wrong Query

```sql
SELECT
    name,
    department,
    COUNT(*)
FROM students
GROUP BY department;
```

কারণ `name` GROUP BY-এর অংশ নয়।

---

## ✅ Correct Query

```sql
SELECT
    department,
    COUNT(*)
FROM students
GROUP BY department;
```

---

# Multiple Columns GROUP BY

```sql
SELECT
    department,
    gpa,
    COUNT(*)
FROM students
GROUP BY department, gpa;
```

---

# GROUP BY + ORDER BY

```sql
SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department
ORDER BY total_students DESC;
```

---

# 2️⃣ HAVING

## 📖 Definition

Aggregate Result Filter করার জন্য `HAVING` ব্যবহার করা হয়।

---

## Why Not WHERE?

নিচের Query Error দিবে:

```sql
SELECT
    department,
    COUNT(*)
FROM students
WHERE COUNT(*) > 2
GROUP BY department;
```

কারণ:

```text
WHERE Aggregate Function ব্যবহার করতে পারে না
```

---

## Basic Syntax

```sql
SELECT
    column_name,
    aggregate_function(column_name)
FROM table_name
GROUP BY column_name
HAVING condition;
```

---

# Example: Departments with More Than 2 Students

```sql
SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department
HAVING COUNT(*) > 2;
```

### Output

| department | total_students |
|------------|---------------|
| CSE | 3 |

---

# HAVING with AVG()

Average GPA 3.7-এর বেশি এমন Department বের করি।

```sql
SELECT
    department,
    AVG(gpa) AS average_gpa
FROM students
GROUP BY department
HAVING AVG(gpa) > 3.7;
```

### Output

| department | average_gpa |
|------------|-------------|
| BBA | 3.90 |

---

# HAVING with SUM()

```sql
SELECT
    department,
    SUM(gpa) AS total_gpa
FROM students
GROUP BY department
HAVING SUM(gpa) > 10;
```

---

# HAVING with MAX()

```sql
SELECT
    department,
    MAX(gpa) AS highest_gpa
FROM students
GROUP BY department
HAVING MAX(gpa) > 3.8;
```

---

# WHERE vs HAVING

| WHERE | HAVING |
|---------|---------|
| Rows Filter করে | Groups Filter করে |
| GROUP BY-এর আগে কাজ করে | GROUP BY-এর পরে কাজ করে |
| Aggregate Function ব্যবহার করা যায় না | Aggregate Function ব্যবহার করা যায় |
| Individual Row Filter করে | Summary Result Filter করে |

---

## WHERE Example

```sql
SELECT *
FROM students
WHERE department = 'CSE';
```

---

## HAVING Example

```sql
SELECT
    department,
    COUNT(*)
FROM students
GROUP BY department
HAVING COUNT(*) > 2;
```

---

# WHERE + HAVING Together

```sql
SELECT
    department,
    COUNT(*) AS total_students
FROM students
WHERE gpa >= 3.5
GROUP BY department
HAVING COUNT(*) >= 2;
```

---

# SQL Execution Order

```text
FROM
 ↓
WHERE
 ↓
GROUP BY
 ↓
HAVING
 ↓
SELECT
 ↓
ORDER BY
```

---

# 🌍 Real World Examples

## Departments Having More Than 50 Students

```sql
SELECT
    department_id,
    COUNT(*)
FROM students
GROUP BY department_id
HAVING COUNT(*) > 50;
```

---

## Products With Average Rating Above 4

```sql
SELECT
    product_id,
    AVG(rating)
FROM reviews
GROUP BY product_id
HAVING AVG(rating) > 4;
```

---

## Customers With More Than 10 Orders

```sql
SELECT
    customer_id,
    COUNT(*)
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 10;
```

---

# 📊 Quick Summary

| Clause | Purpose |
|---------|----------|
| GROUP BY | Data Group করা |
| HAVING | Group Filter করা |
| WHERE | Row Filter করা |

---

# 🎤 Interview Answer

### What is GROUP BY in SQL?

GROUP BY is used to group rows with the same values and perform aggregate calculations like COUNT, SUM, AVG, MAX, and MIN.

### What is HAVING in SQL?

HAVING is used to filter grouped results after GROUP BY. Unlike WHERE, HAVING can work with Aggregate Functions.

---

# 🧠 Easy Memory Trick

```text
WHERE
=
Filter Rows

GROUP BY
=
Create Groups

HAVING
=
Filter Groups
```

---

# 🚀 Conclusion

```text
Raw Data
    ↓
WHERE
    ↓
GROUP BY
    ↓
Aggregate Functions
    ↓
HAVING
    ↓
Final Result
```

`GROUP BY` এবং `HAVING` SQL Reporting, Dashboard Development, Analytics, Business Intelligence (BI), এবং Technical Interview-এর জন্য অত্যন্ত গুরুত্বপূর্ণ Topic।