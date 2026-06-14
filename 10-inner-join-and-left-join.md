# 📚 INNER JOIN and LEFT JOIN in SQL

## 🎯 Introduction

Database-এ Data সাধারণত একাধিক Table-এ সংরক্ষণ করা হয়।

উদাহরণ:

* Students Table
* Departments Table

এখন যদি আমরা জানতে চাই:

> "কোন Student কোন Department-এ পড়ে?"

তাহলে আমাদের একাধিক Table-এর Data একত্রে Combine করতে হবে।

এই কাজের জন্য SQL-এ **JOIN** ব্যবহার করা হয়।

---

# 🤔 What is JOIN?

JOIN হলো এমন একটি Operation যা দুই বা ততোধিক Table-এর Related Data একত্রে দেখায়।

সাধারণত JOIN কাজ করে:

```text
PRIMARY KEY
      +
FOREIGN KEY
```

ব্যবহার করে।

---

# 🏗 Sample Tables

## Departments

| department_id | department_name |
| ------------- | --------------- |
| 1             | CSE             |
| 2             | EEE             |
| 3             | BBA             |

---

## Students

| student_id | name   | department_id |
| ---------- | ------ | ------------- |
| 101        | Rahim  | 1             |
| 102        | Karim  | 1             |
| 103        | Hasan  | 2             |
| 104        | Jannat | NULL          |

এখানে `department_id` হলো Students Table-এর **Foreign Key**।

---

# 1️⃣ INNER JOIN

## 📖 Definition

`INNER JOIN` শুধুমাত্র সেই Row গুলো Return করে যেগুলোর Match উভয় Table-এ পাওয়া যায়।

---

## Syntax

```sql
SELECT columns
FROM table1
INNER JOIN table2
    ON condition;
```

---

## Example

```sql
SELECT
    s.student_id,
    s.name,
    d.department_name
FROM students s
INNER JOIN departments d
    ON s.department_id = d.department_id;
```

---

## 🔍 How It Works?

Database প্রতিটি Student-এর `department_id` কে Department Table-এর `department_id` এর সাথে Match করে।

যদি Match পাওয়া যায়:

✅ Row Return হবে

না হলে:

❌ Row বাদ যাবে

---

## Result

| student_id | name  | department_name |
| ---------- | ----- | --------------- |
| 101        | Rahim | CSE             |
| 102        | Karim | CSE             |
| 103        | Hasan | EEE             |

লক্ষ্য করো:

```text
Jannat
```

Result-এ নেই কারণ তার `department_id` এর কোনো Match পাওয়া যায়নি।

---

# 🎨 INNER JOIN Visualization

```text
Students        Departments

   [ A ]  ∩  [ B ]

Only Intersection
```

অর্থাৎ:

```text
Only Matching Rows
```

---

# 2️⃣ LEFT JOIN

## 📖 Definition

`LEFT JOIN` বাম পাশের Table-এর **সব Row** Return করে।

ডান পাশের Table-এ Match না পেলে:

```text
NULL
```

দেখায়।

---

## Syntax

```sql
SELECT columns
FROM table1
LEFT JOIN table2
    ON condition;
```

---

## Example

```sql
SELECT
    s.student_id,
    s.name,
    d.department_name
FROM students s
LEFT JOIN departments d
    ON s.department_id = d.department_id;
```

---

## Result

| student_id | name   | department_name |
| ---------- | ------ | --------------- |
| 101        | Rahim  | CSE             |
| 102        | Karim  | CSE             |
| 103        | Hasan  | EEE             |
| 104        | Jannat | NULL            |

এখানে Jannat Result-এ এসেছে কারণ LEFT JOIN সব Student দেখায়।

---

# 🎨 LEFT JOIN Visualization

```text
Students        Departments

[ Entire A ] + Matching B
```

অর্থাৎ:

```text
All Left Rows
+
Matching Right Rows
```

---

# 🌍 Real World Example

## Customers Table

| customer_id | name  |
| ----------- | ----- |
| 1           | Rahim |
| 2           | Karim |
| 3           | Hasan |

---

## Orders Table

| order_id | customer_id |
| -------- | ----------- |
| 101      | 1           |
| 102      | 1           |
| 103      | 2           |

---

# INNER JOIN Example

```sql
SELECT
    c.name,
    o.order_id
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id;
```

### Result

| name  | order_id |
| ----- | -------- |
| Rahim | 101      |
| Rahim | 102      |
| Karim | 103      |

Hasan নেই কারণ তার কোনো Order নেই।

---

# LEFT JOIN Example

```sql
SELECT
    c.name,
    o.order_id
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;
```

### Result

| name  | order_id |
| ----- | -------- |
| Rahim | 101      |
| Rahim | 102      |
| Karim | 103      |
| Hasan | NULL     |

Hasan এসেছে কারণ LEFT JOIN সব Customer দেখায়।

---

# 📊 INNER JOIN vs LEFT JOIN

| Feature             | INNER JOIN   | LEFT JOIN     |
| ------------------- | ------------ | ------------- |
| Matching Rows       | ✅            | ✅             |
| Unmatched Left Rows | ❌            | ✅             |
| NULL Values         | কম           | বেশি হতে পারে |
| Use Case            | Related Data | All Left Data |

---

# 🎯 When to Use?

## Use INNER JOIN When:

✅ শুধুমাত্র Matching Data দরকার

Examples:

* Students with Departments
* Orders with Customers
* Employees with Managers

---

## Use LEFT JOIN When:

✅ Left Table-এর সব Data দরকার

Examples:

* Customers without Orders
* Students without Departments
* Employees without Projects

---

# ⚡ SQL Execution Order

```text
FROM
  ↓
JOIN
  ↓
ON
  ↓
WHERE
  ↓
SELECT
  ↓
ORDER BY
  ↓
LIMIT
```

---

# 🎤 Interview Answer

### What is the difference between INNER JOIN and LEFT JOIN?

* `INNER JOIN` returns only the rows that have matching values in both tables.
* `LEFT JOIN` returns all rows from the left table and matching rows from the right table. If no match exists, NULL values are returned.

---

# 🧠 Easy Memory Trick

```text
INNER JOIN
=
Only Matches

LEFT JOIN
=
Everything on Left
+
Matches on Right
```

---

# 🚀 Conclusion

```text
INNER JOIN
      ↓
Only Matching Data

LEFT JOIN
      ↓
All Left Data
      +
Matching Right Data
```

JOIN হলো Relational Database-এর অন্যতম গুরুত্বপূর্ণ Feature। INNER JOIN এবং LEFT JOIN ভালোভাবে বুঝতে পারলে RIGHT JOIN, FULL JOIN এবং Advanced SQL Query শেখা অনেক সহজ হয়ে যায়।
