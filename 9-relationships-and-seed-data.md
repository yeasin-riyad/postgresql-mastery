# 📚 Relationships and Seed Data in Database

## 🎯 Introduction

Database Design-এর সবচেয়ে গুরুত্বপূর্ণ বিষয়গুলোর মধ্যে একটি হলো **Relationships**।

আর Database তৈরি করার পর Test বা Development-এর জন্য কিছু Sample Data Insert করা হয়, যাকে বলা হয় **Seed Data**।

একটি ভালো Database System তৈরি করতে Relationships এবং Seed Data সম্পর্কে পরিষ্কার ধারণা থাকা অত্যন্ত গুরুত্বপূর্ণ।

---

# 🤔 What is a Relationship?

Relationship হলো এক Table-এর Data-এর সাথে অন্য Table-এর Data-এর সংযোগ (Connection)।

সাধারণত Relationship তৈরি করা হয়:

```text
PRIMARY KEY
      +
FOREIGN KEY
```

ব্যবহার করে।

---

# 🎯 কেন Relationship দরকার?

ধরো:

* একজন Student অনেক Course নিতে পারে।
* একটি Department-এর অনেক Student থাকতে পারে।
* একজন Customer অনেক Order করতে পারে।

এই ধরনের Real World Scenario Database-এ Model করার জন্য Relationship ব্যবহার করা হয়।

---

# 📊 Types of Relationships

DBMS-এ প্রধানত ৩ ধরনের Relationship রয়েছে:

1. One-to-One (1:1)
2. One-to-Many (1:N)
3. Many-to-Many (M:N)

---

# 1️⃣ One-to-One (1:1)

## 📖 Definition

একটি Record-এর সাথে অন্য Table-এর শুধুমাত্র একটি Record সম্পর্কিত থাকবে।

---

## 💡 Example

```text
Person ↔ Passport
```

একজন মানুষের একটি Passport থাকে।

একটি Passport শুধুমাত্র একজন মানুষের হয়।

---

## 🏗 Tables

### Persons

| person_id | name  |
| --------- | ----- |
| 1         | Rahim |

---

### Passports

| passport_id | person_id |
| ----------- | --------- |
| P101        | 1         |

---

## SQL Example

```sql
CREATE TABLE persons (
    person_id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE passports (
    passport_id VARCHAR(20) PRIMARY KEY,
    person_id INT UNIQUE,

    FOREIGN KEY (person_id)
    REFERENCES persons(person_id)
);
```

---

# 2️⃣ One-to-Many (1:N)

## 📖 Definition

একটি Record-এর সাথে অনেক Record সম্পর্কিত হতে পারে।

---

## 💡 Example

```text
Department → Students
```

একটি Department-এ অনেক Student থাকতে পারে।

কিন্তু একজন Student একটি Department-এর অন্তর্ভুক্ত।

---

## Visualization

```text
CSE
 ├── Rahim
 ├── Karim
 └── Jannat
```

---

## 🏗 Tables

### Departments

| department_id | department_name |
| ------------- | --------------- |
| 1             | CSE             |
| 2             | EEE             |

---

### Students

| student_id | name  | department_id |
| ---------- | ----- | ------------- |
| 101        | Rahim | 1             |
| 102        | Karim | 1             |
| 103        | Hasan | 2             |

---

## SQL Example

```sql
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),

    department_id INT,

    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);
```

---

# 3️⃣ Many-to-Many (M:N)

## 📖 Definition

একটি Record অনেক Record-এর সাথে সম্পর্কিত হতে পারে এবং বিপরীতটাও সত্য।

---

## 💡 Example

```text
Students ↔ Courses
```

একজন Student অনেক Course নিতে পারে।

একটি Course অনেক Student নিতে পারে।

---

# 🏗 Junction Table

Many-to-Many Relationship বাস্তবায়নের জন্য একটি অতিরিক্ত Table ব্যবহার করা হয়, যাকে **Junction Table** বলা হয়।

---

## Tables

### Students

| student_id | name  |
| ---------- | ----- |
| 1          | Rahim |

---

### Courses

| course_id | course_name |
| --------- | ----------- |
| 10        | DBMS        |

---

### Enrollments

| student_id | course_id |
| ---------- | --------- |
| 1          | 10        |

---

## SQL Example

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100)
);

CREATE TABLE enrollments (

    student_id INT,
    course_id INT,

    PRIMARY KEY (
        student_id,
        course_id
    ),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id)
);
```

---

# 🎨 Relationship Visualization

```text
Students
    │
    │ Many-to-Many
    ▼
Enrollments
    ▲
    │
Courses
```

---

# 📊 Relationship Summary

| Relationship | Example               |
| ------------ | --------------------- |
| One-to-One   | Person ↔ Passport     |
| One-to-Many  | Department → Students |
| Many-to-Many | Students ↔ Courses    |

---

# 🌱 What is Seed Data?

Seed Data হলো Database-এ Insert করা Initial বা Sample Data।

এটি সাধারণত ব্যবহৃত হয়:

* Development
* Testing
* Demo
* Local Environment Setup

---

# 🤔 Why Seed Data?

Seed Data ছাড়া Database খালি থাকে।

```text
Database
   ↓
Empty
```

তখন Application Test করা কঠিন হয়ে যায়।

---

# 🏗 Example Seed Data

## Insert Departments

```sql
INSERT INTO departments (
    department_name
)
VALUES
('CSE'),
('EEE'),
('BBA');
```

---

## Insert Students

```sql
INSERT INTO students (
    name,
    department_id
)
VALUES
('Rahim', 1),
('Karim', 1),
('Hasan', 2);
```

---

## Insert Courses

```sql
INSERT INTO courses (
    course_name
)
VALUES
('DBMS'),
('OOP'),
('Algorithms');
```

---

## Insert Enrollments

```sql
INSERT INTO enrollments
VALUES
(1, 1),
(1, 2),
(2, 1);
```

---

# 🌍 Real Project Structure

```text
database/
│
├── schema.sql
├── seed.sql
└── queries.sql
```

---

## schema.sql

Contains:

```text
CREATE TABLE
Constraints
Relationships
```

---

## seed.sql

Contains:

```text
INSERT INTO
Sample Data
```

---

# 🔄 Example Workflow

```text
Run schema.sql
        ↓
Tables Created
        ↓
Run seed.sql
        ↓
Sample Data Inserted
        ↓
Application Ready
```

---

# 🎤 Interview Answer

### What are Relationships in DBMS?

Relationships define how tables are connected using Primary Keys and Foreign Keys.

The three main relationship types are:

* One-to-One (1:1)
* One-to-Many (1:N)
* Many-to-Many (M:N)

---

### What is Seed Data?

Seed Data is initial sample data inserted into a database for development, testing, and demonstration purposes.

---

# 🧠 Easy Memory Trick

```text
1:1
=
One Person → One Passport

1:N
=
One Department → Many Students

M:N
=
Many Students ↔ Many Courses
```

---

# 🚀 Conclusion

```text
Tables
   ↓
Relationships
   ↓
Foreign Keys
   ↓
Connected Database
```

এবং,

```text
Schema
   ↓
Seed Data
   ↓
Ready Database
```

একজন Backend Developer, Database Engineer কিংবা Software Engineer-এর জন্য Relationships এবং Seed Data সম্পর্কে ভালো ধারণা থাকা অত্যন্ত গুরুত্বপূর্ণ।
