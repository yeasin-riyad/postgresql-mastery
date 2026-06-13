# 📚 SQL WHERE Clause & Filtering Guide

## 🎯 Introduction

SQL-এ `WHERE` Clause ব্যবহার করা হয় Table থেকে নির্দিষ্ট Condition অনুযায়ী Data Filter করার জন্য।

ধরুন আপনার Database-এ হাজার হাজার Record আছে, কিন্তু আপনি শুধুমাত্র CSE Department-এর Students দেখতে চান। তখন `WHERE` Clause ব্যবহার করবেন।

> সহজ ভাষায়:
>
> **WHERE = Filter Data**

---

# 🏗️ Sample Table

## Students

| StudentID | Name   | Department | GPA |
| ---------- | ------ | ---------- | ---- |
| 101 | Rahim  | CSE | 3.80 |
| 102 | Karim  | EEE | 3.50 |
| 103 | Jannat | CSE | 3.90 |
| 104 | Hasan  | BBA | 3.20 |

---

# 📌 Basic Syntax

```sql
SELECT column_names
FROM table_name
WHERE condition;
```

---

# 1️⃣ Equal (=)

নির্দিষ্ট Value Match করার জন্য।

```sql
SELECT *
FROM students
WHERE department = 'CSE';
```

### Result

| StudentID | Name |
| ---------- | ------ |
| 101 | Rahim |
| 103 | Jannat |

---

# 2️⃣ Not Equal (!= / <>)

নির্দিষ্ট Value বাদ দিতে।

```sql
SELECT *
FROM students
WHERE department != 'CSE';
```

অথবা

```sql
SELECT *
FROM students
WHERE department <> 'CSE';
```

---

# 3️⃣ Greater Than (>)

```sql
SELECT *
FROM students
WHERE gpa > 3.70;
```

### Result

```text
Rahim
Jannat
```

---

# 4️⃣ Less Than (<)

```sql
SELECT *
FROM students
WHERE gpa < 3.50;
```

### Result

```text
Hasan
```

---

# 5️⃣ Greater Than or Equal (>=)

```sql
SELECT *
FROM students
WHERE gpa >= 3.80;
```

---

# 6️⃣ Less Than or Equal (<=)

```sql
SELECT *
FROM students
WHERE gpa <= 3.50;
```

---

# 7️⃣ AND Operator

সব Condition True হতে হবে।

```sql
SELECT *
FROM students
WHERE department = 'CSE'
AND gpa > 3.85;
```

### Result

```text
Jannat
```

---

# 8️⃣ OR Operator

যেকোনো একটি Condition True হলেই হবে।

```sql
SELECT *
FROM students
WHERE department = 'EEE'
OR department = 'BBA';
```

### Result

```text
Karim
Hasan
```

---

# 9️⃣ IN Operator

একাধিক Value Filter করার জন্য।

### Without IN

```sql
SELECT *
FROM students
WHERE department = 'CSE'
OR department = 'EEE'
OR department = 'BBA';
```

### With IN

```sql
SELECT *
FROM students
WHERE department IN (
    'CSE',
    'EEE',
    'BBA'
);
```

---

# 🔟 BETWEEN Operator

Range Filtering-এর জন্য।

```sql
SELECT *
FROM students
WHERE gpa BETWEEN 3.50 AND 3.90;
```

Equivalent:

```sql
SELECT *
FROM students
WHERE gpa >= 3.50
AND gpa <= 3.90;
```

---

# 1️⃣1️⃣ LIKE Operator

Pattern Matching-এর জন্য।

## Starts With

```sql
SELECT *
FROM students
WHERE name LIKE 'R%';
```

Result:

```text
Rahim
```

---

## Ends With

```sql
SELECT *
FROM students
WHERE name LIKE '%m';
```

Result:

```text
Rahim
Karim
```

---

## Contains

```sql
SELECT *
FROM students
WHERE name LIKE '%im%';
```

Result:

```text
Rahim
Karim
```

---

# 1️⃣2️⃣ ILIKE Operator (PostgreSQL)

Case-Insensitive Search।

```sql
SELECT *
FROM students
WHERE name ILIKE 'rahim';
```

Matches:

```text
Rahim
RAHIM
rahim
RaHiM
```

---

# 1️⃣3️⃣ NOT Operator

Condition Reverse করার জন্য।

```sql
SELECT *
FROM students
WHERE NOT department = 'CSE';
```

Equivalent:

```sql
SELECT *
FROM students
WHERE department <> 'CSE';
```

---

# 1️⃣4️⃣ IS NULL

NULL Values খুঁজে বের করার জন্য।

```sql
SELECT *
FROM students
WHERE phone IS NULL;
```

---

# 1️⃣5️⃣ IS NOT NULL

NULL নয় এমন Values খুঁজে বের করার জন্য।

```sql
SELECT *
FROM students
WHERE phone IS NOT NULL;
```

---

# 🎯 Complex Filtering Example

```sql
SELECT *
FROM students
WHERE
(
    department = 'CSE'
    OR department = 'EEE'
)
AND gpa >= 3.50;
```

এখানে:

```text
Department = CSE অথবা EEE

এবং

GPA >= 3.50
```

---

# 📊 Comparison Operators Summary

| Operator | Meaning |
| -------- | -------- |
| = | Equal |
| != | Not Equal |
| <> | Not Equal |
| > | Greater Than |
| < | Less Than |
| >= | Greater Than or Equal |
| <= | Less Than or Equal |

---

# 📊 Filtering Operators Summary

| Operator | Purpose |
| -------- | -------- |
| AND | সব Condition True |
| OR | যেকোনো একটি Condition True |
| NOT | Condition Reverse |
| IN | Multiple Values |
| BETWEEN | Range Filtering |
| LIKE | Pattern Matching |
| ILIKE | Case-Insensitive Pattern Matching |
| IS NULL | NULL Values খোঁজা |
| IS NOT NULL | Non-NULL Values খোঁজা |

---

# 🎨 WHERE Clause Visualization

```text
Students Table
       │
       ▼

     WHERE
       │
       ▼

Condition Match?
       │
 ┌─────┴─────┐
 │           │
YES         NO
 │           │
 ▼           ❌

Return Row
```

---

# 🎤 Interview Answer

### What is the WHERE Clause in SQL?

The `WHERE` clause is used to filter records based on specified conditions. It allows retrieving, updating, or deleting only the rows that satisfy a given condition.

Common operators used with WHERE include:

- =
- !=
- >
- <
- AND
- OR
- IN
- BETWEEN
- LIKE
- IS NULL

---

# 🧠 Easy Memory Trick

```text
WHERE
=
Filter Data

AND
=
All Conditions True

OR
=
Any Condition True

IN
=
Many Values

BETWEEN
=
Range

LIKE
=
Pattern Search

NULL
=
Missing Value
```

---

# 🚀 Conclusion

`WHERE` Clause SQL-এর অন্যতম গুরুত্বপূর্ণ Feature, কারণ এটি Database থেকে শুধুমাত্র প্রয়োজনীয় Data বের করতে সাহায্য করে।

```text
WHERE
    ↓
Filter Rows

AND / OR
    ↓
Combine Conditions

IN / BETWEEN
    ↓
Advanced Filtering

LIKE / ILIKE
    ↓
Pattern Matching
```

SQL Interview, Backend Development এবং PostgreSQL শেখার জন্য `WHERE` Clause অবশ্যই ভালোভাবে আয়ত্ত করতে হবে।