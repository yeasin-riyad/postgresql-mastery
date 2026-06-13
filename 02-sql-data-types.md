# 📚 SQL Data Types (PostgreSQL) - Complete Bangla Guide

## 🎯 Introduction

SQL-এ **Data Type** নির্ধারণ করে একটি Column-এ কী ধরনের Data সংরক্ষণ করা যাবে।

সঠিক Data Type নির্বাচন করা গুরুত্বপূর্ণ কারণ এটি:

* Storage Efficient করে
* Query Performance উন্নত করে
* Data Integrity বজায় রাখে
* Database Design আরও Professional করে

---

# 🏗️ SQL Data Types Categories

```text
SQL Data Types
│
├── Numeric Types
├── Character/String Types
├── Boolean Type
├── Date & Time Types
├── UUID Type
└── JSON Type
```

---

# 1️⃣ Numeric Types (সংখ্যা)

Numeric Types সংখ্যা সংরক্ষণের জন্য ব্যবহার করা হয়।

---

## SMALLINT

ছোট Integer সংখ্যা সংরক্ষণের জন্য।

### Storage

```text
2 Bytes = 16 Bits
```

### Range

```text
-32,768 to 32,767
```

### Example

```sql
CREATE TABLE products (
    quantity SMALLINT
);
```

### Use Cases

* Product Quantity
* Small Counters
* Status Codes

---

## INTEGER / INT

সবচেয়ে বেশি ব্যবহৃত Integer Type।

### Storage

```text
4 Bytes = 32 Bits
```

### Range

```text
-2,147,483,648
to
2,147,483,647
```

### Example

```sql
CREATE TABLE students (
    student_id INT
);
```

### Use Cases

* Student ID
* Employee ID
* Order Number

---

## BIGINT

বড় Integer সংখ্যা সংরক্ষণের জন্য।

### Storage

```text
8 Bytes = 64 Bits
```

### Range

```text
-9,223,372,036,854,775,808
to
9,223,372,036,854,775,807
```

### Example

```sql
CREATE TABLE analytics (
    total_views BIGINT
);
```

### Use Cases

* YouTube Views
* Social Media Followers
* Financial Records

---

## NUMERIC / DECIMAL

Exact Decimal Value সংরক্ষণ করার জন্য।

### Example

```sql
salary NUMERIC(10,2)
```

Meaning:

```text
Total Digits = 10
Decimal Places = 2
```

Valid Values:

```text
12345.67
99999999.99
```

### Use Cases

* Salary
* Product Price
* Banking Systems

---

## REAL

Single Precision Floating Point Number।

### Storage

```text
4 Bytes
```

### Example

```sql
temperature REAL
```

---

## DOUBLE PRECISION

Double Precision Floating Point Number।

### Storage

```text
8 Bytes
```

### Example

```sql
price DOUBLE PRECISION
```

---

# 2️⃣ Character/String Types

Text Data সংরক্ষণের জন্য ব্যবহার করা হয়।

---

## CHAR(n)

Fixed Length String।

### Example

```sql
gender CHAR(1)
```

Possible Values:

```text
M
F
```

### Example

```sql
name CHAR(10)
```

Stored Value:

```text
Rahim_____
```

(Extra spaces automatically added)

### Use Cases

* Gender
* Country Code
* Fixed-Length Values

---

## VARCHAR(n)

Variable Length String।

### Example

```sql
name VARCHAR(100)
```

Stored Value:

```text
Rahim
```

No extra spaces used.

### Use Cases

* Name
* Email
* Address

---

## TEXT

Unlimited Length Text।

### Example

```sql
description TEXT
```

### Use Cases

* Blog Content
* Product Description
* User Comments

---

# 3️⃣ BOOLEAN Type

TRUE/FALSE Value সংরক্ষণ করার জন্য।

### Example

```sql
CREATE TABLE users (
    is_active BOOLEAN
);
```

### Valid Values

```text
TRUE
FALSE
```

### Insert Example

```sql
INSERT INTO users(is_active)
VALUES(TRUE);
```

### Use Cases

* User Status
* Payment Status
* Account Verification

---

# 4️⃣ Date & Time Types

