-- What is SQL?
-- 	SQL stands for Structured Query Language. It is a programming language used to manage and manipulate relational databases. 
-- 	SQL allows users to create, read, update, and delete data in a database, as well as 
--		perform various operations such as filtering, sorting, and aggregating data. 
-- 	It is widely used in various applications, including web development, data analysis, and business intelligence.

-- Why learn SQL?
-- 	Learning SQL is essential for anyone working with data, as it is the standard language for interacting with relational databases. It enables you to efficiently retrieve and manipulate data, which is crucial for making informed decisions based on data analysis.
-- 	SQL is also a valuable skill in the job market, as many roles in data science, data analysis, and software development 
--		require proficiency in SQL.
-- 	Additionally, SQL is relatively easy to learn compared to other programming languages, making it accessible for beginners.

-- What is Database & Types of Database?
-- 	A database is an organized collection of data that is stored and accessed electronically. 
--		It allows users to efficiently manage and retrieve data. There are several types of databases, including:
-- 	1. Relational Databases: These databases store data in tables with rows and columns. 
--		Examples include MySQL, PostgreSQL, and Oracle.
-- 	2. NoSQL Databases: These databases are designed for unstructured data and do not use the traditional table-based structure. 
--		Examples include MongoDB and Cassandra.
-- 	3. In-Memory Databases: These databases store data in memory for faster access. 
--		Examples include Redis and Memcached.
-- 	4. Graph Databases: These databases are designed to store and query data in the form of graphs. 
--		Examples include Neo4j and Amazon Neptune.
-- 	5. Object-Oriented Databases: These databases store data in the form of objects, similar to object-oriented programming. 
--		Examples include ObjectDB and db4o.

