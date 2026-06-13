# 📚 Constraints and Primary Keys in SQL (বাংলা)

## 🎯 পরিচিতি

Database-এ **Constraints** হলো এমন কিছু Rules যা Table-এর Data-এর উপর প্রয়োগ করা হয়, যাতে Invalid Data Insert, Update বা Delete করা না যায়।

**Primary Key** হলো একটি বিশেষ Constraint যা প্রতিটি Row-কে Uniquely Identify করে।

একটি ভালো Database Design-এর অন্যতম ভিত্তি হলো সঠিকভাবে Constraints ব্যবহার করা।

---

# 🤔 Constraints কেন গুরুত্বপূর্ণ?

Constraints ব্যবহার করলে:

✅ Data Accuracy বজায় থাকে

✅ Invalid Data Insert করা যায় না

✅ Duplicate Data প্রতিরোধ করা যায়

✅ Data Integrity নিশ্চিত হয়

✅ Table Relationship সঠিক থাকে

---

# 📊 Common SQL Constraints

| Constraint  | কাজ                           |
| ----------- | ----------------------------- |
| NOT NULL    | Value অবশ্যই থাকতে হবে        |
| UNIQUE      | Duplicate Value Allow করবে না |
| PRIMARY KEY | Unique + NOT NULL             |
| FOREIGN KEY | Table Relationship তৈরি করে   |
| CHECK       | Custom Rule তৈরি করে          |
| DEFAULT     | Default Value Set করে         |

---

# 1️⃣ NOT NULL Constraint

## 📖 Definition

`NOT NULL` Constraint নিশ্চিত করে যে Column-এ Value অবশ্যই দিতে হবে।

### Example

```sql
CREATE TABLE students (

    student_id INT,

    name VARCHAR(100) NOT NULL

);
```

### ✅ Valid Insert

```sql
INSERT INTO students
VALUES (101, 'Rahim');
```

### ❌ Invalid Insert

```sql
INSERT INTO students
VALUES (102, NULL);
```

Error হবে, কারণ `name` NULL হতে পারবে না।

---

# 2️⃣ UNIQUE Constraint

## 📖 Definition

`UNIQUE` Constraint Duplicate Value Prevent করে।

### Example

```sql
CREATE TABLE students (

    student_id INT,

    email VARCHAR(255) UNIQUE

);
```

### ✅ Valid

```sql
INSERT INTO students
VALUES (101, 'rahim@gmail.com');
```

```sql
INSERT INTO students
VALUES (102, 'karim@gmail.com');
```

### ❌ Invalid

```sql
INSERT INTO students
VALUES (103, 'rahim@gmail.com');
```

কারণ Email Duplicate।

---

# 3️⃣ PRIMARY KEY

## 📖 Definition

Primary Key হলো এমন একটি Column (বা Column Combination) যা প্রতিটি Record-কে Uniquely Identify করে।

### Primary Key-এর Rules

### Rule 1: Must Be Unique

```text
Duplicate Value Allowed নয়
```

### Rule 2: Cannot Be NULL

```text
NULL Value Allowed নয়
```

### Rule 3: One Primary Key Per Table

একটি Table-এ শুধুমাত্র একটি Primary Key থাকে।

---

## Example

| StudentID | Name   |
| --------- | ------ |
| 101       | Rahim  |
| 102       | Karim  |
| 103       | Jannat |

এখানে `StudentID` হলো Primary Key।

### SQL Example

```sql
CREATE TABLE students (

    student_id INT PRIMARY KEY,

    name VARCHAR(100)

);
```

### ✅ Valid Insert

```sql
INSERT INTO students
VALUES (101, 'Rahim');
```

### ❌ Duplicate Value

```sql
INSERT INTO students
VALUES (101, 'Karim');
```

### ❌ NULL Value

```sql
INSERT INTO students
VALUES (NULL, 'Karim');
```

উভয় ক্ষেত্রেই Error হবে।

---

# 🧠 Primary Key কেন দরকার?

ধরো Table-এ তিনজন Rahim আছে।

| Name  |
| ----- |
| Rahim |
| Rahim |
| Rahim |

এখন কোন Rahim-এর Data Update করবে?

বোঝা কঠিন।

Primary Key ব্যবহার করলে:

| StudentID | Name  |
| --------- | ----- |
| 101       | Rahim |
| 102       | Rahim |
| 103       | Rahim |

প্রতিটি Record Unique হয়ে যায়।

---

# 4️⃣ Composite Primary Key

## 📖 Definition

