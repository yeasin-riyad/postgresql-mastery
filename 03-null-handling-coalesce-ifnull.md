# 📚 NULL Handling with COALESCE and IFNULL in SQL

## 🎯 Introduction

Database-এ `NULL` একটি বিশেষ Value, যা বোঝায় **কোনো তথ্য নেই (Missing Value)** অথবা **তথ্য অজানা (Unknown Value)**।

অনেক সময় Query Result-এ NULL দেখানোর পরিবর্তে আমরা একটি Default Value দেখাতে চাই, যেমন:

* `0`
* `N/A`
* `Not Provided`
* `Unknown`

এই সমস্যার সমাধানের জন্য SQL-এ `COALESCE()` এবং `IFNULL()` ব্যবহার করা হয়।

---

# 🤔 NULL কী?

ধরো Employees Table:

| EmployeeID | Name  | Salary |
| ---------- | ----- | ------ |
| 1          | Rahim | 50000  |
| 2          | Karim | NULL   |

এখানে Karim-এর Salary জানা নেই।

---

## Query

```sql
SELECT name, salary
FROM employees;
```

### Result

| Name  | Salary |
| ----- | ------ |
| Rahim | 50000  |
| Karim | NULL   |

অনেক ক্ষেত্রে আমরা NULL-এর পরিবর্তে 0 দেখাতে চাই।

---

# 1️⃣ COALESCE()

## 📖 Definition

`COALESCE()` প্রথম Non-NULL Value Return করে।

### Syntax

```sql
COALESCE(value1, value2, value3, ...)
```

Database বাম থেকে ডানে Value Check করে।

প্রথম যে Value NULL নয়, সেটি Return করে।

---

# 🔹 Example 1: Replace NULL with 0

### Query

```sql
SELECT
    name,
    COALESCE(salary, 0) AS salary
FROM employees;
```

### Table

| Name  | Salary |
| ----- | ------ |
| Rahim | 50000  |
| Karim | NULL   |

### Result

| Name  | Salary |
| ----- | ------ |
| Rahim | 50000  |
| Karim | 0      |

---

# 🔹 Example 2: Replace NULL with Text

### Query

```sql
SELECT
    name,
    COALESCE(phone, 'Not Provided') AS phone
FROM employees;
```

### Data

| Name  | Phone       |
| ----- | ----------- |
| Rahim | 01711111111 |
| Karim | NULL        |

### Result

| Name  | Phone        |
| ----- | ------------ |
| Rahim | 01711111111  |
| Karim | Not Provided |

---

# 🔹 Example 3: Multiple Values

```sql
SELECT
    COALESCE(
        office_phone,
        personal_phone,
        emergency_phone,
        'No Contact Number'
    ) AS contact
FROM employees;
```

---

### Scenario

```text
office_phone     = NULL
personal_phone   = NULL
emergency_phone  = 01888888888
```

### Result

```text
01888888888
```

কারণ এটি প্রথম Non-NULL Value।

---

# 🧠 COALESCE Visualization

```text
COALESCE(
    NULL,
    NULL,
    'Rahim',
    'Karim'
)

↓

Returns

'Rahim'
```

---

# 2️⃣ IFNULL()

## 📖 Definition

`IFNULL()` দুটি Value Check করে।

যদি প্রথম Value NULL হয়, তাহলে দ্বিতীয় Value Return করে।

### Syntax

```sql
IFNULL(value, replacement)
```

---

# 🔹 Example

```sql
SELECT
    name,
    IFNULL(salary, 0) AS salary
FROM employees;
```

---

### Result

| Name  | Salary |
| ----- | ------ |
| Rahim | 50000  |
| Karim | 0      |

---

# 🧠 IFNULL Visualization

```text
IFNULL(NULL, 100)

↓

Returns

100
```

---

```text
IFNULL(500, 100)

↓

Returns

500
```

---

# 📊 COALESCE vs IFNULL

| Feature         | COALESCE    | IFNULL          |
| --------------- | ----------- | --------------- |
| SQL Standard    | ✅ Yes       | ❌ No            |
| PostgreSQL      | ✅ Supported | ❌ Not Supported |
| MySQL           | ✅ Supported | ✅ Supported     |
| SQL Server      | ✅ Supported | ❌ Not Supported |
| Multiple Values | ✅ Yes       | ❌ No            |
| Arguments       | Unlimited   | Only 2          |

---

# 🚨 PostgreSQL Users Must Know

### ❌ Wrong

```sql
SELECT IFNULL(salary, 0)
FROM employees;
```

PostgreSQL Error দিবে।

---

### ✅ Correct

```sql
SELECT COALESCE(salary, 0)
FROM employees;
```

---

# 🌍 Real World Example

ধরো একটি E-Commerce System:

| Product | Discount |
| ------- | -------- |
| Laptop  | 10       |
| Mouse   | NULL     |

---

### Query

```sql
SELECT
    product_name,
    COALESCE(discount, 0) AS discount
FROM products;
```

### Result

| Product | Discount |
| ------- | -------- |
| Laptop  | 10       |
| Mouse   | 0        |

---

# 🎯 Common Uses of COALESCE

## Replace NULL with 0

```sql
COALESCE(amount, 0)
```

---

## Replace NULL with Text

```sql
COALESCE(phone, 'Not Available')
```

---

## Replace NULL Date

```sql
COALESCE(join_date, CURRENT_DATE)
```

---

## Use Multiple Backup Values

```sql
COALESCE(
    mobile,
    office_phone,
    home_phone
)
```

---

# 📊 Real Interview Example

### Without COALESCE

```sql
SELECT
    product_name,
    price - discount AS final_price
FROM products;
```

যদি discount NULL হয়:

```text
Final Price = NULL
```

---

### With COALESCE

```sql
SELECT
    product_name,
    price - COALESCE(discount, 0) AS final_price
FROM products;
```

এখন Discount NULL হলেও Query ঠিকমতো কাজ করবে।

---

# 🎤 Interview Answer

### What is COALESCE in SQL?

COALESCE() returns the first non-NULL value from a list of expressions. It is a standard SQL function commonly used to replace NULL values with default values.

### What is IFNULL?

IFNULL() checks two values and returns the second value if the first value is NULL. It is commonly used in MySQL but is not supported in PostgreSQL.

---

# 🧠 Easy Memory Trick

```text
COALESCE
=
Choose First Non-NULL Value

IFNULL
=
If NULL Then Use This
```

---

# 📋 Quick Summary

| Function   | Purpose                              |
| ---------- | ------------------------------------ |
| COALESCE() | Returns first non-NULL value         |
| IFNULL()   | Returns replacement if value is NULL |
| PostgreSQL | Use COALESCE()                       |
| MySQL      | Use COALESCE() or IFNULL()           |

---

# 🚀 Conclusion

NULL Values Database Query-তে অনেক সমস্যা তৈরি করতে পারে।

`COALESCE()` ব্যবহার করে:

✅ NULL Handle করা যায়

✅ Better Reports তৈরি করা যায়

✅ Calculations Safe হয়

✅ Query Result User-Friendly হয়

Production-Level PostgreSQL Applications-এ `COALESCE()` ব্যবহার করাই Best Practice।