-- DQL - Data Query Language
-- DQL is a subset of SQL that focuses on querying data from a database. It includes
-- QUERY DATA
-- The SELECT statement is used to retrieve data from a database. 
-- It allows you to specify which columns you want to retrieve and from which table.
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
-- 5. CROSS JOIN: Returns the Cartesian product of the two tables, i.e., 
--		it returns all possible combinations of rows from both tables.
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
	-- Window Functions: These functions perform a calculation across a set of table rows that are somehow related 
	--		to the current row.

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
	-- CASE statements are used to perform conditional logic in SQL. They allow you to return different 
	--		values based on specified conditions.
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
	
	-- 5. CUME_DIST: Calculates the cumulative distribution of a value in a group of values. 
	--				It returns a value between 0 and 1, inclusive.
		SELECT
			OrderId,
			OrderDate,
			ProductId,
			Sales,
			CUME_DIST() OVER(ORDER BY Sales) AS Cumulative_Distribution
		FROM Sales.Orders
	
	-- 6. PERCENT_RANK: Calculates the relative rank of a row within a partition of a result set,
	--					returning a value between 0 and 1, exclusive.
		SELECT
			OrderId,
			OrderDate,
			ProductId,
			Sales,
			PERCENT_RANK() OVER(ORDER BY Sales) AS Percent_Rank
		FROM Sales.Orders

	-- Window Value Functions:
		-- 1. LAG: Provides access to a row at a specified physical offset that comes before the current row.
			SELECT
				OrderId,
				OrderDate,
				ProductId,
				Sales,
				LAG(Sales, 1) OVER(ORDER BY OrderDate) AS Previous_Sale
			FROM Sales.Orders

			SELECT
				OrderId,
				OrderDate,
				ProductId,
				Sales,
				LAG(Sales, 1) OVER(PARTITION BY ProductId ORDER BY OrderDate) AS Previous_Sale_By_Product
			FROM Sales.Orders
		
		-- 2. LEAD: Provides access to a row at a specified physical offset that follows the current row.
			SELECT
				OrderId,
				OrderDate,
				ProductId,
				Sales,
				LEAD(Sales, 1) OVER(ORDER BY OrderDate) AS Next_Sale
			FROM Sales.Orders

			SELECT
				OrderId,
				OrderDate,
				ProductId,
				Sales,
				LEAD(Sales, 1) OVER(PARTITION BY ProductId ORDER BY OrderDate) AS Next_Sale_By_Product
			FROM Sales.Orders
		
		-- 3. FIRST_VALUE: Returns the first value in an ordered set of values.
			SELECT
				OrderId,
				OrderDate,
				ProductId,
				Sales,
				FIRST_VALUE(Sales) OVER(ORDER BY OrderDate) AS First_Sale
			FROM Sales.Orders

			SELECT
				OrderId,
				OrderDate,
				ProductId,
				Sales,
				FIRST_VALUE(Sales) OVER(PARTITION BY ProductId ORDER BY OrderDate) AS First_Sale_By_Product
			FROM Sales.Orders
		
		-- 4. LAST_VALUE: Returns the last value in an ordered set of values.
			SELECT
				OrderId,
				OrderDate,
				ProductId,
				Sales,
				LAST_VALUE(Sales) OVER(ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Last_Sale
			FROM Sales.Orders

			SELECT
				OrderId,
				OrderDate,
				ProductId,
				Sales,
				LAST_VALUE(Sales) OVER(PARTITION BY ProductId ORDER BY OrderDate ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Last_Sale_By_Product
			FROM Sales.Orders

		-- Examples:
		SELECT
			Month_Of_Sale,
			Previous_month_Sales,
			Total_Sales,
			(Total_Sales - Previous_month_Sales) AS Previous_month_Sales
		FROM
		(
		SELECT
			MONTH(OrderDate) AS Month_Of_Sale,
			SUM(Sales) AS Total_Sales,
			LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) AS Previous_month_Sales
		FROM Sales.Orders
		GROUP BY MONTH(OrderDate)
		)t

		-- Practice Question: In order to analyze customer loyalty, rank customers based on the average days between their orders

		-- Method 1: Using LAG
		SELECT
			CustomerId,
			AVG(Days_Since_Last_Order) AS Avg_Days_Since_Last_Order,
			RANK() OVER(ORDER BY COALESCE(AVG(Days_Since_Last_Order), 1.79e308)) AS Avg_Customer_Order_Rank
		FROM
		(
			SELECT
				OrderId,
				CustomerId,
				OrderDate,
				DATEDIFF(DAY, LAG(OrderDate) OVER(PARTITION BY CustomerId ORDER BY OrderDate), OrderDate) AS Days_Since_Last_Order
			FROM Sales.Orders
		)t
		GROUP BY CustomerID

		-- Method 2: Using LEAD
		SELECT
			CustomerId,
			AVG(Days_For_Next_Order) AS Avg_Days_For_Next_Order,
			RANK() OVER(ORDER BY COALESCE(AVG(Days_For_Next_Order), 1.79e308)) AS Customer_OrderDate_Ranking
		FROM
		(
			SELECT
				CustomerId,
				OrderDate,
				LEAD(OrderDate) OVER(PARTITION BY CustomerId Order BY OrderDate) AS Next_Order_Date,
				DATEDIFF(DAY, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerId Order BY OrderDate)) AS Days_For_Next_Order
			FROM Sales.Orders
		)t
		GROUP BY CustomerId
		HAVING NOT AVG(Days_For_Next_Order) IS NULL
	
-- DataBase Architecture:
	/**************************  **************************  **************************  **************************

	DATABASE ENGINE
		1. CACHE STORAGE
		
		2. DISK STORAGE
			a. USER DATA
				1. DATA TABLES
			
			b. CATALOG DATA
				1. METADATA
					1. SCHEMA
					2. TABLE DEFINITIONS
					3. INDEX DEFINITIONS
			
			c. TEMP DATA
				1. TEMP TABLES
	
	**************************  **************************  **************************  **************************/
