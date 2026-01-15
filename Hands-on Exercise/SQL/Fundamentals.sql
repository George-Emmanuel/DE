-- DATABASE / SCHEMA.
CREATE DATABASE demo_db;
DROP DATABASE IF EXISTS demo_db;

-- DDL: create table with constraints.
CREATE TABLE customers (
    id INT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(100),
    country VARCHAR(50) DEFAULT 'Unknown',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (CHAR_LENGTH(name) > 0)
);

-- ALTER TABLE.
ALTER TABLE customers ADD COLUMN phone VARCHAR(20);
ALTER TABLE customers DROP COLUMN phone;
ALTER TABLE customers ADD CONSTRAINT fk_example FOREIGN KEY (id) REFERENCES orders(customer_id);

-- DML: INSERT / UPDATE / DELETE.
INSERT INTO customers (id, email, name) VALUES (1, 'a@example.com', 'Alice');
INSERT INTO customers (id, email, name) VALUES (2, 'b@example.com', 'Bob'), (3, 'c@example.com', 'Carol');

INSERT INTO orders (customer_id, amount, created_at)
SELECT id, 100.00, NOW() FROM customers WHERE country = 'USA';

UPDATE customers SET name = 'Robert' WHERE id = 2;
DELETE FROM customers WHERE id = 3;

-- SELECT basics
SELECT * FROM customers;
SELECT id, name, email FROM customers;

-- FILTERS
SELECT * FROM customers WHERE country = 'USA' AND created_at >= '2025-01-01';
SELECT * FROM customers WHERE email LIKE '%@example.com';
SELECT * FROM customers WHERE id IN (1,2,3);
SELECT * FROM customers WHERE name IS NULL OR name IS NOT NULL;
SELECT * FROM products WHERE price BETWEEN 10 AND 100;

-- DISTINCT / ORDER / LIMIT / OFFSET
SELECT DISTINCT country FROM customers;
SELECT * FROM orders ORDER BY created_at DESC, amount ASC;
SELECT * FROM orders LIMIT 10 OFFSET 20;  -- or: OFFSET 20 FETCH NEXT 10 ROWS ONLY

-- AGGREGATES & GROUP BY
SELECT COUNT(*) AS cnt, AVG(amount) AS avg_amount FROM orders;
SELECT customer_id, SUM(amount) AS total
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > 1000;

-- JOINS
SELECT o.id, c.name, o.amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id;

SELECT c.name, o.amount
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id;

-- CROSS JOIN / SELF JOIN
SELECT a.id, b.id FROM customers a CROSS JOIN customers b;
SELECT e.id, m.name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;

-- SUBQUERIES
SELECT * FROM customers WHERE id IN (SELECT customer_id FROM orders WHERE amount > 500);
SELECT c.name,
       (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.id) AS order_count
FROM customers c;

-- EXISTS
SELECT * FROM customers c WHERE EXISTS (SELECT 1 FROM orders o WHERE o.customer_id = c.id AND o.amount > 100);

-- COMMON TABLE EXPRESSIONS (CTE)
WITH recent_orders AS (
    SELECT * FROM orders WHERE created_at >= CURRENT_DATE - INTERVAL '30' DAY
)
SELECT customer_id, SUM(amount) total30
FROM recent_orders
GROUP BY customer_id;

-- RECURSIVE CTE (hierarchy)
WITH RECURSIVE org AS (
    SELECT id, manager_id, name FROM employees WHERE id = 1
    UNION ALL
    SELECT e.id, e.manager_id, e.name FROM employees e JOIN org ON e.manager_id = org.id
)
SELECT * FROM org;

-- WINDOW FUNCTIONS
SELECT id, customer_id, amount,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY amount DESC) AS rn,
       SUM(amount) OVER (PARTITION BY customer_id) AS total_by_customer
FROM orders;

-- SET OPERATIONS
SELECT customer_id FROM orders_2024
UNION
SELECT customer_id FROM orders_2025;

SELECT customer_id FROM orders_2024
UNION ALL
SELECT customer_id FROM orders_2025;

-- MERGE (UPSERT) - vendor-specific syntax (example for SQL Server / Oracle)
MERGE INTO customers AS target
USING (SELECT 1 AS id, 'a@example.com' AS email, 'Alice' AS name) AS src
ON target.id = src.id
WHEN MATCHED THEN UPDATE SET email = src.email, name = src.name
WHEN NOT MATCHED THEN INSERT (id, email, name) VALUES (src.id, src.email, src.name);

-- INSERT ... ON CONFLICT / ON DUPLICATE KEY UPDATE (Postgres / MySQL)
INSERT INTO customers (id, email, name) VALUES (1, 'a2@example.com', 'Alice2')
ON CONFLICT (id) DO UPDATE SET email = EXCLUDED.email, name = EXCLUDED.name;

-- TRANSACTIONS
BEGIN TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
-- IF OK:
COMMIT;
-- ELSE:
ROLLBACK;

-- SAVEPOINT
BEGIN;
UPDATE ...;
SAVEPOINT sp1;
-- possible rollback to sp1
ROLLBACK TO SAVEPOINT sp1;
COMMIT;

-- INDEXES
CREATE INDEX idx_orders_customer ON orders (customer_id);
DROP INDEX idx_orders_customer ON orders; -- vendor differs: DROP INDEX idx ON table;

-- VIEWS
CREATE VIEW v_customer_totals AS
SELECT c.id, c.name, COALESCE(SUM(o.amount),0) AS total
FROM customers c LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name;

-- TEMP TABLE
CREATE TEMPORARY TABLE temp_top_customers AS
SELECT customer_id, SUM(amount) AS total FROM orders GROUP BY customer_id ORDER BY total DESC LIMIT 10;

-- DESCRIBE / EXPLAIN
-- DESCRIBE customers;    -- MySQL
-- \d customers           -- psql
EXPLAIN SELECT * FROM orders WHERE customer_id = 1;

-- DATA TYPES / CAST / CONVERT
SELECT CAST(amount AS DECIMAL(10,2)), CAST(created_at AS DATE) FROM orders;

-- NULL HANDLING / FUNCTIONS
SELECT COALESCE(nickname, name, 'Unknown') FROM customers;
SELECT NULLIF(col1, col2) FROM table;

-- STRING / DATE FUNCTIONS (examples)
SELECT UPPER(name), TRIM(email) FROM customers;
SELECT DATE_TRUNC('month', created_at) FROM orders;

-- CONDITIONALS
SELECT id,
       CASE WHEN amount > 1000 THEN 'big' WHEN amount > 100 THEN 'medium' ELSE 'small' END AS size
FROM orders;

-- PIVOT (generic example using aggregates and CASE)
SELECT customer_id,
       SUM(CASE WHEN EXTRACT(MONTH FROM created_at) = 1 THEN amount ELSE 0 END) AS jan_total,
       SUM(CASE WHEN EXTRACT(MONTH FROM created_at) = 2 THEN amount ELSE 0 END) AS feb_total
FROM orders
GROUP BY customer_id;

-- FULL-TEXT / SEARCH (vendor specific)
SELECT * FROM documents WHERE content LIKE '%term%';

-- CLEANUP
TRUNCATE TABLE orders;
DROP TABLE IF EXISTS temp_top_customers;
DROP VIEW IF EXISTS v_customer_totals;

-- COMMON PRACTICES / TIPS
-- Use parameterized queries in apps to avoid SQL injection.
-- Add appropriate indexes for columns used in JOINs and WHERE predicates.
-- Prefer explicit column lists in INSERT/SELECT for stable schemas.

-- End of fundamentals.
