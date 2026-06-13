# 📚 ORDER BY, LIMIT, OFFSET & Pagination in SQL

## 🎯 Introduction

Database থেকে Data Retrieve করার সময় আমরা প্রায়ই চাই:

* Data Sort করতে
* নির্দিষ্ট সংখ্যক Row দেখতে
* Page-wise Data দেখাতে

এই কাজগুলোর জন্য SQL-এ ব্যবহার করা হয়:

1. **ORDER BY** → Data Sort করার জন্য
2. **LIMIT** → কতগুলো Row Return হবে তা নির্ধারণ করার জন্য
3. **OFFSET** → কতগুলো Row Skip করবে তা নির্ধারণ করার জন্য
4. **Pagination** → বড় Dataset-কে Page আকারে দেখানোর জন্য

---

# 🏗️ Sample Table

## Students

| StudentID | Name   | GPA  |
| --------- | ------ | ---- |
| 101       | Rahim  | 3.80 |
| 102       | Karim  | 3.50 |
| 103       | Jannat | 3.90 |
| 104       | Hasan  | 3.20 |
| 105       | Nusrat | 3.70 |

---

# 1️⃣ ORDER BY

## 📖 Definition

`ORDER BY` ব্যবহার করা হয় Query Result Sort করার জন্য।

Default Order:

```text
Ascending (ASC)
```

---

## Basic Syntax

```sql
SELECT *
FROM students
ORDER BY gpa;
```

---

## Ascending Order (ASC)

ছোট থেকে বড়।

```sql
SELECT *
FROM students
ORDER BY gpa ASC;
```

### Output

| Name   | GPA  |
| ------ | ---- |
| Hasan  | 3.20 |
| Karim  | 3.50 |
| Nusrat | 3.70 |
| Rahim  | 3.80 |
| Jannat | 3.90 |

---

## Descending Order (DESC)

বড় থেকে ছোট।

```sql
SELECT *
FROM students
ORDER BY gpa DESC;
```

### Output

| Name   | GPA  |
| ------ | ---- |
| Jannat | 3.90 |
| Rahim  | 3.80 |
| Nusrat | 3.70 |
| Karim  | 3.50 |
| Hasan  | 3.20 |

---

## Multiple Column Sorting

```sql
SELECT *
FROM students
ORDER BY department ASC, gpa DESC;
```

প্রথমে Department অনুযায়ী Sort করবে, তারপর একই Department-এর মধ্যে GPA অনুযায়ী Sort করবে।

---

# 2️⃣ LIMIT

## 📖 Definition

`LIMIT` ব্যবহার করা হয় কতগুলো Row Return হবে তা নির্ধারণ করার জন্য।

---

## Syntax

```sql
SELECT *
FROM students
LIMIT 3;
```

### Output

```text
Only First 3 Rows
```

---

## Top N Records

Top 3 GPA Students বের করার জন্য:

```sql
SELECT *
FROM students
ORDER BY gpa DESC
LIMIT 3;
```

---

# 3️⃣ OFFSET

## 📖 Definition

`OFFSET` ব্যবহার করা হয় নির্দিষ্ট সংখ্যক Row Skip করার জন্য।

---

## Example

```sql
SELECT *
FROM students
LIMIT 2
OFFSET 2;
```

### Meaning

```text
Skip First 2 Rows
Return Next 2 Rows
```

---

## Visualization

```text
Row1
Row2
=========
OFFSET 2
=========

Row3 ← Start Here
Row4 ← Return
```

---

# LIMIT + OFFSET Together

```sql
SELECT *
FROM students
ORDER BY student_id
LIMIT 3
OFFSET 3;
```

Meaning:

```text
Skip First 3 Rows
Return Next 3 Rows
```

---

# 4️⃣ Pagination

## 📖 Definition

Pagination হলো বড় Dataset-কে ছোট ছোট Page-এ ভাগ করে দেখানোর পদ্ধতি।

---

## Real-World Examples

```text
Google Search Results

Facebook Feed

YouTube Videos

E-commerce Products
```

---

# Pagination Formula

```text
OFFSET = (Page Number - 1) × Page Size
```

---

## Example

ধরি:

```text
Page Size = 10
```

---

### Page 1

```sql
SELECT *
FROM students
LIMIT 10
OFFSET 0;
```

---

### Page 2

```sql
SELECT *
FROM students
LIMIT 10
OFFSET 10;
```

---

### Page 3

```sql
SELECT *
FROM students
LIMIT 10
OFFSET 20;
```

---

# Backend Pagination Example

## Node.js / Express

```javascript
const page = Number(req.query.page) || 1;
const limit = Number(req.query.limit) || 10;

const offset = (page - 1) * limit;

const result = await pool.query(
  `
  SELECT *
  FROM students
  ORDER BY student_id
  LIMIT $1
  OFFSET $2
  `,
  [limit, offset]
);
```

---

# Pagination Visualization

```text
Total Records = 100

Page Size = 10

Page 1 → 1-10
Page 2 → 11-20
Page 3 → 21-30
Page 4 → 31-40
```

---

# ⚠️ OFFSET Pagination Problem

যদি Table-এ লক্ষ বা কোটি Row থাকে:

```sql
SELECT *
FROM students
LIMIT 10
OFFSET 5000000;
```

Database-কে প্রথম 50 লক্ষ Row Skip করতে হবে।

ফলে:

❌ Slow Query

❌ Poor Performance

---

# 🚀 Better Solution: Keyset Pagination

```sql
SELECT *
FROM students
WHERE student_id > 100
ORDER BY student_id
LIMIT 10;
```

### Benefits

✅ Faster

✅ More Scalable

✅ Used in Large Applications

---

# 📊 Summary Table

| Clause     | Purpose                 |
| ---------- | ----------------------- |
| ORDER BY   | Sort Data               |
| LIMIT      | Restrict Number of Rows |
| OFFSET     | Skip Rows               |
| Pagination | Divide Data into Pages  |

---

# 🎤 Interview Answer

### What are ORDER BY, LIMIT, OFFSET, and Pagination?

* **ORDER BY** is used to sort query results.
* **LIMIT** restricts the number of rows returned.
* **OFFSET** skips a specified number of rows.
* **Pagination** combines LIMIT and OFFSET to display large datasets page by page.

Example:

```sql
SELECT *
FROM students
ORDER BY student_id
LIMIT 10
OFFSET 20;
```

This query skips the first 20 rows and returns the next 10 rows.

---

# 🧠 Easy Memory Trick

```text
ORDER BY
=
Sort Data

LIMIT
=
Take N Rows

OFFSET
=
Skip N Rows

Pagination
=
LIMIT + OFFSET
```

---

# 🚀 Conclusion

```text
ORDER BY
    ↓
Sort Results

LIMIT
    ↓
Control Result Size

OFFSET
    ↓
Skip Rows

LIMIT + OFFSET
    ↓
Pagination
```

`ORDER BY`, `LIMIT`, `OFFSET`, এবং `Pagination` SQL Query Optimization, Backend Development, API Development এবং PostgreSQL Interview-এর জন্য অত্যন্ত গুরুত্বপূর্ণ Concepts।
