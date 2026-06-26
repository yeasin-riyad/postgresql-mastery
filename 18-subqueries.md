# 📚 Subqueries in SQL

## 🎯 Introduction

**Subquery** হলো এমন একটি SQL Query যা আরেকটি Query-এর ভিতরে লেখা হয়।

অর্থাৎ,

```text
Query এর ভিতরে Query
```

একে **Nested Query** বা **Inner Query**-ও বলা হয়।

Subquery-এর Result Outer Query ব্যবহার করে Data Filter, Compare অথবা Calculate করতে পারে।

---

# 🤔 Why Use Subqueries?

Subquery ব্যবহার করে সহজেই নিচের মতো Query লেখা যায়—

- Highest GPA পাওয়া Student বের করা
- Average GPA-এর উপরে GPA যাদের আছে তাদের খুঁজে বের করা
- কোনো নির্দিষ্ট Department-এর Students বের করা
- Highest Salary পাওয়া Employee খুঁজে বের করা
- যেসব Customer Order করেছে তাদের বের করা

---

# 🏗 Sample Table

## Students

| student_id | name | department | gpa |
|------------|------|------------|------|
| 1 | Rahim | CSE | 3.80 |
| 2 | Karim | CSE | 3.50 |
| 3 | Hasan | EEE | 3.70 |
| 4 | Jannat | BBA | 3.90 |
| 5 | Mim | CSE | 3.60 |

---

# 📖 What is a Subquery?

Subquery হলো এমন একটি Query যার Result আরেকটি Query ব্যবহার করে।

```text
Outer Query
     │
     ▼
 Subquery
     │
Returns Result
     │
     ▼
Outer Query uses that Result
```

---

# Basic Syntax

```sql
SELECT column_name
FROM table_name
WHERE column_name OPERATOR (

    SELECT column_name
    FROM another_table

);
```

---

# 1️⃣ Single Row Subquery

যখন Subquery মাত্র একটি Value Return করে।

## Example: Find Student with Highest GPA

```sql
SELECT *
FROM students
WHERE gpa = (

    SELECT MAX(gpa)
    FROM students

);
```

### Output

| student_id | name | gpa |
|------------|------|------|
| 4 | Jannat | 3.90 |

---

## How It Works

### Inner Query

```sql
SELECT MAX(gpa)
FROM students;
```

Returns:

```text
3.90
```

Outer Query becomes:

```sql
SELECT *
FROM students
WHERE gpa = 3.90;
```

---

# 2️⃣ Subquery with WHERE

Average GPA-এর চেয়ে বেশি GPA যাদের আছে।

```sql
SELECT *
FROM students
WHERE gpa > (

    SELECT AVG(gpa)
    FROM students

);
```

### Average GPA

```text
(3.80 + 3.50 + 3.70 + 3.90 + 3.60)
/ 5

= 3.70
```

### Output

| Name | GPA |
|------|------|
| Rahim | 3.80 |
| Jannat | 3.90 |

---

# 3️⃣ Multi Row Subquery

যখন Subquery একাধিক Row Return করে।

## Departments Table

| department_id | department_name |
|---------------|-----------------|
| 1 | CSE |
| 2 | EEE |
| 3 | BBA |

## Students Table

| name | department_id |
|------|---------------|
| Rahim | 1 |
| Karim | 1 |
| Hasan | 2 |

---

## Example

```sql
SELECT *
FROM students
WHERE department_id IN (

    SELECT department_id
    FROM departments
    WHERE department_name = 'CSE'

);
```

### Output

| Name |
|------|
| Rahim |
| Karim |

---

# Using IN with Subquery

যখন Subquery একাধিক Value Return করতে পারে তখন `IN` ব্যবহার করা হয়।

```sql
SELECT *
FROM students
WHERE department_id IN (

    SELECT department_id
    FROM departments

);
```

---

# 4️⃣ EXISTS Subquery

যদি Subquery অন্তত একটি Row Return করে তাহলে EXISTS TRUE হয়।

```sql
SELECT *
FROM departments d
WHERE EXISTS (

    SELECT 1
    FROM students s
    WHERE s.department_id = d.department_id

);
```

### Meaning

যেসব Department-এ অন্তত একজন Student আছে সেগুলো Return করবে।

---

# 5️⃣ NOT EXISTS

যেসব Department-এ কোনো Student নেই।

```sql
SELECT *
FROM departments d
WHERE NOT EXISTS (

    SELECT 1
    FROM students s
    WHERE s.department_id = d.department_id

);
```

---

# 6️⃣ Correlated Subquery

Correlated Subquery-তে Inner Query, Outer Query-এর Data ব্যবহার করে।