-- SUBQUERIES
	-- Definition: A subquery is a query nested inside another query. 
	-- It can be used in various clauses such as SELECT, FROM, WHERE, and HAVING to perform operations that 
	--	require multiple steps of data retrieval or manipulation.

	-- Types of Subqueries:
		-- BY Dependancy:
			-- Correlated Subquery: A subquery that references columns from the outer query. 
			--						It is executed once for each row processed by the outer query.
				-- Example:
				SELECT 
					*,
					(SELECT COUNT(*) FROM Sales.Orders AS o WHERE o.CustomerID = c.CustomerId) AS Total_orders_Pre_Customer
				FROM Sales.Customers AS c
			
			-- Non-Correlated Subquery: A subquery that does not reference columns from the outer query. 
			--							It is executed only once and its result is used by the outer query.
		
		-- BY Result Type:
			-- Scalar Subquery: A subquery that returns a single value (one row and one column).
				-- Example: 
					SELECT (SELECT MAX(Sales) FROM Sales.Orders) AS Max_Sales;
			
			-- Row Subquery: A subquery that returns a single row with multiple columns.
				-- Example:
					SELECT 
						(SELECT FirstName FROM Sales.Employees WHERE EmployeeID = 1) AS Employee_First_Name,
						(SELECT LastName FROM Sales.Employees WHERE EmployeeID = 1) AS Employee_Last_Name;
			
				-- Note: The above example can also be achieved using JOIN, but it demonstrates the concept of a row subquery.
			
			-- Table Subquery: A subquery that returns multiple rows and columns, essentially a result set.
				-- Example:
					SELECT *
					FROM Sales.Orders
					WHERE ProductID IN (SELECT ProductID FROM Sales.Products WHERE Price > 100);
		
		-- BY Location & Clauses:
			-- Subquery in SELECT Clause
				-- Example:
					SELECT 
						OrderID,
						OrderDate,
						(SELECT Product FROM Sales.Products WHERE ProductID = Sales.Orders.ProductID) AS Product_Name
					FROM Sales.Orders;
			
			-- Subquery in FROM Clause
				-- Example:
					SELECT 
						ProductID,
						Total_Sales
					FROM
					(
						SELECT 
							ProductID,
							SUM(Sales) AS Total_Sales
						FROM Sales.Orders
						GROUP BY ProductID
					) AS Sales_By_Product
					WHERE Total_Sales > 1000;
			
			-- Subquery in JOIN Clause
				-- Example:
					SELECT 
						o.OrderID,
						o.OrderDate,
						p.Product,
						o.Sales
					FROM Sales.Orders AS o
					INNER JOIN
					(
						SELECT ProductID, Product FROM Sales.Products WHERE Price > 100
					) AS p ON o.ProductID = p.ProductID;
			
			-- Subquery in WHERE Clause
			    -- Comparison Operators: =, !=, >, <, >=, <=
				-- Logical Operators: IN, ANY, ALL, EXISTS
					-- Example with Comparison Operator:
						SELECT *
						FROM Sales.Orders
						WHERE Sales > (SELECT AVG(Sales) FROM Sales.Orders);
					-- Example with LOGICAL Operator:
						SELECT *
						FROM Sales.Orders
						WHERE ProductID IN (SELECT ProductID FROM Sales.Products WHERE Price > 100);
			
			-- Example 1
				SELECT
					c.*,
					o.Total_Orders
				FROM Sales.Customers AS c
				LEFT JOIN 
				(SELECT
					CustomerId,
					COUNT(*) AS Total_Orders
				FROM Sales.Orders
				GROUP BY CustomerID) AS o
				ON c.CustomerID = o.CustomerID

			-- Example 2
				SELECT * FROM Sales.Orders
				WHERE CustomerId NOT IN (SELECT DISTINCT CustomerId FROM Sales.Customers WHERE Country = 'Germany')

			-- Example 3
				SELECT * FROM Sales.Employees
				WHERE 
					Gender = 'F' AND
					Salary > ANY(SELECT Salary FROM Sales.Employees WHERE Gender = 'M')
			
			-- Example 4
				SELECT
					*
				FROM Sales.Orders o
				WHERE EXISTS (
								SELECT * FROM Sales.Customers c 
								WHERE COUNTRY = 'Germany'
								AND o.CustomerID = c.CustomerID)

