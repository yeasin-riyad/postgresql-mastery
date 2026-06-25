# 📚 COUNT DISTINCT in SQL

## 🎯 Introduction

`COUNT()` ব্যবহার করা হয় মোট কতটি Row আছে তা গণনা করার জন্য।

কিন্তু অনেক সময় আমরা জানতে চাই:

- কতটি Unique Department আছে?
- কতজন Unique Customer আছে?
- কতটি Unique Product Category আছে?
- কতটি Unique City আছে?

এই ধরনের ক্ষেত্রে `COUNT(DISTINCT column_name)` ব্যবহার করা হয়।

---

## 🤔 What is COUNT(DISTINCT)?

`COUNT(DISTINCT)` প্রথমে Duplicate Values Remove করে, তারপর Remaining Unique Values Count করে।

```text
Data
 ↓
DISTINCT
(Remove Duplicates)
 ↓
COUNT
(Count Remaining Values)
 ↓
Unique Count
```

---

# 🏗 Sample Table

## Students

| student_id | name   | department |
| ---------- | ------ | ---------- |
| 1 | Rahim | CSE |
| 2 | Karim | CSE |
| 3 | Hasan | EEE |
| 4 | Jannat | BBA |
| 5 | Nusrat | CSE |

---

# COUNT(*) vs COUNT(DISTINCT)

## COUNT(*)

```sql
SELECT COUNT(*)
FROM students;
```

### Output

```text
5
```

কারণ Table-এ মোট ৫টি Row আছে।

---

## COUNT(DISTINCT department)

```sql
SELECT COUNT(DISTINCT department)
FROM students;
```

### Output

```text
3
```

কারণ Unique Department হলো:

```text
CSE
EEE
BBA
```

---

# How DISTINCT Works

Original Values:

```text
CSE
CSE
EEE
BBA
CSE
```

DISTINCT Apply করার পর:

```text
CSE
EEE
BBA
```

এরপর COUNT:

```text
3
```

---

# Example 1: Count Unique Departments

```sql
SELECT COUNT(DISTINCT department)
FROM students;
```

### Output

```text
3
```

---

# Example 2: Count Unique GPA Values

ধরো:

| GPA |
|------|
| 3.80 |
| 3.50 |
| 3.80 |
| 3.90 |

```sql
SELECT COUNT(DISTINCT gpa)
FROM students;
```

### Output

```text
3
```

কারণ Unique GPA:

```text
3.80
3.50
3.90
```

---

# Example 3: Count Unique Cities

## Customers Table

| customer_id | city |
|------------|------|
| 1 | Dhaka |
| 2 | Dhaka |
| 3 | Chattogram |
| 4 | Sylhet |
| 5 | Sylhet |

```sql
SELECT COUNT(DISTINCT city)
FROM customers;
```

### Output

```text
3
```

Unique Cities:

```text
Dhaka
Chattogram
Sylhet
```

---

# COUNT(DISTINCT) with WHERE

শুধুমাত্র CSE Department-এর Unique GPA Count করি।

```sql
SELECT COUNT(DISTINCT gpa)
FROM students
WHERE department = 'CSE';
```

---

# DISTINCT Without COUNT

Unique Values দেখতে চাইলে:

```sql
SELECT DISTINCT department
FROM students;
```

### Output

```text
CSE
EEE
BBA
```

---

# COUNT(column) vs COUNT(DISTINCT column)

ধরো:

| department |
|------------|
| CSE |
| CSE |
| EEE |
| BBA |
| CSE |

---

## COUNT(department)

```sql
SELECT COUNT(department)
FROM students;
```

### Output

```text
5
```

সব Non-NULL Value Count হবে।

---

## COUNT(DISTINCT department)

```sql
SELECT COUNT(DISTINCT department)
FROM students;
```

### Output

```text
3
```

শুধুমাত্র Unique Value Count হবে।

---

# NULL Handling

ধরো:

| department |
|------------|
| CSE |
| CSE |
| NULL |
| EEE |

```sql
SELECT COUNT(DISTINCT department)
FROM students;
```

### Output

```text
2
```

কারণ:

```text
CSE
EEE
```

`NULL` Count করা হয় না।

---

# COUNT(DISTINCT) with GROUP BY

প্রতিটি Department-এ কতটি Unique GPA আছে?

```sql
SELECT
    department,
    COUNT(DISTINCT gpa) AS unique_gpa_count
FROM students
GROUP BY department;
```

---

## Example Output

| department | unique_gpa_count |
|------------|------------------|
| CSE | 3 |
| EEE | 1 |
| BBA | 1 |

---

# 🌍 Real World Examples

## Count Unique Customers

```sql
SELECT COUNT(DISTINCT customer_id)
FROM orders;
```

---

## Count Unique Product Categories

```sql
SELECT COUNT(DISTINCT category)
FROM products;
```

---

## Count Unique Website Visitors

```sql
SELECT COUNT(DISTINCT user_id)
FROM website_visits;
```

---

## Count Unique Countries

```sql
SELECT COUNT(DISTINCT country)
FROM users;
```

---

# 📊 Summary Table

| Function | Meaning |
|-----------|----------|
| COUNT(*) | Total Rows Count |
| COUNT(column) | Non-NULL Values Count |
| DISTINCT | Remove Duplicate Values |
| COUNT(DISTINCT column) | Count Unique Values |

---

# ⚠️ Common Mistakes

## Mistake 1

```sql
SELECT DISTINCT COUNT(department)
FROM students;
```

এটি Unique Department Count করবে না।

---

## Correct

```sql
SELECT COUNT(DISTINCT department)
FROM students;
```

---

## Mistake 2

ধারণা করা যে NULL Count হবে।

```sql
SELECT COUNT(DISTINCT department)
FROM students;
```

NULL Values Ignore করা হয়।

---

# 🎤 Interview Answer

### What is COUNT(DISTINCT) in SQL?

`COUNT(DISTINCT column_name)` is used to count the number of unique non-NULL values in a column. It first removes duplicate values and then counts the remaining distinct values.

Example:

```sql
SELECT COUNT(DISTINCT department)
FROM students;
```

This query returns the total number of unique departments.

---

# 🧠 Easy Memory Trick

```text
COUNT(*)
=
Total Rows

DISTINCT
=
Remove Duplicates

COUNT(DISTINCT)
=
Count Unique Values
```

---

# 🚀 Conclusion

```text
Raw Data
    ↓
DISTINCT
(Removes Duplicates)
    ↓
COUNT
(Counts Unique Values)
    ↓
Final Result
```

`COUNT(DISTINCT)` SQL-এর অন্যতম গুরুত্বপূর্ণ Aggregate Technique। এটি Reporting, Analytics, Dashboard Development, Data Analysis এবং SQL Interview Preparation-এর জন্য অত্যন্ত গুরুত্বপূর্ণ।