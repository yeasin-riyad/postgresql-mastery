# 📚 PostgreSQL RETURNING Clause

## 🎯 Introduction

PostgreSQL-এর একটি খুবই Powerful Feature হলো **`RETURNING` Clause**।

সাধারণত যখন আমরা:

* `INSERT`
* `UPDATE`
* `DELETE`

Query চালাই, তখন PostgreSQL শুধুমাত্র বলে:

```text
INSERT 0 1
```

অথবা

```text
UPDATE 1
```

কিন্তু অনেক সময় আমাদের জানতে হয়:

* কোন Row Insert হয়েছে?
* কোন Row Update হয়েছে?
* কোন Row Delete হয়েছে?
* Auto Generated ID কত?

এই সমস্যার সমাধান করে `RETURNING` Clause।

---

# 📖 What is RETURNING?

`RETURNING` Query Execute হওয়ার পরে Modified Row গুলো Return করে।

```sql
INSERT ... RETURNING ...
```

```sql
UPDATE ... RETURNING ...
```

```sql
DELETE ... RETURNING ...
```

---

# 🏗 Sample Table

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    gpa DECIMAL(3,2)
);
```

---

# 1️⃣ RETURNING with INSERT

## Without RETURNING

```sql
INSERT INTO students(name, email, gpa)
VALUES(
    'Rahim',
    'rahim@gmail.com',
    3.80
);
```

Output:

```text
INSERT 0 1
```

আমরা জানি না:

```text
Generated Student ID কত?
```

---

## With RETURNING *

```sql
INSERT INTO students(name, email, gpa)
VALUES(
    'Rahim',
    'rahim@gmail.com',
    3.80
)
RETURNING *;
```

### Output

| student_id | name  | email                                     | gpa  |
| ---------- | ----- | ----------------------------------------- | ---- |
| 1          | Rahim | [rahim@gmail.com](mailto:rahim@gmail.com) | 3.80 |

---

## Why Useful?

কারণ PostgreSQL Auto Generated ID Return করে।

Backend API Development-এ এটি খুবই Common।

---

# Return Specific Columns

```sql
INSERT INTO students(name, email, gpa)
VALUES(
    'Karim',
    'karim@gmail.com',
    3.50
)
RETURNING student_id;
```

### Output

| student_id |
| ---------- |
| 2          |

---

# Return Multiple Columns

```sql
INSERT INTO students(name, email, gpa)
VALUES(
    'Jannat',
    'jannat@gmail.com',
    3.90
)
RETURNING student_id, name;
```

### Output

| student_id | name   |
| ---------- | ------ |
| 3          | Jannat |

---

# 2️⃣ RETURNING with UPDATE

## Without RETURNING

```sql
UPDATE students
SET gpa = 4.00
WHERE student_id = 1;
```

Output:

```text
UPDATE 1
```

---

## With RETURNING

```sql
UPDATE students
SET gpa = 4.00
WHERE student_id = 1
RETURNING *;
```

### Output

| student_id | name  | gpa  |
| ---------- | ----- | ---- |
| 1          | Rahim | 4.00 |

---

## Real World Example

```sql
UPDATE students
SET gpa = 3.95
WHERE student_id = 3
RETURNING *;
```

Frontend-এ Updated Data পাঠানোর জন্য আলাদা `SELECT` Query লাগবে না।

---

# 3️⃣ RETURNING with DELETE

## Without RETURNING

```sql
DELETE FROM students
WHERE student_id = 2;
```

Output:

```text
DELETE 1
```

---

## With RETURNING

```sql
DELETE FROM students
WHERE student_id = 2
RETURNING *;
```

### Output

| student_id | name  |
| ---------- | ----- |
| 2          | Karim |

---

## Why Useful?

Delete হওয়া Data:

* Audit Log-এ Save করা যায়
* Backup রাখা যায়
* Response হিসেবে পাঠানো যায়

---

# 4️⃣ RETURNING Expressions

শুধু Column নয়, Expression-ও Return করা যায়।

```sql
INSERT INTO students(name, gpa)
VALUES(
    'Sakib',
    3.70
)
RETURNING
name,
gpa,
gpa * 25 AS percentage;
```

### Output

| name  | gpa  | percentage |
| ----- | ---- | ---------- |
| Sakib | 3.70 | 92.5       |

---

# 5️⃣ RETURNING with Aliases

```sql
UPDATE students
SET gpa = 4.00
WHERE student_id = 1
RETURNING
student_id AS id,
name AS student_name;
```

---

# 6️⃣ Node.js Backend Example

```javascript
const result = await pool.query(
`
INSERT INTO students(name,email)
VALUES($1,$2)
RETURNING *
`,
["Rahim", "rahim@gmail.com"]
);

console.log(result.rows[0]);
```

Output:

```javascript
{
  student_id: 1,
  name: "Rahim",
  email: "rahim@gmail.com"
}
```

---

# 🚀 Why Backend Developers Love RETURNING?

Without RETURNING:

```text
INSERT
   ↓
SELECT
```

দুইটি Query লাগে।

---

With RETURNING:

```text
INSERT + RETURNING
```

একটি Query-তেই কাজ শেষ।

---

# ⚡ Performance Benefit

Without RETURNING:

```sql
INSERT INTO students(...);

SELECT *
FROM students
WHERE student_id = 10;
```

❌ ২টি Database Round Trip

---

With RETURNING:

```sql
INSERT INTO students(...)
RETURNING *;
```

✅ ১টি Database Round Trip

Benefits:

* Faster Performance
* Less Code
* Cleaner API

---

# 📊 Summary Table

| Operation  | RETURNING Purpose   |
| ---------- | ------------------- |
| INSERT     | Newly inserted row  |
| UPDATE     | Updated row         |
| DELETE     | Deleted row         |
| Expression | Calculated values   |
| Alias      | Custom column names |

---

# 🎤 Interview Answer

### What is the RETURNING clause in PostgreSQL?

The `RETURNING` clause is used with `INSERT`, `UPDATE`, and `DELETE` statements to return the affected rows immediately after query execution.

Example:

```sql
INSERT INTO students(name)
VALUES('Rahim')
RETURNING *;
```

This eliminates the need for an additional `SELECT` query and improves performance.

---

# 🧠 Easy Memory Trick

```text
INSERT
    ↓
RETURN NEW ROW

UPDATE
    ↓
RETURN UPDATED ROW

DELETE
    ↓
RETURN DELETED ROW
```

---

# 🚀 Conclusion

`RETURNING` PostgreSQL-এর অন্যতম শক্তিশালী Feature, বিশেষ করে Backend Development এবং REST API তৈরির ক্ষেত্রে।

```text
INSERT + RETURNING
UPDATE + RETURNING
DELETE + RETURNING
```

এটি ব্যবহার করলে:

✅ কম Query লাগে

✅ Better Performance পাওয়া যায়

✅ Cleaner Code লেখা যায়

✅ Modified Data সাথে সাথেই পাওয়া যায়

তাই PostgreSQL Interview-এর জন্য `RETURNING` Clause খুবই গুরুত্বপূর্ণ একটি Topic।