-- COMMON TABLE EXPRESSIONS (CTEs)
	-- Definition: A Common Table Expression (CTE) is a temporary result set that can be referenced within a 
	--		SELECT, INSERT, UPDATE, or DELETE statement. 
	-- It is defined using the WITH clause and can be used to simplify complex queries, improve readability, and 
	--		enable recursive queries.

	-- Syntax:
		-- Non-Recursive CTE:
			-- Standalone CTE: A CTE that is defined and used within a single query.
				WITH Total_Sales_Per_Customer AS 
				(
					SELECT
						CustomerId,
						SUM(Sales) AS Total_Sales_PerCustomer
					FROM Sales.Orders
					GROUP BY CustomerId
				),

				Last_order_Date AS (
					SELECT
						CustomerId,
						MAX(OrderDate) AS Last_order_Date
					FROM Sales.Orders
					GROUP BY CustomerId
				)

				SELECT
					*
				FROM Sales.Customers AS c
				LEFT JOIN Total_Sales_Per_Customer AS cts
				ON cts.CustomerID = c.CustomerID
				LEFT JOIN Last_order_Date AS lot
				ON lot.CustomerID = c.CustomerID;
			
			-- Nested CTE: A CTE that references another CTE within its definition.
			WITH Total_Sales_Per_Customer AS 
			(
				SELECT
					CustomerId,
					SUM(Sales) AS Total_Sales_PerCustomer
				FROM Sales.Orders
				GROUP BY CustomerId
			),

			Last_order_Date AS
			(
				SELECT
					CustomerId,
					MAX(OrderDate) AS Last_order_Date
				FROM Sales.Orders
				GROUP BY CustomerId
			),

			Ranking_Customers AS
			(
				SELECT
					*,
					DENSE_RANK() OVER(ORDER BY Total_Sales_PerCustomer DESC) AS Customer_Rankings
				FROM Total_Sales_Per_Customer
			),

			Segemented_Total_Sales AS
			(
				SELECT
					*,
					CASE
						WHEN NTILE(3) OVER(ORDER BY Total_Sales_PerCustomer DESC) = 1  THEN 'High'
						WHEN NTILE(3) OVER(ORDER BY Total_Sales_PerCustomer DESC) = 2  THEN 'Medium'
						WHEN NTILE(3) OVER(ORDER BY Total_Sales_PerCustomer DESC) = 3  THEN 'Low'
					END AS Sales_Category
				FROM Total_Sales_Per_Customer
			)

			SELECT
				c.*,
				cts.*,
				lot.*,
				rc.Customer_Rankings,
				sts.Sales_Category	
			FROM Sales.Customers AS c
			LEFT JOIN Total_Sales_Per_Customer AS cts
			ON cts.CustomerID = c.CustomerID
			LEFT JOIN Last_order_Date AS lot
			ON lot.CustomerID = c.CustomerID
			LEFT JOIN Ranking_Customers AS rc
			ON rc.CustomerId = c.CustomerID
			LEFT JOIN Segemented_Total_Sales AS sts
			ON sts.CustomerID = c.CustomerID

			/* Best Practices:
				1. Rethink & Refactor CTE before writing a new one.
				2. More than 5 CTEs, your SQL starts getting hard to read & maintain.
				3. Avoid using CTEs for simple queries that can be easily achieved with sub query
			*/

		-- Recursive CTE:
			-- A CTE that references itself in its definition, allowing it to perform recursive operations.
				-- Example: Generating a sequence of numbers from 1 to 10 using a recursive CTE.
				WITH Series As
				(
					SELECT 1 AS Number_Sequence
					UNION ALL
					SELECT
						Number_Sequence + 1
					FROM Series
					WHERE Number_Sequence < 11
				)

				SELECT * FROM Series
				OPTION (MAXRECURSION 10)
				
				-- Example: Employee Hierarchy
				WITH CTE_Employee_Hierarchy AS
				(
					SELECT
						EmployeeId,
						FirstName,
						LastName,
						ManagerId,
						1 AS Level
					FROM Sales.Employees
					WHERE ManagerId IS NULL
					UNION ALL
					SELECT
						e.EmployeeId,
						e.FirstName,
						e.LastName,
						e.ManagerId,
						Level + 1
					FROM Sales.Employees AS e
					INNER JOIN CTE_Employee_Hierarchy AS ceh
					ON e.ManagerID = ceh.EmployeeID
				)

				SELECT * FROM CTE_Employee_Hierarchy

-- Levels of Architecture:
	-- 1. Physical Level: This level describes how data is stored in the database, including the file structures, indexing, 
	--					and access methods. 
	--					It is concerned with the physical storage of data on disk and the optimization of data retrieval.

	-- 2. Logical Level: This level describes what data is stored in the database and the relationships between different 
	--					data entities. 
	--					It focuses on the design of the database schema, including tables, columns, data types, and constraints.

	-- 3. View Level: This level describes how users interact with the database and how data is presented to them. 
	--				It includes user interfaces, query languages, and application programming interfaces (APIs) that allow 
	--				users to access and manipulate data.

