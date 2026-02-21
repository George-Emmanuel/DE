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
SELECT TOP 3 *
FROM customers
WHERE country = 'USA'
ORDER BY last_name ASC;
GROUP BY city
HAVING COUNT(*) > 5;

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

-- Example:
INSERT INTO employees (employee_id, first_name, last_name, email, hire_date)
VALUES (1, 'John', 'Doe', 'john12doe@gmail.com', '2020-01-15');

UPDATE employees
SET salary = 60000
WHERE employee_id = 1;

DELETE FROM employees
WHERE employee_id = 1;