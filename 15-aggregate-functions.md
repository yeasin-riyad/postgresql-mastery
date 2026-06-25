# 📚 Aggregate Functions in SQL

## 🎯 Introduction

Aggregate Function হলো এমন SQL Function যা **একাধিক Row-এর Data নিয়ে একটি Summary Result** প্রদান করে।

ধরো তোমার কাছে হাজার হাজার Student, Employee বা Order Data আছে।

তুমি জানতে চাও:

- মোট কতজন Student আছে?
- Average GPA কত?
- Highest Salary কত?
- Lowest Price কত?
- Total Revenue কত?

এই ধরনের Summary Information বের করার জন্য Aggregate Functions ব্যবহার করা হয়।

---

## 🤔 What is an Aggregate Function?

Aggregate Function একাধিক Row-এর উপর Calculation চালিয়ে **একটি Single Value** Return করে।

```text
Multiple Rows
      ↓
Aggregate Function
      ↓
Single Result
```

---

# 🏗 Sample Table

## Students

| student_id | name   | department | gpa |
| ---------- | ------ | ---------- | ---- |
| 1 | Rahim | CSE | 3.80 |
| 2 | Karim | CSE | 3.50 |
| 3 | Hasan | EEE | 3.70 |
| 4 | Jannat | BBA | 3.90 |

---

# 📌 Common Aggregate Functions

| Function | Purpose |
|----------|---------|
| COUNT() | Row Count |
| SUM() | Total Value |
| AVG() | Average Value |
| MAX() | Highest Value |
| MIN() | Lowest Value |

---

# 1️⃣ COUNT()

## 📖 Purpose

Table-এ মোট কতটি Row আছে তা গণনা করে।

### Example

```sql
SELECT COUNT(*)
FROM students;
```

### Output

```text
4
```

কারণ Table-এ মোট ৪টি Row আছে।

---

## COUNT(column_name)

```sql
SELECT COUNT(gpa)
FROM students;
```

এটি শুধুমাত্র GPA Column-এর Non-NULL Value Count করবে।

---

## COUNT(DISTINCT)

```sql
SELECT COUNT(DISTINCT department)
FROM students;
```

### Output

```text
3
```

কারণ Unique Departments:

```text
CSE
EEE
BBA
```

---

# 2️⃣ SUM()

## 📖 Purpose

Numeric Column-এর Total যোগফল বের করে।

### Example Table

| student_id | fee |
| ---------- | ---- |
| 1 | 1000 |
| 2 | 1500 |
| 3 | 1200 |

### Query

```sql
SELECT SUM(fee)
FROM students;
```

### Output

```text
3700
```

কারণ:

```text
1000 + 1500 + 1200 = 3700
```

---

# 3️⃣ AVG()

## 📖 Purpose

Average (গড়) বের করে।

### Query

```sql
SELECT AVG(gpa)
FROM students;
```

### Calculation

```text
3.80 + 3.50 + 3.70 + 3.90
=
14.90

14.90 / 4
=
3.725
```

### Output

```text
3.725
```

---

# 4️⃣ MAX()

## 📖 Purpose

সবচেয়ে বড় Value বের করে।

### Query

```sql
SELECT MAX(gpa)
FROM students;
```

### Output

```text
3.90
```

কারণ Jannat-এর GPA সর্বোচ্চ।

---

# 5️⃣ MIN()

## 📖 Purpose

সবচেয়ে ছোট Value বের করে।

### Query

```sql
SELECT MIN(gpa)
FROM students;
```

### Output

```text
3.50
```

কারণ Karim-এর GPA সর্বনিম্ন।

---

# 🔥 Multiple Aggregate Functions Together

একই Query-তে একাধিক Aggregate Function ব্যবহার করা যায়।

```sql
SELECT
    COUNT(*) AS total_students,
    AVG(gpa) AS average_gpa,
    MAX(gpa) AS highest_gpa,
    MIN(gpa) AS lowest_gpa
FROM students;
```

### Output

| total_students | average_gpa | highest_gpa | lowest_gpa |
|---------------|-------------|-------------|------------|
| 4 | 3.725 | 3.90 | 3.50 |

---

# 🎯 Aggregate Functions with WHERE

শুধুমাত্র CSE Department-এর Average GPA বের করি।

```sql
SELECT AVG(gpa)
FROM students
WHERE department = 'CSE';
```

### Calculation

```text
3.80 + 3.50
=
7.30

7.30 / 2
=
3.65
```

### Output

```text
3.65
```

---

# 📊 Aggregate Functions with GROUP BY

Department অনুযায়ী Student Count বের করি।

```sql
SELECT
    department,
    COUNT(*) AS total_students
FROM students
GROUP BY department;
```

### Output

| department | total_students |
|------------|----------------|
| CSE | 2 |
| EEE | 1 |
| BBA | 1 |

---

# ⚠️ Aggregate Functions and NULL

Aggregate Functions সাধারণত NULL Value Ignore করে।

ধরো:

| GPA |
|------|
| 3.80 |
| 3.50 |
| NULL |
| 3.90 |

```sql
SELECT AVG(gpa)
FROM students;
```

Calculation:

```text
(3.80 + 3.50 + 3.90)
÷ 3
```

NULL Value Count হবে না।

---

# 🌍 Real World Examples

## Total Revenue

```sql
SELECT SUM(amount)
FROM orders;
```

## Total Customers

```sql
SELECT COUNT(*)
FROM customers;
```

## Highest Paid Employee

```sql
SELECT MAX(salary)
FROM employees;
```

## Lowest Product Price

```sql
SELECT MIN(price)
FROM products;
```

## Average Product Rating

```sql
SELECT AVG(rating)
FROM reviews;
```

---

# 📋 Quick Summary

| Function | Meaning |
|----------|---------|
| COUNT() | মোট Row সংখ্যা |
| SUM() | মোট যোগফল |
| AVG() | গড় |
| MAX() | সর্বোচ্চ মান |
| MIN() | সর্বনিম্ন মান |

---

# 🎤 Interview Answer

### What are Aggregate Functions in SQL?

Aggregate Functions are SQL functions that perform calculations on multiple rows and return a single summarized value.

The most common Aggregate Functions are:

- COUNT()
- SUM()
- AVG()
- MAX()
- MIN()

These functions are widely used in reporting, analytics, dashboards, and data analysis.

---

# 🧠 Easy Memory Trick

```text
COUNT → How Many?

SUM → Total

AVG → Average

MAX → Highest

MIN → Lowest
```

---

# 🚀 Conclusion

```text
Multiple Rows
      ↓
Aggregate Function
      ↓
Single Summary Result
```

Aggregate Functions SQL-এর সবচেয়ে গুরুত্বপূর্ণ Topicগুলোর একটি। Data Analysis, Reporting, Dashboard Development, Business Intelligence (BI), এবং Interview Preparation-এর জন্য `COUNT()`, `SUM()`, `AVG()`, `MAX()`, এবং `MIN()` ভালোভাবে আয়ত্ত করা অত্যন্ত গুরুত্বপূর্ণ।