-- Views
	-- Definition: A view is a virtual table that is based on the result set of a SELECT statement. 
	-- It does not store data itself but provides a way to simplify complex queries, enhance security, 
	-- and present data in a specific format.

	-- Syntax:
	CREATE VIEW view_name AS
	SELECT column1, column2, ...
	FROM table_name
	WHERE condition;

	-- USE CASE #1: Central Query Logic -> A view can be used to centralize complex query logic, 
	--				allowing users to access the data through a simplified interface.

	-- CREATING a VIEW:
		CREATE VIEW MonthlySales AS
		(
			SELECT
				DATETRUNC(MONTH, OrderDate) AS current_month,
				SUM(Sales) AS Total_Sales,
				COUNT(OrderID) AS Total_Orders,
				SUM(Quantity) AS Total_Quantities
			FROM Sales.Orders
			GROUP BY DATETRUNC(MONTH, OrderDate)
		)
	
	-- Dropping a View:
		DROP VIEW MonthlySales;

	-- Updating a View: ********** ONLY APPLICABLE FOR SOME DATABASE SYSTEMS **********
		CREATE OR REPLACE VIEW MonthlySales AS
		(
			SELECT
				DATETRUNC(MONTH, OrderDate) AS current_month,
				SUM(Sales) AS Total_Sales,
				COUNT(OrderID) AS Total_Orders,
				SUM(Quantity) AS Total_Quantities
			FROM Sales.Orders
			GROUP BY DATETRUNC(MONTH, OrderDate)
		)

	-- USE CASE #2: Hide Complexity -> 
	--		A view can be used to hide the complexity of underlying data structures and present a simplified interface to users.
		-- 	For example, a view can be created to join multiple tables and present a consolidated view of data, 
		-- allowing users to query
		CREATE VIEW Sales.Mega_Table AS
		(
			SELECT
				c.*,
				o.OrderId,
				o.OrderDate,
				o.ShipDate,
				o.Sales,
				p.ProductID,
				P.Product,
				e.EmployeeID,
				CONCAT(COALESCE(e.FirstName, ''), COALESCE(e.LastName, '')) AS Employee_Name,
				e.Gender AS Employee_Gender,
				e.ManagerId
			FROM Sales.Customers AS C
			LEFT JOIN Sales.Orders AS o ON c.CustomerID = o.CustomerID
			LEFT JOIN Sales.Products AS p ON p.ProductID = o.ProductID
			LEFT JOIN Sales.Employees AS e ON e.EmployeeID = o.SalesPersonID
		)
	
	-- USE CASE #3: Data Security -> 
	--	A view can be used to restrict access to sensitive data by only exposing specific columns or rows to users.
	--	For example, a view can be created to only show sales data for a specific region or to exclude certain customer information.
		CREATE VIEW Sales.EU_Sales_Team AS
		(
			SELECT
				c.*,
				o.OrderId,
				o.OrderDate,
				o.ShipDate,
				o.Sales,
				p.ProductID,
				P.Product,
				e.EmployeeID,
				CONCAT(COALESCE(e.FirstName, ''), COALESCE(e.LastName, '')) AS Employee_Name,
				e.Gender AS Employee_Gender,
				e.ManagerId
			FROM Sales.Customers AS C
			LEFT JOIN Sales.Orders AS o ON c.CustomerID = o.CustomerID
			LEFT JOIN Sales.Products AS p ON p.ProductID = o.ProductID
			LEFT JOIN Sales.Employees AS e ON e.EmployeeID = o.SalesPersonID
			WHERE c.Country != 'USA'
		)
	
	-- USE CASE #4: Flexibility & Dynamic:
	--	A view can be used to provide flexibility in querying data by allowing users to create their own views 
	-- based on specific requirements.

	-- USE CASE #5: Multiple Languages:
	--	A view can be used to provide support for multiple languages by creating views that translate data into 
	-- different languages based on user preferences.

	-- USE CASE #6: Virtual Data Marts in DWH:
	--	A view can be used to create virtual data marts in a data warehouse, 
	-- allowing users to access specific subsets of data without needing to create physical tables for each subset.

-- CTAS & Temp Tables
	-- Syntax (in SQL Server):
		SELECT column1, column2, ...
		INTO new_table
		FROM existing_table
		WHERE condition;

	-- Create:
		SELECT
			DATENAME(month, OrderDate) OrderMonth,
			COUNT(OrderID) TotalOrders
		INTO Sales.MonthlyOrders
		FROM Sales.Orders
		GROUP BY DATENAME(month, OrderDate);

	-- Drop:
		DROP TABLE Sales.MonthlyOrders;

	-- Refresh CTAS:
		IF OBJECT_ID('Sales.MonthlyOrders', 'U') IS NOT NULL
			DROP TABLE Sales.MonthlyOrders;
		GO
		SELECT
			DATENAME(month, OrderDate) OrderMonth,
			COUNT(OrderID) TotalOrders
		INTO Sales.MonthlyOrders
		FROM Sales.Orders
		GROUP BY DATENAME(month, OrderDate);

