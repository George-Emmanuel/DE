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

ALTER TABLE table_name
DROP COLUMN column_name;

ALTER TABLE table_name
ALTER COLUMN VARCHAR(10);

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

TRUNCATE TABLE persons;

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

-- CROSS JOIN
-- Returns the Cartesian product of the two tables.
SELECT * FROM customers
CROSS JOIN orders;

-- Example of Joining Multiple Tables
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

-- SET Operations
-- SET operations are used to combine the results of two or more SELECT statements.
-- Types of SET Operations:
-- 1. UNION: Combines the results of two SELECT statements and returns distinct values.
SELECT
	FirstName,
	LastName
FROM Sales.Customers
UNION
SELECT
	FirstName,
	LastName
FROM Sales.Employees;

-- 2. UNION ALL: Combines the results of two SELECT statements and returns all values, including duplicates.
SELECT
	FirstName,
	LastName
FROM Sales.Customers
UNION ALL
SELECT
	FirstName,
	LastName
FROM Sales.Employees;

-- 3. INTERSECT: Returns the common records from both SELECT statements.
SELECT
	FirstName,
	LastName
FROM Sales.Customers
INTERSECT
SELECT
	FirstName,
	LastName
FROM Sales.Employees;

-- 4. EXCEPT: Returns the records from the first SELECT statement that are not present in the second SELECT statement.
SELECT
	FirstName,
	LastName
FROM Sales.Customers
EXCEPT
SELECT
	FirstName,
	LastName
FROM Sales.Employees;

-- Functions in SQL
-- Single Row Functions: These functions operate on a single row and return a single value.
	-- String Functions
	-- Numeric Functions
	-- Date Functions
	-- NULL Functions
-- Multi Row Functions: These functions operate on multiple rows and return a single value.
	-- Aggregate Functions: These functions perform a calculation on a set of values and return a single value.
	-- Window Functions: These functions perform a calculation across a set of table rows that are somehow related to the current row.

-- String Functions
	-- Manipulate string data
		-- CONCAT: Concatenates two or more strings.
			SELECT CONCAT(FirstName, ' ', Country) AS Custom_Country_Info FROM Sales.Customers;
		-- UPPER: Converts a string to uppercase.
			SELECT UPPER(FirstName) AS Lower_FirstName FROM Sales.Customers;
		-- LOWER: Converts a string to lowercase.
			SELECT LOWER(FirstName) AS Lower_FirstName FROM Sales.Customers;
		-- TRIM: Removes leading and trailing spaces from a string.
			SELECT * FROM customers
			WHERE TRIM(first_name) != first_name;
		-- REPLACE: Replaces occurrences of a specified string with another string.
			SELECT REPLACE(first_name, ' ', '_') AS Trailing_Space_Check FROM customers
	-- Calculation
		-- LEN: Returns the length of a string.
			SELECT LEN(first_name) AS length FROM customers
	-- String Extraction
		-- SUBSTRING: Extracts a substring from a string based on specified starting position and length.
			SELECT SUBSTRING(TRIM(first_name), 2, LEN(first_name)) FROM customers;
		-- LEFT: Extracts a specified number of characters from the left side of a string.
			SELECT LEFT(first_name, 2) AS First_Two_Letters FROM customers
		-- RIGHT: Extracts a specified number of characters from the right side of a string.
			SELECT RIGHT(first_name, 2) AS Last_Two_Letters FROM customers

-- Number Functions
	-- ROUND: Rounds a number to a specified number of decimal places.
		SELECT ROUND(Sales, 2) AS Rounded_Sales FROM Sales.Orders;
	-- ABS: Returns the absolute value of a number.
		SELECT ABS(Sales) AS Absolute_Sales FROM Sales.Orders;
	-- CEILING: Rounds a number up to the nearest integer.
		SELECT CEILING(Sales) AS Ceiling_Sales FROM Sales.Orders;
	-- FLOOR: Rounds a number down to the nearest integer.
		SELECT FLOOR(Sales) AS Floor_Sales FROM Sales.Orders;
	-- POWER: Returns the value of a number raised to the power of another number.
		SELECT POWER(Sales, 2) AS Sales_Squared FROM Sales.Orders;
	-- SQRT: Returns the square root of a number.
		SELECT SQRT(Sales) AS Sales_Square_Root FROM Sales.Orders;
	-- LOG: Returns the natural logarithm of a number.
		SELECT LOG(Sales) AS Sales_Log FROM Sales.Orders;
	-- EXP: Returns the value of e raised to the power of a number.
		SELECT EXP(Sales) AS Sales_Exp FROM Sales.Orders;
	-- MOD: Returns the remainder of a division operation.
		SELECT MOD(Sales, 10) AS Sales_Mod_10 FROM Sales.Orders;
	-- RAND: Returns a random number between 0 and 1.
		SELECT RAND() AS Random_Number FROM Sales.Orders;
	-- SIGN: Returns the sign of a number.
		SELECT SIGN(Sales) AS Sales_Sign FROM Sales.Orders;
	
