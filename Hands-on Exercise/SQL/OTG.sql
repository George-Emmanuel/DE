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

-- QUERY DATA
-- The SELECT statement is used to retrieve data from a database. It allows you to specify which columns you want to retrieve and from which table.
-- Example:
SELECT TOP 3 column1, column2
FROM table_name;
WHERE condition;
ORDER BY column_name ASC|DESC;
GROUP BY column_name;
HAVING condition;

-- 