-- Temporary Tables:
	-- Definition: Temporary tables are special types of tables that are created and used to store intermediate results during a session. 
	-- They are automatically dropped when the session ends or when they are no longer needed.

	-- Types of Temporary Tables:
		-- Local Temporary Tables: These tables are prefixed with a single # and are only visible to the session that created them.
			SELECT
				DATENAME(month, OrderDate) AS Order_Month,
				COUNT(OrderID) AS Total_Orders
			INTO #MonthlyOrders
			FROM Sales.Orders

		-- Global Temporary Tables: These tables are prefixed with ## and are visible to all sessions.
			SELECT
				DATENAME(month, OrderDate) AS Order_Month,
				COUNT(OrderID) AS Total_Orders
			INTO ##MonthlyOrders
			FROM Sales.Orders
	
-- Comparing all (Subquery, Views, CTAS, Temp Tables, CTEs):
| Feature              | Sub Query                      | CTE (Common Table Expression) | Temp Table                              | CTAS (CREATE Table AS Select) | View                        |
| -------------------- | ------------------------------ | ----------------------------- | --------------------------------------- | ----------------------------- | --------------------------- |
|   Storage            | Memory/Cache                   | Memory/Cache                  | Disk Storage                            | Disk Storage                  | No Storage                  |
|   LifeTime           | Temporary                      | Temporary                     | Temporary                               | Permanent                     | Permanent                   |
|   When Deleted       | End of Query                   | End of Query                  | End of Session                          | DDL-DROP                      | DDL-DROP                    |
|   Scope              | Single Query                   | Single Query                  | Multiple Queries                        | Multiple Queries              | Multiple Queries            |
|   Reusability        | Very Limited - 1 Place 1 Query | Limited - 1+ Places 1 Query   | Medium - 1+ Places 1+ Queries (session) | High - 1+ Places 1+ Queries   | High - 1+ Places 1+ Queries |
|   Refresh / Update   | Yes                            | Yes                           | No                                      | No                            | Yes                         |

-- Stored Procedures
	-- Definition: A stored procedure is a precompiled collection of SQL statements and optional control-of-flow statements 
	-- 				that are stored under a name and processed as a unit. 
	-- They can accept parameters, perform complex operations, and return results.

	-- Syntax:
	/***************************************************************/
		-- Getting Customer Overview for USA
		CREATE PROCEDURE USA_Customer_Overview AS
		BEGIN
			SELECT
				COUNT(*) AS Customers_in_USA,
				AVG(Score) AS Avg_Score
			FROM Sales.Customers
			WHERE Country = 'USA'
		END

		EXEC USA_Customer_Overview
	/***************************************************************/

	-- Getting Customer Overview for any Country (Dynamic):
	ALTER PROCEDURE USA_Customer_Overview @Country NVARCHAR(50) AS
	BEGIN
		SELECT
			COUNT(*) AS Customers_in_USA,
			AVG(Score) AS Avg_Score
		FROM Sales.Customers
		WHERE Country = @Country
	END

	EXEC USA_Customer_Overview @Country = 'INDIA'

	/***************************************************************/

	-- Dropping a Stored Procedure:
	DROP PROCEDURE USA_Customer_Overview

	/***************************************************************/

	-- Geeting Customer Overview for any Country when Country is not specified (Dynamic with Default Value):
	ALTER PROCEDURE USA_Customer_Overview @Country NVARCHAR(50) = 'USA' AS
	BEGIN
		SELECT
			COUNT(*) AS Customers_in_USA,
			AVG(Score) AS Avg_Score
		FROM Sales.Customers
		WHERE Country = @Country
	END

	/***************************************************************/

	-- Variables in Stored Procedures:

	ALTER PROCEDURE USA_Customer_Overview @Country NVARCHAR(50) = 'USA'
	AS
	BEGIN

		DECLARE @TotalCustomers INT, @AvgScore FLOAT;

		SELECT
			@TotalCustomers = COUNT(*),
			@AvgScore = AVG(Score)
		FROM Sales.Customers
		WHERE Country = @Country;

		PRINT 'Total Customers in the country ' + @Country + ' : ' + CAST(@TotalCustomers AS NVARCHAR);
		PRINT 'Average Score in the country ' + @Country + ' : ' + CAST(@AvgScore AS NVARCHAR);

	END

	EXEC USA_Customer_Overview

	-- Control of Flow Statements in Stored Procedures:

	ALTER PROCEDURE USA_Customer_Overview @Country NVARCHAR(50) = 'USA'
	AS
	BEGIN

		DECLARE @TotalCustomers INT, @AvgScore FLOAT;

		IF EXISTS (SELECT 1 FROM Sales.Customers WHERE SCORE IS NULL)
		BEGIN
			PRINT 'Scores updated to 0 for the country ' + @Country;
			UPDATE Sales.Customers
			SET Score = 0
			WHERE SCORE IS NULL;
		END

		ELSE
		BEGIN
			PRINT 'No NULL Scores found for the country ' + @Country;
		END

		SELECT
			@TotalCustomers = COUNT(*),
			@AvgScore = AVG(Score)
		FROM Sales.Customers
		WHERE Country = @Country;

		PRINT 'Total Customers in the country ' + @Country + ' : ' + CAST(@TotalCustomers AS NVARCHAR);
		PRINT 'Average Score in the country ' + @Country + ' : ' + CAST(@AvgScore AS NVARCHAR);

	END

	EXEC USA_Customer_Overview @Country = 'Germany'