-- Date & Time Functions --> Deafualt Format: YYYY-MM-DD
	-- Part Extraction
		-- YEAR: Extracts the year from a date.
			SELECT YEAR(hire_date) AS Hire_Year FROM employees;
		-- MONTH: Extracts the month from a date.
			SELECT MONTH(hire_date) AS Hire_Month FROM employees;
		-- DAY: Extracts the day from a date.
			SELECT DAY(hire_date) AS Hire_Day FROM employees;
		-- DATEPART: Extracts a specified part of a date.
			SELECT DATEPART(quarter, hire_date) AS Hire_Quarter FROM employees;
			SELECT DATEPART(week, hire_date) AS Hire_Quarter FROM employees;
			SELECT DATEPART(month, hire_date) AS Hire_Quarter FROM employees;
		-- DATENAME: Returns the name of a specified part of a date.
			SELECT CreationTime, DATENAME(month, CreationTime) FROM Sales.Orders;
			SELECT CreationTime, DATENAME(weekday, CreationTime) FROM Sales.Orders;
		-- DATETRUNC: Resets Time part of a date to the specified part.
			SELECT CreationTime, DATETRUNC(month, CreationTime) AS Date_Trunc FROM Sales.Orders;
			-- USE CASE: Sets the time part to the first day of the month, which can be useful for grouping data by month.
				SELECT DATETRUNC(month, CreationTime), COUNT(*) AS ORDER_Count FROM Sales.Orders
				GROUP BY DATETRUNC(month, CreationTime);
		-- EOMONTH: Returns the last day of the month for a given date.
			SELECT CreationTime, EOMONTH(CreationTime) AS End_Of_Month FROM Sales.Orders;
		-- GETDATE: Returns the current date and time.
			SELECT *, GETDATE() AS Date FROM orders
	
	-- Formatting & Casting
		-- FORMAT: Formats a date according to a specified format.
			SELECT CreationTime, FORMAT(CreationTime, 'MM/dd/yyyy') AS Formatted_CreationTime FROM Sales.Orders;
		-- CAST: Converts a value from one data type to another.
			SELECT CreationTime, CAST(CreationTime AS DATE) AS Creation_Date FROM Sales.Orders;
		-- CONVERT: Converts a value from one data type to another with more control over the formatting.
			SELECT CreationTime, CONVERT(VARCHAR(10), CreationTime, 101) AS Formatted_CreationTime FROM Sales.Orders;
	
	-- Date Calculation
		-- DATEDIFF: Returns the difference between two dates in a specified unit.
			SELECT DATEDIFF(day, hire_date, GETDATE()) AS Days_Since_Hire FROM employees;
		-- DATEADD: Adds a specified number of units to a date.
			SELECT DATEADD(year, 1, hire_date) AS One_Year_After_Hire FROM employees;
	
	-- Date Validation
		-- ISDATE: Returns 1 if the expression is a valid date, otherwise returns 0.
			SELECT '2020-01-01' AS Date_String, ISDATE('2020-01-01') AS Is_Valid_Date;
			SELECT 'Invalid Date' AS Date_String, ISDATE('Invalid Date') AS Is_Valid_Date;

-- NULL Functions
	-- ISNULL: Replaces NULL with a specified replacement value.
	-- COALESCE: Returns the first non-NULL value from a list of expressions.
		SELECT AVG(Score) AS Average_Score FROM Sales.Customers;
		SELECT AVG(ISNULL(Score, 0)) AS Averag_Score_Null_Also FROM Sales.Customers;

		/* 
			Use Cases:
			1. Handling NUL Values before Mathematical calculations
			2. Handling NULL Values before String Manipulation
			3. Handling NULL Values before JOINS or AGGREGATIONS
			4. Handling NULL Values before Sorting
		*/

		SELECT
			CustomerID,
			FirstName,
			LastName,
			Score,
			ISNULL(Score, 0) + 10 AS Score_Plus_10,
			ISNULL(FirstName, '') + ISNULL(LastName, '') AS FullName
		FROM Sales.Customers;

		SELECT * FROM Sales.Customers
		ORDER BY ISNULL(Score, 999999999);

		SELECT * FROM Sales.Customers
		ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END;

	-- NULLIF: Returns NULL if the two expressions are equal, otherwise returns the first expression.
	-- IFNULL: Similar to ISNULL, but specific to certain database systems like MySQL

	-- DATA Policies
		-- 1. Only use NULL or Empty String and avoid using Blank Spaces.
		-- 2. Only use NULL and avoid using Empty String or Blank Spaces.
		-- 3. Only use 'unknown' or 'not specified' and avoid using NULL, Empty String, or Blank Spaces.