একাধিক Column মিলে Primary Key তৈরি করলে তাকে Composite Primary Key বলে।

### Example

| StudentID | CourseID |
| --------- | -------- |
| 101       | C1       |
| 101       | C2       |

### SQL Example

```sql
CREATE TABLE enrollments (

    student_id INT,

    course_id INT,

    PRIMARY KEY (
        student_id,
        course_id
    )

);
```

### ✅ Valid

```text
(101, C1)
(101, C2)
```

### ❌ Invalid

```text
(101, C1)
(101, C1)
```

কারণ পুরো Combination Duplicate।

---

# 5️⃣ CHECK Constraint

## 📖 Definition

CHECK Constraint Custom Business Rules Apply করতে ব্যবহৃত হয়।

### Example

```sql
CREATE TABLE students (

    student_id INT PRIMARY KEY,

    age INT CHECK(age >= 18)

);
```

### ✅ Valid

```sql
INSERT INTO students
VALUES (101, 20);
```

### ❌ Invalid

```sql
INSERT INTO students
VALUES (102, 15);
```

কারণ Age 18-এর কম।

---

# 6️⃣ DEFAULT Constraint

## 📖 Definition

যদি Value না দেওয়া হয়, তাহলে Default Value Assign করা হয়।

### Example

```sql
CREATE TABLE users (

    user_id SERIAL PRIMARY KEY,

    is_active BOOLEAN DEFAULT TRUE

);
```

### Insert

```sql
INSERT INTO users DEFAULT VALUES;
```

### Result

```text
is_active = TRUE
```

---

# 7️⃣ FOREIGN KEY Constraint

## 📖 Definition

Foreign Key একটি Table-এর Column-কে অন্য Table-এর Primary Key-এর সাথে Connect করে।

### Students Table

| StudentID |
| --------- |
| 101       |
| 102       |

### Enrollments Table

| StudentID |
| --------- |
| 101       |

### SQL Example

```sql
CREATE TABLE enrollments (

    enrollment_id SERIAL PRIMARY KEY,

    student_id INT,

    FOREIGN KEY (student_id)
    REFERENCES students(student_id)

);
```

### ❌ Invalid Insert

```sql
INSERT INTO enrollments
VALUES (1, 999);
```

কারণ Students Table-এ StudentID 999 নেই।

---

# 🎨 Relationship Visualization

```text
Students
───────────────
student_id (PK)
name

       │
       │
       ▼

Enrollments
────────────────────
enrollment_id (PK)
student_id (FK)
course_name
```

---

# 📊 PRIMARY KEY vs UNIQUE

| Feature         | PRIMARY KEY | UNIQUE    |
| --------------- | ----------- | --------- |
| Unique Values   | ✅           | ✅         |
| NULL Allowed    | ❌           | Usually ✅ |
| Count Per Table | 1           | Multiple  |
| Main Identifier | ✅           | ❌         |

---

# 🌍 Real-World Example

```sql
CREATE TABLE users (

    user_id SERIAL PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    email VARCHAR(255) UNIQUE,

    age INT CHECK(age >= 18),

    is_active BOOLEAN DEFAULT TRUE

);
```

এই Table-এ:

| Constraint  | Purpose                |
| ----------- | ---------------------- |
| PRIMARY KEY | Unique User ID         |
| NOT NULL    | Name Required          |
| UNIQUE      | Email Duplicate হবে না |
| CHECK       | Age ≥ 18               |
| DEFAULT     | Active User            |

---

# 🎤 Interview Answer

### What are Constraints in SQL?

Constraints are rules applied to database columns to maintain data accuracy, consistency, and integrity.

Common constraints are:

* NOT NULL
* UNIQUE
* PRIMARY KEY
* FOREIGN KEY
* CHECK
* DEFAULT

### What is a Primary Key?

A Primary Key is a column (or set of columns) that uniquely identifies each row in a table. It must be unique and cannot contain NULL values.

---

# 🧠 Easy Memory Trick

```text
NOT NULL
↓
Value Required

UNIQUE
↓
No Duplicate

PRIMARY KEY
↓
Unique + Not Null

FOREIGN KEY
↓
Relationship

CHECK
↓
Custom Rule

DEFAULT
↓
Default Value
```

---

# 🚀 Conclusion

Constraints হলো Database-এর Security Guards।

```text
Constraints
      ↓
Valid Data
      ↓
Better Integrity
      ↓
Reliable Database
```

আর Primary Key হলো Table-এর Identity Card, যা প্রতিটি Record-কে Unique ভাবে চিহ্নিত করে।