-- Triggers:
	-- Definition: A trigger is a special type of stored procedure that automatically executes in response 
	-- to certain events on a particular table or view. 
	
	-- Triggers can be used to enforce business rules, maintain data integrity, and perform auditing tasks.

	-- Types of Triggers:
		-- DML Triggers: These triggers are executed in response to Data Manipulation Language (DML) events 
		-- such as INSERT, UPDATE, or DELETE.
			-- After Triggers: These triggers are executed after the triggering DML event has occurred and the data has been modified.
			
			-- Instead of Triggers: These triggers are executed instead of the triggering DML event

		-- DDL Triggers: These triggers are executed in response to Data Definition Language (DDL) events 
		-- such as CREATE, ALTER, or DROP.

		-- Logon Triggers: These triggers are executed in response to LOGON events, which occur when a user
		-- attempts to connect to the database.

		-- Syntax:
			CREATE TRIGGER trigger_name ON table_name
			AFTER|INSTEAD OF|BEFORE INSERT|UPDATE|DELETE
			BEGIN
				-- Trigger logic goes here
			END

		-- Example 1:
			-- This trigger updates the Score of customers by adding 10 points whenever their information is updated in the 
			-- Sales.Customers table.

			CREATE TRIGGER trg_Update_Customer_Score ON Sales.Customers
			AFTER UPDATE
			AS
			BEGIN
				UPDATE Sales.Customers
				SET Score = Score + 10
				WHERE CustomerID IN (SELECT DISTINCT CustomerID FROM inserted)
			END

		-- Example 2:
			-- This trigger logs the addition of new employees in the Sales.Employees table by inserting a record into the 
			-- Sales.EmployeeLogs table with the EmployeeID, a log message, and the current date and time.

			CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
			AFTER INSERT
			AS
			BEGIN
				INSERT INTO Sales.EmployeeLogs (EmployeeID, LogMessage, LogDate)
				SELECT
					EmployeeID,
					'New Employee Added =' + EmployeeID,
					GETDATE()
				FROM INSERTED
			END

-- INDEXES:
	-- Definition: An index is a database object that improves the speed of data retrieval operations on a table at 
	-- the cost of additional storage space and maintenance overhead. 

	/* Types of INDEXES:
		|
		| -- Based on STRUCTURE:
		|		1. CLUSTERED INDEX: A clustered index determines the physical order of data in a table. 
		|						There can be only one clustered index per table, as the data rows can be sorted in only one order.
		|		
		|		2. NON-CLUSTERED INDEX: A non-clustered index is a separate structure from the data rows,
		|						containing a copy of the indexed columns and a pointer to the actual data rows.
		|
		| -- Based on Storage:
		|		1. ROWSTORE INDEX: An index that is stored in a row-based format, where each index entry corresponds to 
		|							a single row in the table.
		|		
		|		2. COLUMNSTORE INDEX: An index that is stored in a column-based format, where each index entry corresponds to
		|							a single column in the table. Columnstore indexes are optimized for analytical queries.
		|
		| -- Based On Functions:
		|		1. UNIQUE INDEX: An index that enforces the uniqueness of values in the indexed columns, 
		|						ensuring that no duplicate values are allowed.
		|
		|		2. FILTERED INDEX: An index that is created with a WHERE clause to include only a subset of rows in the table,
		|						allowing for more efficient indexing of specific data subsets.
	*/

	-- PAGE: A page is the basic unit of data storage in a database. 
	-- 		It is a fixed-size block of memory (usually 8 KB) that contains rows of data.
	
	-- Types of Pages:
		-- Data Page: A page that contains actual data rows from a table.
			-- Header
			-- Row Data
			-- Row Offsets
			
		-- Index Page: A page that contains index entries, which are pointers to data rows in the table.
	
	-- HEAP: A heap is a table that does not have a clustered index.
	--		1. The data rows in a heap are not stored in any particular order, and there is no structure to optimize data retrieval.
	--		2. Heaps can lead to slower query performance, as the database engine may need to scan the entire table to find 
	-- 			specific rows.
	--  	3. Slow Read and Fast Write (Full Table scan)