-- CASE Statements
	-- CASE statements are used to perform conditional logic in SQL. They allow you to return different values based on specified conditions.
	-- Syntax:
		CASE 
			WHEN condition1 THEN result1
			WHEN condition2 THEN result2
			...
			ELSE resultN
		END

	SELECT 
		FirstName,
		LastName,
		Country,
		CASE 
			WHEN Country = 'USA' THEN 'North America'
			WHEN Country = 'Canada' THEN 'North America'
			WHEN Country = 'UK' THEN 'Europe'
			ELSE 'Other'
		END AS Region
	FROM Sales.Customers;

	SELECT 
		*,
		CASE
			WHEN Gender = 'M' THEN 'Male'
			ELSE 'Female'
		END AS full_Gender
	FROM Sales.Employees;

	-- Quick Form:
	-- Here only one column is being evaluated, so we can use the quick form of CASE statement.
	SELECT 
		FirstName,
		LastName,
		Country,
		CASE Country
			WHEN 'USA' THEN 'North America'
			WHEN 'Canada' THEN 'North America'
			WHEN 'UK' THEN 'Europe'
			ELSE 'Other'
		END AS Region
	FROM Sales.Customers;

	SELECT 
		CustomerID, 
		LastName,
		Score,
		--AVG(ISNULL(Score,0)) OVER() AvgScore
		AVG(CASE
			WHEN Score IS NULL THEN 0
			ELSE Score
		END) OVER() AvgScore
	FROM Sales.Customers;

	SELECT 
		CustomerID,
		COUNT(
			CASE
				WHEN Sales > 30 THEN 1
				ELSE NULL
			END
		)
	FROM Sales.Orders
	GROUP BY CustomerID;

-- Aggregate Functions
	-- COUNT: Returns the number of rows that match a specified condition.
		SELECT COUNT(*) AS Total_Customers FROM Sales.Customers;
	-- SUM: Returns the total sum of a numeric column.
		SELECT SUM(Sales) AS Total_Sales FROM Sales.Orders;
	-- AVG: Returns the average value of a numeric column.
		SELECT AVG(Sales) AS Average_Sales FROM Sales.Orders;
	-- MIN: Returns the minimum value of a column.
		SELECT MIN(Sales) AS Minimum_Sales FROM Sales.Orders;
	-- MAX: Returns the maximum value of a column.
		SELECT MAX(Sales) AS Maximum_Sales FROM Sales.Orders;
	
	SELECT
		customer_id,
		COUNT(*) AS Total_Order_Count,
		SUM(sales) AS Total_sales,
		AVG(sales) AS Average_Sale,
		MAX(sales) AS Highest_Sale,
		MIN(sales) AS Lowest_Sale
	FROM Orders
	GROUP BY customer_id

-- Window Functions / Analytical Functions: 
	-- Definition: Window functions perform a calculation across a set of table rows that are somehow related to the current row. 
	-- They are used to calculate running totals, moving averages, and other cumulative statistics without collapsing the result 
	-- set like aggregate functions do.

	--Ex: 
	SELECT
		OrderID,
		OrderDate,
		ProductID,
		SUM(Sales) OVER(PARTITION BY ProductID) AS Total_Sales
	FROM Sales.Orders

