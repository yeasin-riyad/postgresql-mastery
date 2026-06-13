# 📚 PostgreSQL: Creating Databases & Schemas (Complete Bangla Guide)

## 🎯 Introduction

PostgreSQL-এ **Database** এবং **Schema** হলো Data Organization-এর দুইটি গুরুত্বপূর্ণ স্তর।

একটি PostgreSQL Server-এর ভিতরে একাধিক Database থাকতে পারে, এবং প্রতিটি Database-এর ভিতরে একাধিক Schema থাকতে পারে।

```text
PostgreSQL Server
│
├── Database
│     │
│     ├── Schema
│     │      ├── Tables
│     │      ├── Views
│     │      ├── Functions
│     │      └── Indexes
│     │
│     └── Schema
│
└── Database
```

---

# 🏗️ What is a Database?

Database হলো একটি Top-Level Container যেখানে Application-এর সমস্ত Data এবং Database Objects সংরক্ষণ করা হয়।

একটি Database-এর ভিতরে থাকতে পারে:

* Tables
* Views
* Functions
* Procedures
* Schemas
* Indexes
* Triggers

---

# 🚀 Creating a Database

## Basic Database Creation

```sql
CREATE DATABASE university_db;
```

---

## Create Database with Owner

```sql
CREATE DATABASE university_db
OWNER postgres;
```

---

## Create Database with UTF-8 Encoding

```sql
CREATE DATABASE university_db
ENCODING 'UTF8';
```

---

## Create Database with Multiple Options

```sql
CREATE DATABASE ecommerce_db
OWNER postgres
ENCODING 'UTF8'
LC_COLLATE='en_US.UTF-8'
LC_CTYPE='en_US.UTF-8';
```

---

# 🔍 View All Databases

```sql
SELECT datname
FROM pg_database;
```

---

# 📌 Current Database

বর্তমানে কোন Database-এ Connected আছো তা দেখতে:

```sql
SELECT current_database();
```

---

# 🔄 Connect to Database

psql Terminal-এ:

```sql
\c university_db
```

---

# ✏️ Rename Database

```sql
ALTER DATABASE university_db
RENAME TO university_management;
```

---

# ❌ Delete Database

```sql
DROP DATABASE university_management;
```

---

## Safe Delete

```sql
DROP DATABASE IF EXISTS university_management;
```

---

# 📂 What is a Schema?

Schema হলো Database-এর ভিতরে থাকা একটি Logical Namespace বা Folder।

Schema ব্যবহার করে Database Objects সুন্দরভাবে Organize করা যায়।

---

## Without Schema

```text
Database
│
├── Students
├── Teachers
├── Courses
├── Departments
├── Payments
└── Employees
```

---

## With Schema

```text
Database
│
├── academic
│     ├── Students
│     ├── Courses
│
├── hr
│     ├── Employees
│     ├── Payroll
│
└── finance
      ├── Payments
      ├── Invoices
```

---

# 🎯 Why Use Schemas?

### Benefits

✅ Better Organization

✅ Improved Security

✅ Easier Maintenance

✅ Avoid Naming Conflicts

✅ Enterprise-Level Structure

---

# 🏗️ Creating Schemas

## Basic Example

```sql
CREATE SCHEMA academic;
```

---

## Multiple Schemas

```sql
CREATE SCHEMA hr;

CREATE SCHEMA finance;

CREATE SCHEMA inventory;
```

---

## Schema with Owner

```sql
CREATE SCHEMA academic
AUTHORIZATION postgres;
```

---

# 🔍 View All Schemas

```sql
SELECT schema_name
FROM information_schema.schemata;
```

---

# 📋 Create Tables Inside a Schema

## Academic Schema

```sql
CREATE TABLE academic.students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);
```

---

# ➕ Insert Data

```sql
INSERT INTO academic.students
(name, email)
VALUES
('Rahim', 'rahim@gmail.com');
```

---

# 📖 Retrieve Data

```sql
SELECT *
FROM academic.students;
```

---

# 🏗️ Same Table Name in Different Schemas