-- Clustered Index:
	-- Definition: A clustered index is a type of index that determines the physical order of data in a table. 
	--				There can be only one clustered index per table, as the data rows can be sorted in only one order.

	-- Syntax:
	CREATE CLUSTERED INDEX index_name ON table_name (column1, column2, ...);

	-- Example:
	CREATE CLUSTERED INDEX idx_CustomerID ON Sales.Customers (CustomerID);

-- Non-Clustered Index:
	-- Definition: A non-clustered index is a separate structure from the data rows, containing a copy of the indexed columns 
	--				and a pointer to the actual data rows. 
	--				There can be multiple non-clustered indexes on a table, allowing for different access paths to the data.

	-- Syntax:
	CREATE NONCLUSTERED INDEX index_name ON table_name (column1, column2, ...);

	-- Example:
	CREATE NONCLUSTERED INDEX idx_CustomerName ON Sales.Customers (FirstName, LastName);

/*******************************************************************************************************************************************************************************************************************

| Aspect                 | Clustered Index                                                                                 | Non-Clustered Index                                                                  |
| ---------------------- | ----------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| **Definition**         | Physically sorts and stores rows                                                                | Separate structure with pointers to the data                                         |
| **Number of Indexes**  | One index per table                                                                             | Multiple indexes allowed                                                             |
| **Read Performance**   | Faster                                                                                          | Slower                                                                               |
| **Write Performance**  | Slower (due to potential row reordering)                                                        | Faster (physical order unaffected)                                                   |
| **Storage Efficiency** | More storage-efficient                                                                          | Requires additional storage space                                                    |
| **Use Case**           | - Unique column  <br> - Not frequently modified column  <br> - Improves range query performance | - Columns frequently used in search conditions and joins  <br> - Exact match queries |

******************************************************************************************************************************************************************************************************************/

-- Composite Index:
	-- Definition: A composite index is an index that includes multiple columns. 
	--				It can be either clustered or non-clustered and is used to improve query performance when 
	-- 				filtering or sorting by multiple columns.

	-- Syntax:
	CREATE INDEX index_name ON table_name (column1, column2, ...);

	-- Example:
	CREATE NONCLUSTERED INDEX idx_CustomerName_Country ON Sales.Customers (FirstName, LastName, Country);

	-- Rule: 
	-- 	1. The order of columns in a composite index must match the order of columns in the query, otherwise
	-- 		the index will not be used by the query optimizer.
	-- 	2. Index works if the leftmost column(s) of the index are used in the query's WHERE clause or JOIN condition.

-- Columnstore Index:
	-- Definition: A columnstore index is a type of index that is stored in a column-based format, where each index entry corresponds to a single column in the table. 
	--				Columnstore indexes are optimized for analytical queries and can significantly improve performance for large datasets.

	-- Syntax:
	CREATE COLUMNSTORE INDEX index_name ON table_name (column1, column2, ...);

	-- Example:
	CREATE COLUMNSTORE INDEX idx_Sales_CustomerID ON Sales.Orders (CustomerID);

-- Rowstore Index:
	-- Definition: A rowstore index is a type of index that is stored in a row-based format, where each index entry corresponds to a single row in the table. 
	--				Rowstore indexes are optimized for transactional queries and can improve performance for point lookups and small result sets.

	-- Syntax:
	CREATE ROWSTORE INDEX index_name ON table_name (column1, column2, ...);

	-- Example:
	CREATE NONCLUSTERED ROWSTORE INDEX idx_OrderDate ON Sales.Orders (OrderDate);