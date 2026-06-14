# 📚 Table Aliases in SQL

## 🎯 Introduction

SQL Query লেখার সময় অনেক Table-এর নাম বড় এবং জটিল হতে পারে।

উদাহরণ:

```text
students
departments
employee_information
customer_orders
```

বারবার পুরো Table Name লিখলে Query:

* বড় হয়ে যায়
* পড়তে কঠিন হয়
* লিখতে বেশি সময় লাগে

এই সমস্যার সমাধান হলো **Table Alias**।

---

# 🤔 What is a Table Alias?

Table Alias হলো Table-এর একটি **Temporary Short Name**।

এটি শুধুমাত্র Query Execution-এর সময় ব্যবহৃত হয়।

Database-এর আসল Table Name পরিবর্তন হয় না।

---

# 📌 Basic Syntax

## Using AS Keyword

```sql
SELECT columns
FROM table_name AS alias_name;
```

## Without AS Keyword

```sql
SELECT columns
FROM table_name alias_name;
```

দুইটিই একই কাজ করে।

---

# 🏗 Example Without Alias

```sql
SELECT
    students.student_id,
    students.name
FROM students;
```

এখানে বারবার `students.` লিখতে হচ্ছে।

---

# ✅ Example With Alias

```sql
SELECT
    s.student_id,
    s.name
FROM students AS s;
```

এখানে:

```text
students → s
```

Query ছোট এবং পরিষ্কার হয়েছে।

---

# 🏗 Sample Tables

## Students

| student_id | name  | department_id |
| ---------- | ----- | ------------- |
| 1          | Rahim | 1             |
| 2          | Karim | 1             |
| 3          | Hasan | 2             |

---

## Departments

| department_id | department_name |
| ------------- | --------------- |
| 1             | CSE             |
| 2             | EEE             |

---

# 🤔 Why Aliases Are Important in JOIN?

JOIN করার সময় অনেক Table-এ একই Column Name থাকতে পারে।

যেমন:

```text
department_id
```

Students এবং Departments উভয় Table-এই আছে।

তখন Database বুঝতে পারে না কোন Column ব্যবহার করা হচ্ছে।

---

# ❌ Ambiguous Query

```sql
SELECT department_id
FROM students
JOIN departments
ON students.department_id =
departments.department_id;
```

Error:

```text
column reference "department_id" is ambiguous
```

কারণ Database বুঝতে পারে না কোন Table-এর `department_id` ব্যবহার করা হচ্ছে।

---

# ✅ Correct Query Using Alias

```sql
SELECT
    s.student_id,
    s.name,
    d.department_name
FROM students s
JOIN departments d
    ON s.department_id = d.department_id;
```

---

# 🔍 Query Explanation

```sql
students s
```

মানে:

```text
students → s
```

---

```sql
departments d
```

মানে:

```text
departments → d
```

---

```sql
s.department_id
```

মানে:

```text
students.department_id
```

---

```sql
d.department_name
```

মানে:

```text
departments.department_name
```

---

# 📚 Column Alias vs Table Alias

SQL-এ দুই ধরনের Alias আছে:

1. Table Alias
2. Column Alias

---

# Table Alias Example

```sql
SELECT *
FROM students s;
```

এখানে:

```text
s = Table Alias
```

---

# Column Alias Example

```sql
SELECT
    name AS student_name
FROM students;
```

### Output

| student_name |
| ------------ |
| Rahim        |
| Karim        |

এখানে:

```text
student_name = Column Alias
```

---

# 🏗 Multiple Table Alias Example

```sql
SELECT
    s.name AS student,
    d.department_name AS department
FROM students s
JOIN departments d
    ON s.department_id = d.department_id;
```

---

# 🔄 Self Join with Alias

ধরো একটি Employee Table আছে:

| employee_id | name  | manager_id |
| ----------- | ----- | ---------- |
| 1           | Rahim | NULL       |
| 2           | Karim | 1          |
| 3           | Hasan | 1          |

একই Table দুইবার Join করতে হবে।

---

```sql
SELECT
    e.name AS employee,
    m.name AS manager
FROM employees e
LEFT JOIN employees m
    ON e.manager_id = m.employee_id;
```

---

## Output

| employee | manager |
| -------- | ------- |
| Karim    | Rahim   |
| Hasan    | Rahim   |

এখানে:

```text
e = employee
m = manager
```

একই Table-এর দুইটি আলাদা Role বোঝাতে Alias ব্যবহার করা হয়েছে।

---

# ✅ Best Practices

### ভালো Alias

```text
s → students
d → departments
c → customers
o → orders
e → employees
```

---

### খারাপ Alias

```text
x
abc
table1
```

কারণ এগুলো বুঝতে কঠিন।

---

# 📊 Summary Table

| Alias | Meaning     |
| ----- | ----------- |
| s     | students    |
| d     | departments |
| c     | customers   |
| o     | orders      |
| e     | employees   |

---

# 🎤 Interview Answer

### What is a Table Alias in SQL?

A Table Alias is a temporary name assigned to a table during query execution. It makes queries shorter, easier to read, and helps avoid ambiguity when working with joins.

Example:

```sql
SELECT s.name
FROM students s;
```

Here, `s` is an alias for the `students` table.

---

# 🧠 Easy Memory Trick

```text
Alias
=
Nickname

students
   ↓
s

departments
   ↓
d
```

---

# 🚀 Conclusion

```text
Table Alias
      ↓
Shorter Queries
      ↓
Cleaner Code
      ↓
Easy JOINs
```

JOIN, Self Join এবং Complex SQL Query লেখার সময় Table Alias ব্যবহার করা একটি Professional Practice এবং Interview-এ খুবই গুরুত্বপূর্ণ Topic।