PostgreSQL-এ একই নামের Table একাধিক Schema-এ রাখা যায়।

---

## Academic Schema

```sql
CREATE TABLE academic.students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);
```

---

## Alumni Schema

```sql
CREATE SCHEMA alumni;

CREATE TABLE alumni.students (
    student_id SERIAL PRIMARY KEY,
    graduation_year INT
);
```

---

### Valid Tables

```text
academic.students

alumni.students
```

দুইটিই Valid কারণ Schema আলাদা।

---

# ⚙️ Search Path

প্রতিবার Schema Name না লিখতে চাইলে Search Path ব্যবহার করা যায়।

---

## Set Search Path

```sql
SET search_path TO academic;
```

---

এখন:

```sql
SELECT *
FROM students;
```

PostgreSQL Automatically বুঝবে:

```sql
SELECT *
FROM academic.students;
```

---

# 🔍 Check Current Search Path

```sql
SHOW search_path;
```

---

# ✏️ Rename Schema

```sql
ALTER SCHEMA academic
RENAME TO academics;
```

---

# ❌ Delete Schema

```sql
DROP SCHEMA academics;
```

---

# ⚠️ Delete Schema with All Objects

```sql
DROP SCHEMA academics CASCADE;
```

---

এটি Delete করবে:

```text
Schema
Tables
Views
Functions
Indexes
Triggers
```

---

# 🎓 Complete University Database Example

## Step 1: Create Database

```sql
CREATE DATABASE university_db;
```

---

## Step 2: Connect Database

```sql
\c university_db
```

---

## Step 3: Create Schemas

```sql
CREATE SCHEMA academic;

CREATE SCHEMA hr;

CREATE SCHEMA finance;
```

---

## Step 4: Create Academic Tables

### Students

```sql
CREATE TABLE academic.students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);
```

---

### Courses

```sql
CREATE TABLE academic.courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL
);
```

---

## Step 5: Create HR Tables

```sql
CREATE TABLE hr.employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    salary NUMERIC(10,2)
);
```

---

## Step 6: Create Finance Tables

```sql
CREATE TABLE finance.payments (
    payment_id SERIAL PRIMARY KEY,
    amount NUMERIC(10,2),
    payment_date DATE
);
```

---

# 🌍 Real World Enterprise Structure

```text
company_db
│
├── hr
│   ├── employees
│   ├── payroll
│
├── sales
│   ├── orders
│   ├── customers
│
├── inventory
│   ├── products
│   ├── stock
│
└── finance
    ├── invoices
    ├── payments
```

---

# 📊 Database vs Schema

| Feature   | Database                   | Schema                    |
| --------- | -------------------------- | ------------------------- |
| Level     | Top-Level Container        | Namespace Inside Database |
| Contains  | Schemas, Tables, Functions | Tables, Views, Functions  |
| Purpose   | Separate Applications/Data | Organize Objects          |
| Isolation | Strong                     | Logical                   |

---

# 🎤 Interview Questions

## Q1: Difference Between Database and Schema?

### Database

A Database is a top-level container that stores all database objects and data.

### Schema

A Schema is a logical namespace used to organize objects inside a database.

---

## Q2: Can Two Schemas Have the Same Table Name?

✅ Yes

Example:

```text
academic.students

alumni.students
```

Both are completely valid.

---

## Q3: Why Use Schemas?

* Better Organization
* Security Separation
* Easier Maintenance
* Avoid Naming Conflicts

---

# 🧠 Easy Memory Trick

```text
PostgreSQL Server
        │
        ▼
     Database
        │
        ▼
      Schema
        │
        ▼
       Table
```

---

# 🚀 Conclusion

Database এবং Schema PostgreSQL-এর Core Organizational Concepts।

* Database = Large Container
* Schema = Folder/Namespace
* Table = Actual Data Storage

একটি ভালো PostgreSQL Design-এ Database এবং Schema Structure সঠিকভাবে Design করা হলে Application আরও Maintainable, Secure এবং Scalable হয়।