প্রতিটি Row-এর জন্য Subquery নতুন করে Execute হয়।

---

## Example

Department অনুযায়ী Highest GPA Student বের করা।

```sql
SELECT *
FROM students s1
WHERE gpa = (

    SELECT MAX(gpa)
    FROM students s2
    WHERE s1.department = s2.department

);
```

### Output

| Name | Department | GPA |
|------|------------|------|
| Rahim | CSE | 3.80 |
| Hasan | EEE | 3.70 |
| Jannat | BBA | 3.90 |

---

# 7️⃣ Scalar Subquery

যে Subquery মাত্র একটি Value Return করে তাকে Scalar Subquery বলে।

```sql
SELECT
    name,
    gpa,
    (
        SELECT AVG(gpa)
        FROM students
    ) AS average_gpa
FROM students;
```

---

# 8️⃣ Subquery in SELECT

SELECT Clause-এর মধ্যেও Subquery ব্যবহার করা যায়।

```sql
SELECT
    name,
    (
        SELECT MAX(gpa)
        FROM students
    ) AS highest_gpa
FROM students;
```

---

# 9️⃣ Subquery in FROM (Inline View)

Subquery একটি Temporary Table হিসেবেও কাজ করতে পারে।

```sql
SELECT *
FROM (

    SELECT
        department,
        AVG(gpa) AS average_gpa
    FROM students
    GROUP BY department

) AS department_stats;
```

---

# Types of Subqueries

| Type | Description |
|------|-------------|
| Single Row | Returns one value |
| Multi Row | Returns multiple rows |
| Scalar | Returns one value |
| Correlated | Depends on Outer Query |
| Nested | Query inside another query |
| Inline View | Used inside FROM |

---

# 🌍 Real World Examples

## Employee with Highest Salary

```sql
SELECT *
FROM employees
WHERE salary = (

    SELECT MAX(salary)
    FROM employees

);
```

---

## Products Above Average Price

```sql
SELECT *
FROM products
WHERE price > (

    SELECT AVG(price)
    FROM products

);
```

---

## Customers Who Placed Orders

```sql
SELECT *
FROM customers
WHERE customer_id IN (

    SELECT customer_id
    FROM orders

);
```

---

## Departments Having Students

```sql
SELECT *
FROM departments d
WHERE EXISTS (

    SELECT 1
    FROM students s
    WHERE s.department_id = d.department_id

);
```

---

# 📊 Subquery vs JOIN

| Subquery | JOIN |
|----------|------|
| Easy to understand | Faster in many cases |
| Good for nested logic | Better for large datasets |
| Useful for comparisons | Excellent for relational data |
| Can become slower if nested deeply | Usually better optimized |

---

# 📝 When Should You Use Subqueries?

Use Subqueries when:

- You need a value calculated by another query.
- You need nested filtering.
- You need Aggregate Function results for comparison.
- You want simpler readable queries.

Use JOIN when:

- Data comes from multiple related tables.
- Performance is important.
- You need columns from multiple tables.

---

# 📊 Summary Table

| Clause | Can Use Subquery? |
|---------|-------------------|
| SELECT | ✅ Yes |
| FROM | ✅ Yes |
| WHERE | ✅ Yes |
| HAVING | ✅ Yes |
| INSERT | ✅ Yes |
| UPDATE | ✅ Yes |
| DELETE | ✅ Yes |

---

# 🎤 Interview Answer

### What is a Subquery in SQL?

A Subquery is a SQL query written inside another SQL query. The result of the inner query is used by the outer query for filtering, comparison, or calculation.

There are several types of subqueries:

- Single Row Subquery
- Multi Row Subquery
- Scalar Subquery
- Correlated Subquery
- Inline View

Subqueries can be used inside the `SELECT`, `FROM`, `WHERE`, and `HAVING` clauses.

---

# 🧠 Easy Memory Trick

```text
Subquery
=
Query inside Query

Single Row
=
One Value

Multi Row
=
Many Values

Scalar
=
Single Value

Correlated
=
Depends on Outer Query

Inline View
=
Temporary Table
```

---

# 🚀 Conclusion

```text
Outer Query
      │
      ▼
  Subquery
      │
Returns Result
      │
      ▼
Outer Query Uses That Result
```

Subquery হলো SQL-এর অন্যতম শক্তিশালী Feature। এটি Complex Filtering, Reporting, Analytics, Business Logic এবং Technical Interview-এর জন্য অত্যন্ত গুরুত্বপূর্ণ। JOIN-এর পাশাপাশি Subquery ভালোভাবে আয়ত্ত করলে Complex SQL Query লেখা অনেক সহজ হয়ে যায়।