Date এবং Time সংরক্ষণের জন্য ব্যবহার করা হয়।

---

## DATE

শুধু Date সংরক্ষণ করে।

### Example

```sql
birth_date DATE
```

Value:

```text
2026-06-13
```

---

## TIME

শুধু Time সংরক্ষণ করে।

### Example

```sql
meeting_time TIME
```

Value:

```text
10:30:00
```

---

## TIMESTAMP

Date এবং Time একসাথে সংরক্ষণ করে।

### Example

```sql
created_at TIMESTAMP
```

Value:

```text
2026-06-13 10:30:00
```

---

## TIMESTAMPTZ

Timestamp with Time Zone।

### Example

```sql
created_at TIMESTAMPTZ
```

Value:

```text
2026-06-13 10:30:00+06
```

### Use Cases

* Global Applications
* International Systems

---

# 5️⃣ UUID Type

UUID = Universally Unique Identifier

একটি Globally Unique Identifier।

### Example UUID

```text
550e8400-e29b-41d4-a716-446655440000
```

---

## Create Table

```sql
CREATE TABLE users (
    id UUID PRIMARY KEY
);
```

---

## Generate UUID (PostgreSQL)

```sql
SELECT gen_random_uuid();
```

Example Output:

```text
7f58a3ef-fc1b-4c3d-b2df-8d81e9a4a4d1
```

---

## UUID vs INT

| INT                    | UUID                         |
| ---------------------- | ---------------------------- |
| Small Size             | Larger Size                  |
| Faster Index           | Slightly Slower              |
| Predictable            | Unpredictable                |
| Good for Small Systems | Good for Distributed Systems |

---

# 6️⃣ JSON / JSONB

Modern PostgreSQL Feature।

Flexible Data Store করার জন্য ব্যবহার করা হয়।

### Create Table

```sql
CREATE TABLE users (
    profile JSONB
);
```

---

### Insert Data

```sql
INSERT INTO users(profile)
VALUES(
'{
  "name":"Rahim",
  "age":25,
  "skills":["PostgreSQL","Node.js"]
}'
);
```

---

### Use Cases

* User Preferences
* Dynamic Forms
* API Responses

---

# 🌍 Real World Example

```sql
CREATE TABLE users (

    id UUID PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    email VARCHAR(255) UNIQUE,

    age INT,

    salary NUMERIC(10,2),

    is_active BOOLEAN DEFAULT TRUE,

    birth_date DATE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

# 📊 Data Type Selection Guide

| Data          | Recommended Type    |
| ------------- | ------------------- |
| ID            | INT / BIGINT / UUID |
| Name          | VARCHAR(100)        |
| Email         | VARCHAR(255)        |
| Description   | TEXT                |
| Age           | INT                 |
| Salary        | NUMERIC(10,2)       |
| Active Status | BOOLEAN             |
| Birth Date    | DATE                |
| Created Time  | TIMESTAMP           |
| Flexible Data | JSONB               |

---

# 🎤 Interview Answer

### What are SQL Data Types?

SQL Data Types define what kind of data can be stored in a column.

Common categories include:

* Numeric Types (INT, BIGINT, NUMERIC)
* Character Types (CHAR, VARCHAR, TEXT)
* Boolean Type (BOOLEAN)
* Date & Time Types (DATE, TIME, TIMESTAMP)
* UUID Type
* JSON / JSONB Type

Choosing the correct data type improves storage efficiency, query performance, and data integrity.

---

# 🧠 Easy Memory Trick

```text
INT       → Numbers
VARCHAR   → Text
BOOLEAN   → True/False
DATE      → Date
TIMESTAMP → Date + Time
UUID      → Unique ID
JSONB     → Flexible Data
```

---

# 🚀 Conclusion

Data Types হলো Database Design-এর Foundation।

সঠিক Data Type নির্বাচন করলে:

✅ Storage Efficient হয়

✅ Query Faster হয়

✅ Data Integrity বজায় থাকে

✅ Application আরও Scalable হয়

একজন Backend Developer বা Database Engineer-এর জন্য SQL Data Types ভালোভাবে জানা অত্যন্ত গুরুত্বপূর্ণ।