-- Window Syntax: (2 Parts)
	-- 1st Part:
		-- Window Function
	-- 2nd Part:
		-- PARTITION Clause: Divides the result set into partitions to which the window function is applied. 
		-- ORDER Clause: Sorts the data within each partition before applying the window function.
		-- FRAME Clause: Defines the subset of rows within the partition to be used for the calculation.
		--				Rows, Range
		--				UNBOUNDED PRECEDING, n PRECEDING, CURRENT ROW
		--				CURRENT ROW, n FOLLOWING, UNBOUNDED FOLLOWING
	
	--EXAMPLE:
	AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS UNBOUNDED PRECEDING)

	-- Partition:
	SELECT
		OrderID,
		OrderDate,
		SUM(Sales) OVER() AS Total_Sales,
		ProductID,
		SUM(Sales) OVER(PARTITION BY ProductID) AS Sales_By_Product,
		OrderStatus,
		SUM(Sales) OVER(PARTITION BY ProductID, OrderStatus) AS Sales_By_Product_Status
	FROM Sales.Orders

	-- Order:
	SELECT
		OrderID,
		OrderDate,
		Sales,
		RANK() OVER(ORDER BY Sales DESC) AS RankSales
	FROM Sales.Orders

	-- RULES:
		-- 1. Window functions can be used in SELECT & ORDER BY clauses, but not in WHERE or GROUP BY clauses etc..
		-- 2. Nesting of Window functions is not allowed.
		-- 3. SQL execution order is FROM -> WHERE -> GROUP BY/Window Funcs -> HAVING -> SELECT -> ORDER BY.
		-- 4. Window functions can be used with GROUP BY in the same query, ONLY if same columns are used.
	
	SELECT 
		CustomerId,
		SUM(Sales) AS Total_sales,
		RANK() OVER(ORDER BY SUM(Sales) DESC) AS Customer_Ranks
	FROM Sales.Orders
	GROUP BY CustomerID

	-- Window Aggregate Functions:
	SELECT 
		OrderId,
		OrderDate,
		ProductId,
		Sales,
		SUM(Sales) OVER() AS Total_Sales,
		ROUND((CAST(Sales AS Float) / SUM(Sales) OVER()) * 100, 2) AS Sales_Percentage_By_Product
		--SUM(Sales) OVER(PARTITION BY ProductId) AS Total_Sales_By_Product
	FROM Sales.Orders

	SELECT * FROM
	(
	SELECT 
		OrderId,
		OrderDate,
		ProductId,
		Sales,
		AVG(Sales) OVER() AS Average_Sales
	FROM Sales.Orders
	)t
	WHERE Sales > Average_Sales;

	SELECT
		OrderId,
		OrderDate,
		ProductId,
		Sales,
		MAX(Sales) OVER() AS Highest_Sale,
		MIN(Sales) OVER() AS Lowest_Sale,
		MAX(Sales) OVER(PARTITION BY ProductId) AS Highest_Sale_By_Product,
		MIN(Sales) OVER(PARTITION BY ProductId) AS Lowest_Sale_By_Product
	FROM Sales.Orders

	SELECT * FROM
	(
	SELECT
		*,
		MAX(Salary) OVER() AS Highest_Salary
	FROM Sales.Employees
	)t
	WHERE Salary = Highest_Salary;

	SELECT 
		OrderId,
		OrderDate,
		Sales,
		SUM(Sales) OVER() AS Total_Sales,
		SUM(Sales) OVER(ORDER BY OrderId ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Total,
		SUM(Sales) OVER(ORDER BY OrderId ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Rolling_Total
	FROM Sales.Orders

	SELECT
		OrderId,
		OrderDate,
		ProductId,
		Sales,
		AVG(Sales) OVER(PARTITION BY ProductId ORDER BY OrderDate) AS Moving_Average,
		AVG(Sales) OVER(PARTITION BY ProductId ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS Rolling_Average
	FROM Sales.Orders

	-- Ranking Window Functions:
		-- 1. ROW_NUMBER: Assigns a unique sequential integer to rows within a partition of a result set, 
		--					starting at 1 for the first row in each partition.
		
		-- 2. RANK: Assigns a rank to each row within a partition of a result set, with gaps in the ranking when there are ties.
		
		-- 3. DENSE_RANK: Similar to RANK, but without gaps in the ranking when there are ties.
		
		-- 4. NTILE: Divides the rows in an ordered partition into a specified number of groups and assigns a group number to 
		--			each row.

		-- Example for ROW_NUMBER, RANK, DENSE_RANK:
			SELECT
				OrderId,
				OrderDate,
				ProductId,
				Sales,
				ROW_NUMBER() OVER(ORDER BY Sales DESC) AS row_numbered_column,
				RANK() OVER(ORDER BY Sales DESC) AS ranked_column,
				DENSE_RANK() OVER(ORDER BY Sales DESC) AS dense_ranked_column
			FROM Sales.Orders;

		SELECT * FROM
		(
		SELECT
			OrderId,
			OrderDate,
			ProductId,
			Sales,
			ROW_NUMBER() OVER(PARTITION BY ProductId ORDER BY Sales DESC) AS ranked_column
		FROM Sales.Orders)t
		WHERE ranked_column = 1;

		SELECT TOP 2
			CustomerId,
			SUM(Sales) AS Total_Sales,
			ROW_NUMBER() OVER(ORDER BY SUM(Sales) ASC) AS Customer_rank
		FROM Sales.Orders
		GROUP BY CustomerId

		SELECT
			OrderId,
			OrderDate,
			ProductId,
			Sales,
			NTILE(3) OVER(ORDER BY Sales ASC) AS Segmented_By_Sales,
			CASE
				WHEN NTILE(3) OVER(ORDER BY Sales ASC) = 1 THEN 'Low'
				WHEN NTILE(3) OVER(ORDER BY Sales ASC) = 2 THEN 'Medium'
				WHEN NTILE(3) OVER(ORDER BY Sales ASC) = 3 THEN 'High'
			END AS Sales_Pitch
		FROM Sales.Orders