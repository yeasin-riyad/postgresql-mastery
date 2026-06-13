
/*
====================================================
 1️⃣ NUMERIC DATA TYPES
====================================================
*/

/* SMALLINT - Small Range Integer (2 bytes) */
CREATE TABLE smallint_example (
    id SMALLINT,
    quantity SMALLINT
);

-- Insert sample data
INSERT INTO smallint_example (id, quantity)
VALUES (1, 100), (2, 200);


/* INTEGER / INT - Standard Integer (4 bytes) */
CREATE TABLE integer_example (
    id INT,
    age INT
);

INSERT INTO integer_example (id, age)
VALUES (1, 25), (2, 30);


/* BIGINT - Large Numbers (8 bytes) */
CREATE TABLE bigint_example (
    id BIGINT,
    total_views BIGINT
);

INSERT INTO bigint_example (id, total_views)
VALUES (1, 1000000000), (2, 9999999999);


/* NUMERIC / DECIMAL - Exact precision values */
CREATE TABLE numeric_example (
    id SERIAL PRIMARY KEY,
    salary NUMERIC(10,2)
);

INSERT INTO numeric_example (salary)
VALUES (55000.50), (120000.75);


/* REAL - Floating point (less precision) */
CREATE TABLE real_example (
    id SERIAL PRIMARY KEY,
    temperature REAL
);

INSERT INTO real_example (temperature)
VALUES (36.6), (98.4);


/* DOUBLE PRECISION - High precision float */
CREATE TABLE double_example (
    id SERIAL PRIMARY KEY,
    price DOUBLE PRECISION
);

INSERT INTO double_example (price)
VALUES (99.999999), (12345.6789);


/*
====================================================
 2️⃣ CHARACTER / STRING DATA TYPES
====================================================
*/

/* CHAR - Fixed length string */
CREATE TABLE char_example (
    id SERIAL PRIMARY KEY,
    gender CHAR(1)
);

INSERT INTO char_example (gender)
VALUES ('M'), ('F');


/* VARCHAR - Variable length string */
CREATE TABLE varchar_example (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(255)
);

INSERT INTO varchar_example (name, email)
VALUES ('Rahim', 'rahim@gmail.com');


/* TEXT - Unlimited length string */
CREATE TABLE text_example (
    id SERIAL PRIMARY KEY,
    description TEXT
);

INSERT INTO text_example (description)
VALUES ('This is a long text stored in PostgreSQL TEXT type');


/*
====================================================
 3️⃣ BOOLEAN TYPE
====================================================
*/

CREATE TABLE boolean_example (
    id SERIAL PRIMARY KEY,
    is_active BOOLEAN
);

INSERT INTO boolean_example (is_active)
VALUES (TRUE), (FALSE);


/*
====================================================
 4️⃣ DATE & TIME TYPES
====================================================
*/

/* DATE - Only date */
CREATE TABLE date_example (
    id SERIAL PRIMARY KEY,
    birth_date DATE
);

INSERT INTO date_example (birth_date)
VALUES ('2000-01-01'), ('1995-05-15');


/* TIME - Only time */
CREATE TABLE time_example (
    id SERIAL PRIMARY KEY,
    meeting_time TIME
);

INSERT INTO time_example (meeting_time)
VALUES ('10:30:00'), ('14:45:00');


/* TIMESTAMP - Date + Time */
CREATE TABLE timestamp_example (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO timestamp_example (created_at)
VALUES (NOW()), (NOW());


/* TIMESTAMPTZ - Time zone aware timestamp */
CREATE TABLE timestamptz_example (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO timestamptz_example (created_at)
VALUES (NOW()), (NOW());


/*
====================================================
 5️⃣ UUID TYPE
====================================================
*/

-- Enable extension for UUID generation (important in PostgreSQL)
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

CREATE TABLE uuid_example (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100)
);

INSERT INTO uuid_example (name)
VALUES ('Rahim'), ('Karim');


/*
====================================================
 6️⃣ JSON / JSONB TYPE
====================================================
*/

CREATE TABLE json_example (
    id SERIAL PRIMARY KEY,
    profile JSONB
);

INSERT INTO json_example (profile)
VALUES (
    '{
        "name": "Rahim",
        "age": 25,
        "skills": ["SQL", "Node.js", "React"]
    }'
);


/*
====================================================
 7️⃣ REAL-WORLD COMBINED EXAMPLE
====================================================
*/

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    age INT,
    salary NUMERIC(10,2),
    is_active BOOLEAN DEFAULT TRUE,
    birth_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (name, email, age, salary, is_active, birth_date)
VALUES
('Rahim', 'rahim@gmail.com', 25, 55000.50, TRUE, '2000-01-01'),
('Karim', 'karim@gmail.com', 30, 75000.00, TRUE, '1995-05-15');


/*
====================================================
 END OF FILE
====================================================
*/