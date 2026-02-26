-- What is SQL?
-- SQL stands for Structured Query Language. It is a programming language used to manage and manipulate relational databases. 
-- SQL allows users to create, read, update, and delete data in a database, as well as perform various operations such as filtering, sorting, and aggregating data. 
-- It is widely used in various applications, including web development, data analysis, and business intelligence.

-- Why learn SQL?
-- Learning SQL is essential for anyone working with data, as it is the standard language for interacting with relational databases. It enables you to efficiently retrieve and manipulate data, which is crucial for making informed decisions based on data analysis.
-- SQL is also a valuable skill in the job market, as many roles in data science, data analysis, and software development require proficiency in SQL.
-- Additionally, SQL is relatively easy to learn compared to other programming languages, making it accessible for beginners.

-- What is Database & Types of Database?
-- A database is an organized collection of data that is stored and accessed electronically. It allows users to efficiently manage and retrieve data. There are several types of databases, including:
-- 1. Relational Databases: These databases store data in tables with rows and columns. Examples include MySQL, PostgreSQL, and Oracle.
-- 2. NoSQL Databases: These databases are designed for unstructured data and do not use the traditional table-based structure. Examples include MongoDB and Cassandra.
-- 3. In-Memory Databases: These databases store data in memory for faster access. Examples include Redis and Memcached.
-- 4. Graph Databases: These databases are designed to store and query data in the form of graphs. Examples include Neo4j and Amazon Neptune.
-- 5. Object-Oriented Databases: These databases store data in the form of objects, similar to object-oriented programming. Examples include ObjectDB and db4o.

-- DQL - Data Query Language
-- DQL is a subset of SQL that focuses on querying data from a database. It includes
-- QUERY DATA
-- The SELECT statement is used to retrieve data from a database. It allows you to specify which columns you want to retrieve and from which table.
-- Syntax:
SELECT column1, column2
FROM table_name;
WHERE condition;
ORDER BY column_name ASC|DESC;
GROUP BY column_name;
HAVING condition;

-- Example:
SELECT 
	country,
	SUM(score)
FROM customers
GROUP BY country
HAVING SUM(score) > 800
ORDER BY SUM(score) DESC;

-- DDL - Data Definition Language
-- DDL is a subset of SQL that focuses on defining and managing the structure of a database. 
-- It includes statements for creating, altering, and dropping database objects such as tables, indexes, and views.
-- Syntax:
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    ...
);

ALTER TABLE table_name
ADD column_name datatype;

DROP TABLE table_name;
DROP COLUMN column_name;

-- Example:
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    hire_date DATE
);

ALTER TABLE employees
ADD salary DECIMAL(10, 2);

DROP TABLE employees;
DROP COLUMN salary;

-- DML - Data Manipulation Language
-- DML is a subset of SQL that focuses on manipulating data within a database.
-- It includes statements for inserting, updating, and deleting data.
-- Syntax:
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);

UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;

DELETE FROM table_name
WHERE condition;

-- Example to insert Static Data:
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date)
VALUES (1, 'John', 'Doe', 'john12doe@gmail.com', '2020-01-15');

-- Example to insert Data from another table:
INSERT INTO persons
SELECT id, first_name, NULL, 'Unknown' FROM customers;

UPDATE employees
SET salary = 60000
WHERE employee_id = 1;

DELETE FROM employees
WHERE employee_id = 1;

TRUNCATE TABLE persons;

-- Filtering Data
-- The WHERE clause is used to filter records based on specified conditions. 
-- It allows you to retrieve only the data that meets certain criteria.
-- > , <, >=, <=, != are as usual
-- BETWEEN -> "WHERE salary BETWEEN 50000 AND 70000"
-- IN -> "WHERE country IN ('USA', 'Canada', 'UK')"
-- LIKE -> "WHERE first_name LIKE 'J%'" (starts with J)
--         "WHERE first_name LIKE '%n'" (ends with n)
--         "WHERE first_name LIKE '%oh%'" (contains oh)
-- IS NULL -> "WHERE email IS NULL"

-- 6. Joining Data
-- Joins are used to combine rows from two or more tables based on a related column between them.
-- Types of Joins:
-- 1. INNER JOIN: Returns records that have matching values in both tables.
-- 2. LEFT JOIN: Returns all records from the left table and the matched records from the right table. 
--               If there is no match, the result is NULL on the right side.
-- 3. RIGHT JOIN: Returns all records from the right table and the matched records from the left table.
--                If there is no match, the result is NULL on the left side.
-- 4. FULL JOIN: Returns all records when there is a match.
-- 5. CROSS JOIN: Returns the Cartesian product of the two tables, i.e., it returns all possible combinations of rows from both tables.
-- 6. SELF JOIN: A self join is a regular join but the table is joined with itself.

-- No JOIN
-- Returns data without combining the two tables.
SELECT * FROM customers;
SELECT * FROM orders;

-- INNER JOIN
-- Returns only matching rows from both tables
SELECT * FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id;

-- LEFT JOIN
-- Returns all rows from the left table and matching rows from the right table.
SELECT * FROM customers AS c
LEFT JOIN orders as o
ON c.id = o.customer_id;

-- RIGHT JOIN
-- Returns all rows from the right table and matching rows from the left table.
SELECT * FROM customers AS c
RIGHT JOIN orders as o
ON c.id = o.customer_id;

-- FULL JOIN
-- Returns all rows when there is a match in either left or right table.
SELECT * FROM customers
FULL JOIN orders 
ON customers.id = orders.customer_id;

-- LEFT OUTER JOIN
-- Returns all rows from the left table and matching rows from the right table.
SELECT * FROM customers AS c
LEFT JOIN orders as o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL;

-- RIGHT OUTER JOIN
-- Returns all rows from the right table and matching rows from the left table.
SELECT * FROM customers AS c
RIGHT JOIN orders as o
ON c.id = o.customer_id
WHERE c.id IS NULL;

-- FULL OUTER JOIN
-- Returns all rows when there is a match in either left or right table.
SELECT * FROM customers AS c
FULL JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL;

-- CROSS JOIN
-- Returns the Cartesian product of the two tables.
SELECT * FROM customers
CROSS JOIN orders;

SELECT 
	o.OrderID AS 'Order No.',
	c.FirstName AS 'Customer Name',
	p.Product AS 'Product',
	o.Sales AS 'Number of Products',
	p.Price AS 'Price',
	e.FirstName AS 'Sales Person Name'
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c ON c.CustomerID = o.CustomerID
LEFT JOIN Sales.Products AS p ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees AS e ON o.SalesPersonID = e.EmployeeID;