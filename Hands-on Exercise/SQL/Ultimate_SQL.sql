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
|   Definition           | Physically sorts and stores rows                                                                | Separate structure with pointers to the data                                         |
|   Number of Indexes    | One index per table                                                                             | Multiple indexes allowed                                                             |
|   Read Performance     | Faster                                                                                          | Slower                                                                               |
|   Write Performance    | Slower (due to potential row reordering)                                                        | Faster (physical order unaffected)                                                   |
|   Storage Efficiency   | More storage-efficient                                                                          | Requires additional storage space                                                    |
|   Use Case             | - Unique column  <br> - Not frequently modified column  <br> - Improves range query performance | - Columns frequently used in search conditions and joins  <br> - Exact match queries |

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
	CREATE NONCLUSTERED COLUMNSTORE INDEX index_name ON table_name (column1, column2, ...);
	CREATE CLUSTERED COLUMNSTORE INDEX index_name ON table_name;

	-- Example:
	CREATE NONCLUSTERED COLUMNSTORE INDEX idx_Sales_CustomerID ON Sales.Orders (CustomerID);

	-- Process:
	-- 1. Rwo Groups: Data is divided into row groups, which are collections of rows that are stored together
	-- 2. Column Segemnt: Each column in a row group is stored separately
	-- 3. Compression: Columnstore indexes use advanced compression techniques to reduce storage space & improve query performance.
	-- 4. Store: LoB data types are stored separately from the columnstore index & pointers to the LoB data are stored in the index.

	-- Rule: Do not mention column name while creating clustered columnstore index, 
	-- as it automatically includes all columns in the table.

-- Rowstore Index:
	-- Definition: A rowstore index is a type of index that is stored in a row-based format, where each index entry corresponds to a single row in the table. 
	--				Rowstore indexes are optimized for transactional queries and can improve performance for point lookups and small result sets.

	-- Syntax: (Same as Clustered & Non-Clustered Index)
	CREATE CLUSTERED INDEX index_name ON table_name (column1, column2, ...);

	-- Example:
	CREATE NONCLUSTERED INDEX idx_OrderDate ON Sales.Orders (OrderDate);

/*************************************************************************************************************************************************************************************************

| Aspect                      | Rowstore Index                                                                  | Columnstore Index                                                              |
| --------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
|   Definition                | Organizes and stores data **row by row**                                        | Organizes and stores data **column by column**                                 |
|   Storage Efficiency        | Less efficient in storage                                                       | Highly efficient with compression                                              |
|   Read/Write Optimization   | Fair speed for read & write operations                                          | Fast read performance, slow write performance                                  |
|   I/O Efficiency            | Lower (retrieves all columns)                                                   | Higher (retrieves specific columns)                                            |
|   Best For                  | OLTP (Transactional): commerce, banking, financial systems, order processing    | OLAP (Analytical): data warehouse, business intelligence, reporting, analytics |
|   Use Case                  | - High-frequency transaction applications <br>- Quick access to complete records| - Big data analytics<br>- Scanning large datasets<br>- Fast aggregation        |

**************************************************************************************************************************************************************************************************/

-- UNIQUE Index:
-- Definition: A unique index is an index that enforces the uniqueness of values in the indexed columns, 
-- ensuring that no duplicate values are allowed.

-- Syntax:
CREATE UNIQUE [CLUSTERED | NONCLUSTERED] COLUMNSTORE INDEX index_name ON table_name (column1, column2, ...);

-- Example:
CREATE UNIQUE [CLUSTERED | NONCLUSTERED] COLUMNSTORE INDEX idx_Unique_CustomerID ON Sales.Customers (CustomerID);

-- Benefits:
-- 1. Data Integrity: Unique indexes ensure that duplicate values are not allowed in the indexed columns,
-- 	maintaining data integrity and consistency.
-- 2. Performance: Unique indexes can improve query performance by allowing the database engine to quickly locate specific rows based on the unique values.
-- 3. Enforcing Business Rules: Unique indexes can be used to enforce business rules, such as ensuring that 
-- 	email addresses or social security numbers are unique within a table.

-- Filtered Index:
-- Definition: A filtered index is an index that is created with a WHERE clause to include only a subset of rows in the table, 
-- allowing for more efficient indexing of specific data subsets.

-- Syntax:
CREATE UNIQUE NONCLUSTERED COLUMNSTORE INDEX index_name ON table_name (column1, column2, ...)
WHERE condition;

-- Example:
CREATE UNIQUE NONCLUSTERED COLUMNSTORE INDEX idx_Unique_CustomerID ON Sales.Customers (CustomerID)
WHERE Status = 'Active';

-- Benefits:
-- 1. Improved Performance: Filtered indexes can significantly improve query performance by 
--		indexing only a subset of rows that are relevant to specific queries, reducing the size of the index and 
-- 		improving search efficiency.
-- 2. Reduced Storage: Filtered indexes require less storage space compared to full indexes, 
-- 		as they only include a subset of rows.

-- Rules:
-- 1. You cannot use a filtered index on a clustered index.
-- 2. You cannot use a filtered index on a columstore index.

/* ***************************** !!!!!!!!!!! IMPORTANT IMPORTANT IMPORTANT !!!!!!!!!!! ******************************

Choosing the RIGHT INDEX for optimizing query performance and ensuring efficient data retrieval.


# Step 1 — Choose Table Structure (Heap vs Clustered)

### Use a Heap when:
	* Data is temporary or staging
	* You perform bulk inserts (ETL loads)
	* You rarely read the data before transforming/moving it

Why:
	* No index maintenance → fastest writes
	* No ordering → minimal overhead

Avoid heaps when:
	* Queries need frequent lookups -> leads to expensive scans or RID lookups
	* Table persists long-term

-------------------------------------------------------------------------------------

### Use a Clustered Index when:
	* Table is part of OLTP workload
	* You query data regularly

What it does:
	* Physically orders the table by the clustered key
	* Every table should usually have one

-------------------------------------------------------------------------------------

# Step 2 — Choose the Right Clustered Index

### Good clustered index characteristics:
	1. Frequently used in range queries
	2. Monotonically increasing values
	3. Used for sorting

### Bad clustered index choices:
	1. Random values (e.g., GUIDs)
		* Causes page splits
		* Degrades insert performance
	2. Wide keys
		* Increases size of all non-clustered indexes

### Rule of thumb:
> Pick a column that matches how data is read, not just the primary key.

-------------------------------------------------------------------------------------

# Step 3 — Add Non-Clustered Indexes (Access Optimization)

### Use Non-Clustered Indexes on columns which are:
	1. Filtered (WHERE email = ? ... or... WHERE status = 'active')
	2. Joined (JOIN orders o ON o.user_id = u.id)
	3. Sorted (ORDER BY created_at)

### How to design them:
	1. Single-column index (Good for simple filters):
		CREATE INDEX ix_users_email ON users(email);
	
	2. Composite index (multi-column) For combined conditions:
		a. WHERE status = 'active' AND created_at > ...
		b. CREATE INDEX ix ON table(status, created_at);

### Order matters:
	* Left-most column must match query usage

### Avoid:
	* Indexing every column
	* Indexing low-selectivity columns alone (e.g., 'is_active')

-------------------------------------------------------------------------------------

# Step 4 — Optimize with Advanced Techniques

## 4.1 Covering Index (High Impact) [Avoid extra lookups]
	Query --> SELECT name, email FROM users WHERE email = ?
	Index --> CREATE INDEX ix_users_email ON users(email) INCLUDE (name);

Result:
	* Query satisfied entirely from index
	* No table access which means faster performance

---

## 4.2 Filtered Index (Targeted Optimization)
	Use when queries hit a subset of data
		Query --> WHERE status = 'active'
		index --> CREATE INDEX ix_active_users ON users(email) WHERE status = 'active';

Benefits:
	* Smaller index
	* Faster scans
	* Lower maintenance cost

---

## 4.3 Unique Index
	
	Syntax --> CREATE UNIQUE INDEX ix_email ON users(email);

Use when:
	* Data must be unique
	* Helps optimizer assume 1 row → better plans

-------------------------------------------------------------------------------------

# Step 5 — Use Columnstore for Analytics

### Switch when:
	* Table is very large
	* Queries are:
		* Aggregations (SUM, COUNT, GROUP BY)
		* Scanning many rows

### Benefits:
	* High compression
	* Batch execution (faster scans)

### Avoid when:
	* Frequent single-row lookups
	* Heavy OLTP writes

-------------------------------------------------------------------------------------

# Step 6 — Always Consider Tradeoffs

Every index has a cost:

| Operation | Impact    |
| --------- | --------- |
| INSERT    | Slower    |
| UPDATE    | Slower    |
| DELETE    | Slower    |
| Storage   | Increased |

-------------------------------------------------------------------------------------

# Step 7 — Simple Decision Flow

### 1. Is this staging/temp data? ----> Use Heap

### 2. Otherwise ----> Create Clustered Index based on access pattern

### 3. Identify slow queries ----> Add Non-Clustered Indexes

### 4. Still slow?  ----> 
		Add:
			* Covering indexes
			* Filtered indexes

### 5. Large analytics workload? ----> Consider Columnstore

# Key Principle
	> Indexes should reflect **how queries access data**, not how tables are designed.

***************************** !!!!!!!!!!! IMPORTANT IMPORTANT IMPORTANT !!!!!!!!!!! ****************************** */

-- INDEX monitoring and Management
	-- Monitor Index Usage
	--		1. List indexes on a specific table
				-- Syntax --> sp_helpindex table_name
				-- Example:
					sp_helpindex 'Sales.Customers'
	
	--		2. Query to get Tables, INdexes & User usage summary
				SELECT
					idx.OBJECT_ID,
					tbl.name AS Table_Name,
					idx.name AS Index_Name,
					idx.type_desc AS Index_Type,
					idx.is_primary_key AS IsPrimaryKey,
					idx.is_unique AS isUnique,
					idx.is_disabled AS isDisabled,
					dmv.*
				FROM sys.indexes idx
				INNER JOIN sys.tables tbl ON idx.object_id = tbl.object_id
				LEFT JOIN sys.dm_db_index_usage_stats dmv ON idx.object_id = dmv.object_id AND idx.index_id = dmv.index_id
				ORDER BY tbl.name, idx.name
	
	-- Monitor Missing Indexes
		SELECT * FROM sys.dm_db_missing_index_details
		SELECT * FROM sys.dm_db_missing_index_groups
	
	-- Monitor Duplicate Indexes
		-- A duplicate index is an index that has the same key columns as another index on the same table, 
		-- but may differ in included columns or other properties.
		SELECT
			tbl.name AS Table_name,
			col.name AS Column_name,
			idx.name AS Index_name,
			idx.type_desc AS Index_type,
			COUNT(*) OVER(PARTITION BY tbl.name, col.name) AS ColumnCount
		FROM sys.indexes idx
		JOIN sys.tables tbl ON idx.object_id = tbl.object_id
		JOIN sys.index_columns ic ON idx.object_id = ic.object_id
		JOIN sys.columns col ON idx.object_id = col.object_id
		ORDER BY ColumnCount DESC
	
	-- Update Statistics
		-- Statistics are essential for the query optimizer to make informed decisions about query execution plans.
		SELECT
			SCHEMA_NAME(t.schema_id) AS SchemaName,
			t.name AS TableName,
			s.name AS StatisticName,
			sp.last_updated AS LastUpdate,
			DATEDIFF(day, sp.last_updated, GETDATE()) AS LastUpdateDay,
			sp.rows AS 'Rows',
			sp.modification_counter AS ModificationsSinceLastUpdate
		FROM sys.stats AS s
		JOIN sys.tables t
			ON s.object_id = t.object_id
		CROSS APPLY sys.dm_db_stats_properties(s.object_id, s.stats_id) AS sp
		ORDER BY sp.modification_counter DESC;

		-- Ex1: Update Statistics for an entire table
		UPDATE STATISTICS Sales.Customers;
		
		-- Ex2: Update Statistics for a specific index
		UPDATE STATISTICS Sales.Customers _WA_Sys_00000002_00000000;

		-- Ex3: Update statistics for all tables in the database
		EXEC sp_updatestats; 

		-- Best Practices:
		--	1. Weekly or Monthly updates for large tables with frequent modifications
		--	2. After significant data changes i.e Bulk Updates / Data Migrations

	-- Monitor Fragmentations
		-- Fragmentation occurs when the logical order of data pages does not match the physical order on disk, 
		-- leading to inefficient I/O operations.

		-- Fragmentation Methods:
			-- 1. REORGANIZE: This method defragments the leaf level of the index by physically reordering the pages 
			--				to match the logical order.

			-- 2. REBUILD: This method drops and recreates the index, which can be more effective for heavily fragmented indexes, 
			--				but it is more resource-intensive and can cause downtime.
		
		SELECT
			tbl.name AS TableName,
			idx.name AS IndexName,
			s.avg_fragmentation_in_percent,
			s.page_count
		FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'DETAILED') AS s
		INNER JOIN sys.tables tbl ON s.object_id = tbl.object_id
		INNER JOIN sys.indexes AS idx ON idx.object_id = s.object_id AND idx.index_id = s.index_id
		ORDER BY s.avg_fragmentation_in_percent DESC;

		-- When to DeFragment:
		-- 	if avg_fragmentation_in_percent	< 10%       ===> No Action Required
		--	if avg_fragmentation_in_percent 10% - 30%   ===> Need to REORGANIZE
		--	if avg_fragmentation_in_percent > 30%       ===> Need to REBUILD

		ALTER INDEX idx_CustomerName_Country ON Sales.Customers REBUILD

		ALTER INDEX idx_CustomerName_Country ON Sales.Customers REORGANIZE

-- Execution Plan: Roadmap generated by a DB on how it will execute your query

-- Types of Scans/Seeks:
-- 	1. Table Scan
-- 	2. Index Scan
-- 	3. Index Seek

-- Join Algorithms:
--	1. Nested Loops
--	2. HASH Match
--	3. MERGE Join

-- If the predictions from ESTIMATED EXECUTION PLAN dont match the ACTUAL EXECUTION PLAN, this indicates issues like
-- inacurate statistics or outdated indexes, leading to poor performance.

-- SQL Hints: If for some reason SQL does not use the optimal Index/JOIN/Nested loops (due to outdated statics etc...), 
--				we can give it a hint in order to choose the right approach.
	-- Example 1:
		SELECT * FROM Sales.Orders o
		JOIN Sales.Customers c ON o.CustomerId = c.CustomerId
		OPTION (HASH JOIN)
	
	-- Example 2:
		SELECT * FROM Sales.Orders o
		JOIN Sales.Customers c WITH (FORCESEEK)
		ON o.CustomerId = c.CustomerId

	-- Example 3:
		SELECT * FROM Sales.Orders o
		JOIN Sales.Customers c WITH (INDEX(index_name))
		ON o.CustomerId = c.CustomerId

-- Indexing Strategy:

	GOLDEN RULE -> AVOID OVER INDEXING

	-- Phases of Project / Indexing Strategy
	--		1. Initial Indexing Strategy
	--			In OLAP --> Try to optimize READ Performance by switching LARGE FREQUENTLY used tables to COLUMNSTORE
	--			In OLTP --> Try to optimize WRITE Performance by creating CLUSTERED INDEX on Primary Keys
	
	--		2. Usage Patterns Indexing:
	--			a. Identify frequently used Tables & Columns
					-- Prompt to get Usge Patters from the Queries:
						/*
						Analyze the following SQL queries and generate a report on table and column usage statistics. For each table, provide:
						- The total number of times the table is used across all queries.
						- A breakdown of each column in the table, showing:
							- The number of times each column appears.
							- The primary purpose of the column's usage (e.g., filtering, joining, grouping, aggregating).
						Sort the tables in descending order based on their total usage.
						*/
	--			b. Choose the Right INDEX (Refer Above from Line number 1562)
	--			c. Test Your Index

	--		3. Scenario-Based Indexing
	--			a. IOdentify SLOW Queries
	--			b. Check your Execution Plan
	--			c. Choose the Right INDEX (Refer Above from Line number 1562)
	--			d. Test & Compare the Execution Plans
	
	--		4. Monitoring & Maintainance (Refer Line Numbers From 1722 - 1820)
	--			a. Monitor Index Usage 
	--			b. Monitor Missing Indexes
	--			c. Monitor Duplicate Indexes
	--			d. Update Statistics
	--			e. Monitor Fragmentations

-- SQL PARTITIONING (PARTITION):
	-- Definition: Partitioning is a database design technique that involves dividing a large table into smaller, more manageable pieces called partitions. 
	--				Each partition can be stored separately and can be accessed independently, which can improve query performance and manageability.

	-- Types of Partitioning:
		-- Range Partitioning: Data is partitioned based on a range of values in a specified column. 
						--	For example, you could partition a sales table by year, with each partition containing data for a specific year.
		
		-- List Partitioning: Data is partitioned based on a list of discrete values in a specified column. 
						--	For example, you could partition a customer table by country, with each partition containing data for customers from a specific country.

		-- Hash Partitioning: Data is partitioned based on the result of a hash function applied to a specified column. 
						--	This method distributes data evenly across partitions but does not allow for range queries.

	-- STEP 1:
	-- Creating Partition Function: Define the logic on how to divide your data into partitions & its based on PARTITION KEY ...
		-- Syntax:
		CREATE PARTITION FUNCTION PartitionByYear (DATE)
		AS RANGE LEFT FOR VALUES ('2024-12-31', '2025-12-31', '2026-12-31')

	-- STEP 2:
	-- Creating Filegroup: A filegroup is a logical container for database objects, including partitions. 
		--				Each partition can be assigned to a specific filegroup, allowing for better management and performance.
		-- Syntax:
		ALTER DATABASE YourDatabaseName ADD FILEGROUP FG_2024
		ALTER DATABASE YourDatabaseName ADD FILEGROUP FG_2025
		ALTER DATABASE YourDatabaseName ADD FILEGROUP FG_2026
		ALTER DATABASE YourDatabaseName ADD FILEGROUP FG_2027

	-- STEP 3:
	-- Creating Data Files: Data files are physical files on disk that store the data for a filegroup. 
		--				Each filegroup must have at least one data file associated with it.
		-- Syntax:
		ALTER DATABASE YourDatabaseName ADD FILE 
		(
			NAME = 'Partition_2024', -- Logical Name
			FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\Partition_2024.ndf', 
		) TO FILEGROUP FG_2024
		
		ALTER DATABASE YourDatabaseName ADD FILE 
		(
			NAME = 'Partition_2025', -- Logical Name
			FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\Partition_2025.ndf',
		) TO FILEGROUP FG_2025
		
		ALTER DATABASE YourDatabaseName ADD FILE 
		(
			NAME = 'Partition_2026', -- Logical Name
			FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\Partition_2026.ndf', 
		) TO FILEGROUP FG_2026

		ALTER DATABASE YourDatabaseName ADD FILE 
		(
			NAME = 'Partition_2027', -- Logical Name
			FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL17.SQLEXPRESS\MSSQL\DATA\Partition_2027.ndf', 
		) TO FILEGROUP FG_2027

	-- Query to check the newly created Data Files
		SELECT
			fg.name AS FilegroupName,
			mf.name AS LogicalFileName,
			mf.physical_name AS PhysicalFilePath,
			mf.size / 128 AS SizeInMB
		FROM
			sys.filegroups fg
		JOIN
			sys.master_files mf ON fg.data_space_id = mf.data_space_id
		WHERE
			mf.database_id = DB_ID('SalesDB');
	
	-- STEP 4:
	-- Creating Partition Scheme: A partition scheme maps the partitions defined by the partition function to specific filegroups, 
		-- allowing you to control where each partition's data is stored.

		-- Syntax:
			CREATE PARTITION SCHEME PartitionSchemeByYear
			AS PARTITION PartitionByYear TO (FG_2024, FG_2025, FG_2026, FG_2027)
	
	-- Query to list all Partition Scheme
		SELECT
			ps.name AS PartitionSchemeName,
			pf.name AS PartitionFunctionName,
			ds.destination_id AS PartitionNumber,
			fg.name AS FilegroupName
		FROM sys.partition_schemes ps
		JOIN sys.partition_functions pf ON ps.function_id = pf.function_id
		JOIN sys.destination_data_spaces ds ON ps.data_space_id = ds.partition_scheme_id
		JOIN sys.filegroups fg ON ds.data_space_id = fg.data_space_id

	-- STEP 5:
	-- Creating a PARTITIONED Table
		CREATE TABLE Sales.Orders_Partitioned
		(
			OrderID INT PRIMARY KEY,
			CustomerID INT,
			OrderDate DATE,
			TotalAmount DECIMAL(10, 2)
		)
		ON PartitionSchemeByYear (OrderDate)

	-- STEP 6:
	-- Inserting Data into Partitioned Table
		INSERT INTO Sales.Orders_Partitioned (OrderID, CustomerID, OrderDate, TotalAmount)
		VALUES (1, 101, '2024-05-15', 250.00),
			   (2, 102, '2025-07-20', 150.00),
			   (3, 103, '2026-09-10', 300.00),
			   (4, 104, '2027-11-25', 400.00)
	-- Check in which partition the data is inserted
		SELECT
			p.partition_number AS PartitionNumber,
			f.name AS PartitionFilegroup,
			p.rows AS NumberOfRows
		FROM sys.partitions p
		JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
		JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
		WHERE OBJECT_NAME(p.object_id) = 'Orders_Partitioned';
-----------------------------------------------------------------------------------------------------------------------------------
/* ==============================================================================
   30x SQL Performance Tips
-------------------------------------------------------------------------------
   This section demonstrates best practices for fetching data, filtering,
   joins, UNION, aggregations, subqueries/CTE, DDL, and indexing.
   It covers techniques such as selecting only necessary columns,
   proper filtering methods, explicit joins, avoiding redundant logic,
   and efficient indexing strategies.
   
   Table of Contents:
     1. FETCHING DATA
     2. FILTERING
     3. JOINS
     4. UNION
     5. AGGREGATIONS
     6. SUBQUERIES, CTE
     7. DDL
     8. INDEXING
===============================================================================
*/

-- ###############################################################
-- #                        FETCHING DATA                        #
-- ###############################################################

-- ============================================
-- Tip 1: Select Only What You Need
-- ============================================

-- Bad Practice
SELECT * FROM Sales.Customers

-- Good Practice
SELECT CustomerID, FirstName, LastName FROM Sales.Customers

-- ============================================
-- Tip 2: Avoid unnecessary DISTINCT & ORDER BY
-- ============================================

-- Bad Practice
SELECT DISTINCT 
	FirstName 
FROM Sales.Customers 
ORDER BY FirstName

-- Good Practice
SELECT 
	FirstName 
FROM Sales.Customers

-- ============================================
-- Tip 3: For Exploration Purpose, Limit Rows!
-- ============================================

-- Bad Practice
SELECT 
	OrderID,
	Sales 
FROM Sales.Orders

-- Good Practice
SELECT TOP 10 
	OrderID,
	Sales 
FROM Sales.Orders

-- ###########################################################
-- #                        FILTERING                        #
-- ###########################################################

/* ==============================================================================
   Tip 4: Create nonclustered Index on frequently used Columns in WHERE clause
===============================================================================*/

SELECT *
FROM Sales.Orders
WHERE OrderStatus = 'Delivered';

CREATE NONCLUSTERED INDEX Idx_Orders_OrderStatus ON Sales.Orders(OrderStatus)

/* ==============================================================================
   Tip 5: Avoid applying functions to columns in WHERE clauses
===============================================================================*/

-- Bad Practice
SELECT * FROM Sales.Orders 
WHERE LOWER(OrderStatus) = 'delivered'

-- Good Practice
SELECT * FROM Sales.Orders 
WHERE OrderStatus = 'Delivered'
---------------------------------------------------------
-- Bad Practice
SELECT * 
FROM Sales.Customers
WHERE SUBSTRING(FirstName, 1, 1) = 'A'

-- Good Practice
SELECT * 
FROM Sales.Customers
WHERE FirstName LIKE 'A%'
---------------------------------------------------------
-- Bad Practice
SELECT * 
FROM Sales.Orders 
WHERE YEAR(OrderDate) = 2025

-- Good Practice
SELECT * 
FROM Sales.Orders 
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-12-31'

/* ==============================================================================
   Tip 6: Avoid leading wildcards as they prevent index usage
===============================================================================*/

-- Bad Practice
SELECT * 
FROM Sales.Customers 
WHERE LastName LIKE '%Gold%'

-- Good Practice
SELECT * 
FROM Sales.Customers 
WHERE LastName LIKE 'Gold%'

/* ==============================================================================
   Tip 7: Use IN instead of Multiple OR
===============================================================================*/

-- Bad Practice
SELECT * 
FROM Sales.Orders
WHERE CustomerID = 1 OR CustomerID = 2 OR CustomerID = 3

-- Good Practice
SELECT * 
FROM Sales.Orders
WHERE CustomerID IN (1, 2, 3)

-- #######################################################
-- #                        JOINS                        #
-- #######################################################

/* ==============================================================================
   Tip 8: Understand The Speed of Joins & Use INNER JOIN when possible
===============================================================================*/

-- Best Performance
SELECT c.FirstName, o.OrderID FROM Sales.Customers c INNER JOIN Sales.Orders o ON c.CustomerID = o.CustomerID

-- Slightly Slower Performance
SELECT c.FirstName, o.OrderID FROM Sales.Customers c RIGHT JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
SELECT c.FirstName, o.OrderID FROM Sales.Customers c LEFT JOIN Sales.Orders o ON c.CustomerID = o.CustomerID

-- Worst Performance
SELECT c.FirstName, o.OrderID FROM Sales.Customers c OUTER JOIN Sales.Orders o ON c.CustomerID = o.CustomerID

/* ==============================================================================
   Tip 9: Use Explicit Join (ANSI Join) Instead of Implicit Join (non-ANSI Join)
===============================================================================*/

-- Bad Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers c, Sales.Orders o
WHERE c.CustomerID = o.CustomerID

-- Good Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID;

--For simple queries: There is no measurable performance difference if both ANSI and non-ANSI queries are correctly written.
--For complex queries: ANSI joins are usually easier to optimize and debug because their structure makes the intent of the query clearer.

/* ==============================================================================
   Tip 10: Make sure to Index the columns used in the ON clause
===============================================================================*/

SELECT c.FirstName, o.OrderID
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
    ON c.CustomerID = o.CustomerID;

CREATE NONCLUSTERED INDEX IX_Orders_CustomerID ON Sales.Orders(CustomerID)

/* ==============================================================================
   Tip 11: Filter Before Joining (Big Tables)
===============================================================================*/

-- Best Practice For Small-Medium Tables
-- Filter After Join (WHERE)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Delivered';

-- Filter During Join (ON)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
   AND o.OrderStatus = 'Delivered';

-- Best Practice For Big Tables
-- Filter Before Join (SUBQUERY)
SELECT c.FirstName, o.OrderID
FROM Sales.Customers AS c
INNER JOIN (
    SELECT OrderID, CustomerID
    FROM Sales.Orders
    WHERE OrderStatus = 'Delivered'
) AS o
    ON c.CustomerID = o.CustomerID;

/* ==============================================================================
   Tip 12: Aggregate Before Joining (Big Tables)
===============================================================================*/

-- Best Practice For Small-Medium Tables
-- Grouping and Joining
SELECT c.CustomerID, c.FirstName, COUNT(o.OrderID) AS OrderCount
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName;

-- Best Practice For Big Tables
-- Pre-aggregated Subquery
SELECT c.CustomerID, c.FirstName, o.OrderCount
FROM Sales.Customers AS c
INNER JOIN (
    SELECT CustomerID, COUNT(OrderID) AS OrderCount
    FROM Sales.Orders
    GROUP BY CustomerID
) AS o
    ON c.CustomerID = o.CustomerID;

-- Bad Practice
-- Correlated Subquery
SELECT 
    c.CustomerID, 
    c.FirstName,
    (SELECT COUNT(o.OrderID)
     FROM Sales.Orders AS o
     WHERE o.CustomerID = c.CustomerID) AS OrderCount
FROM Sales.Customers AS c;

/* ==============================================================================
   Tip 13: Use Union Instead of OR in Joins
===============================================================================*/

-- Bad Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
    OR c.CustomerID = o.SalesPersonID;

-- Best Practice
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
UNION
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.SalesPersonID;

/* ==============================================================================
   Tip 14: Check for Nested Loops and Use SQL HINTS
===============================================================================*/

SELECT o.OrderID, c.FirstName
FROM Sales.Customers c
INNER JOIN Sales.Orders o 
ON c.CustomerID = o.CustomerID

-- Good Practice for Having Big Table & Small Table
SELECT o.OrderID, c.FirstName
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON c.CustomerID = o.CustomerID
OPTION (HASH JOIN);

-- ################################################################
-- #                           UNION                              #
-- ################################################################

/* ==============================================================================
   Tip 15: Use UNION ALL instead of using UNION | duplicates are acceptable
===============================================================================*/

-- Bad Practice
SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive 

-- Best Practice
SELECT CustomerID FROM Sales.Orders
UNION ALL
SELECT CustomerID FROM Sales.OrdersArchive 

/* =======================================================================================
   Tip 16: Use UNION ALL + Distinct instead of using UNION | duplicates are not acceptable
========================================================================================*/

-- Bad Practice
SELECT CustomerID FROM Sales.Orders
UNION
SELECT CustomerID FROM Sales.OrdersArchive 

-- Best Practice
SELECT DISTINCT CustomerID
FROM (
    SELECT CustomerID FROM Sales.Orders
    UNION ALL
    SELECT CustomerID FROM Sales.OrdersArchive
) AS CombinedData


-- ##########################################################
-- #                     AGGREGATIONS                       #
-- ##########################################################

/* ==============================================================================
   Tip 17: Use Columnstore Index for Aggregations on Large Table
===============================================================================*/

SELECT CustomerID, COUNT(OrderID) AS OrderCount
FROM Sales.Orders 
GROUP BY CustomerID

CREATE CLUSTERED COLUMNSTORE INDEX Idx_Orders_Columnstore ON Sales.Orders

/* ==============================================================================
   Tip 18: Pre-Aggregate Data and store it in new Table for Reporting
===============================================================================*/

SELECT MONTH(OrderDate) OrderYear, SUM(Sales) AS TotalSales
INTO Sales.SalesSummary
FROM Sales.Orders
GROUP BY MONTH(OrderDate)

SELECT OrderYear, TotalSales FROM Sales.SalesSummary


-- ##############################################################
-- #                       SUBQUERIES, CTE                      #
-- ##############################################################

/* ==============================================================================
   Tip 19: JOIN vs EXISTS vs IN (Avoid using IN)
===============================================================================*/

-- JOIN (Best Practice: If the Performance equals to EXISTS)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
INNER JOIN Sales.Customers AS c
    ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA';

-- EXISTS (Best Practice: Use it for Large Tables)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
WHERE EXISTS (
    SELECT 1
    FROM Sales.Customers AS c
    WHERE c.CustomerID = o.CustomerID
      AND c.Country = 'USA'
);

-- IN (Bad Practice)
SELECT o.OrderID, o.Sales
FROM Sales.Orders AS o
WHERE o.CustomerID IN (
    SELECT CustomerID
    FROM Sales.Customers
    WHERE Country = 'USA'
);

/* ==============================================================================
   Tip 20: Avoid Redundant Logic in Your Query
===============================================================================*/

-- Bad Practice
SELECT EmployeeID, FirstName, 'Above Average' AS Status
FROM Sales.Employees
WHERE Salary > (SELECT AVG(Salary) FROM Sales.Employees)
UNION ALL
SELECT EmployeeID, FirstName, 'Below Average' AS Status
FROM Sales.Employees
WHERE Salary < (SELECT AVG(Salary) FROM Sales.Employees);

-- Good Practice
SELECT 
    EmployeeID, 
    FirstName, 
    CASE 
        WHEN Salary > AVG(Salary) OVER () THEN 'Above Average'
        WHEN Salary < AVG(Salary) OVER () THEN 'Below Average'
        ELSE 'Average'
    END AS Status
FROM Sales.Employees;

-- ##############################################################
-- #                             DDL                            #
-- ##############################################################
/*
=============================================================================
Tip 21: Avoid VARCHAR Data Type If Possible
=============================================================================
Tip 22: Avoid Using MAX or Overly Large Lengths
=============================================================================
Tip 23: Use NOT NULL If possible 
=============================================================================
Tip 24: Make sure all tables have a CLUSTERED PRIMARY KEY
=============================================================================
Tip 25: Create Nonclustered Index on Foreign Key if they are frequently used
=============================================================================
*/
-- Bad Practice 
CREATE TABLE CustomersInfo (
    CustomerID INT,
    FirstName VARCHAR(MAX),
    LastName TEXT,
    Country VARCHAR(255),
    TotalPurchases FLOAT, 
    Score VARCHAR(255),
    BirthDate VARCHAR(255),
    EmployeeID INT,
    CONSTRAINT FK_Bad_Customers_EmployeeID FOREIGN KEY (EmployeeID)
        REFERENCES Sales.Employees(EmployeeID)
);

-- Good Practice Practice 
CREATE TABLE CustomersInfo (
    CustomerID INT PRIMARY KEY CLUSTERED,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    TotalPurchases FLOAT,
    Score INT,
    BirthDate DATE,
    EmployeeID INT,
    CONSTRAINT FK_CustomersInfo_EmployeeID FOREIGN KEY (EmployeeID)
        REFERENCES Sales.Employees(EmployeeID)
);
CREATE NONCLUSTERED INDEX IX_CustomersInfo_EmployeeID
ON CustomersInfo(EmployeeID);

-- ##############################################################
-- #                        INDEXING                            #
-- ##############################################################
/*
=================================================================================================================================
Tip 26: Avoid Over Indexing, as it can slow down insert, update, and delete operations
=================================================================================================================================
Tip 27: Regularly review and drop unused indexes to save space and improve write performance
=================================================================================================================================
Tip 28: Update table statistics weekly to ensure the query optimizer has the most up-to-date information
=================================================================================================================================
Tip 29: Reorganize and rebuild fragmented indexes weekly to maintain query performance.
=================================================================================================================================
Tip 30: For large tables (e.g., fact tables), partition the data and then apply a columnstore index for best performance results
=================================================================================================================================
*/

/* ==============================================================================
   SQL AI Prompts for SQL
-------------------------------------------------------------------------------
   This script contains a series of prompts designed to help both SQL developers 
   and anyone interested in learning SQL improve their skills in writing, 
   optimizing, and understanding SQL queries. The prompts cover a variety of 
   topics, including solving SQL tasks, enhancing query readability, performance 
   optimization, debugging, and interview/exam preparation. Each section provides 
   clear instructions and sample code to facilitate self-learning and practical 
   application in real-world scenarios.

   Table of Contents:
     1. Solve an SQL Task
     2. Improve the Readability
     3. Optimize the Performance Query
     4. Optimize Execution Plan
     5. Debugging
     6. Explain the Result
     7. Styling & Formatting
     8. Documentations & Comments
     9. Improve Database DDL
    10. Generate Test Dataset
    11. Create SQL Course
    12. Understand SQL Concept
    13. Comparing SQL Concepts
    14. SQL Questions with Options
    15. Prepare for a SQL Interview
    16. Prepare for a SQL Exam
=================================================================================
*/

/* ==============================================================================
   1. Solve an SQL Task
=================================================================================

In my SQL Server database, we have two tables:
The first table is `orders` with the following columns: order_id, sales, customer_id, product_id.
The second table is `customers` with the following columns: customer_id, first_name, last_name, country.
Do the following:
	- Write a query to rank customers based on their sales.
	- The result should include the customer's customer_id, full name, country, total sales, and their rank.
	- Include comments but avoid commenting on obvious parts.
	- Write three different versions of the query to achieve this task.
	- Evaluate and explain which version is best in terms of readability and performance
*/

/* ==============================================================================
   2. Improve the Readability
=================================================================================

The following SQL Server query is long and hard to understand. 
Do the following:
	- Improve its readability.
	- Remove any redundancy in the query and consolidate it.
	- Include comments but avoid commenting on obvious parts.	
	- Explain each improvement to understand the reasoning behind it.
*/
-- Bad Formated Query
WITH CTE_Total_Sales_By_Customer AS (
    SELECT 
        c.CustomerID, 
        c.FirstName + ' ' + c.LastName AS FullName,  SUM(o.Sales) AS TotalSales
    FROM  Sales.Customers c
    INNER JOIN 
        Sales.Orders o ON c.CustomerID = o.CustomerID GROUP BY  c.CustomerID, c.FirstName, c.LastName
),CTE_Highest_Order_Product AS (
    SELECT 
        o.CustomerID, 
        p.Product, ROW_NUMBER() OVER (PARTITION BY o.CustomerID ORDER BY o.Sales DESC) AS rn
    FROM Sales.Orders o
    INNER JOIN Sales.Products p ON o.ProductID = p.ProductID
),
CTE_Highest_Category AS (  SELECT 
        o.CustomerID,  p.Category, 
        ROW_NUMBER() OVER (PARTITION BY o.CustomerID ORDER BY SUM(o.Sales) DESC) AS rn
    FROM Sales.Orders o
    INNER JOIN Sales.Products p ON o.ProductID = p.ProductID GROUP BY  o.CustomerID, p.Category
),
CTE_Last_Order_Date AS (
    SELECT 
        CustomerID, 
        MAX(OrderDate) AS LastOrderDate
    FROM  Sales.Orders
    GROUP BY CustomerID
),
CTE_Total_Discounts_By_Customer AS (
    SELECT o.CustomerID,  SUM(o.Quantity * p.Price * 0.1) AS TotalDiscounts
    FROM  Sales.Orders o INNER JOIN Sales.Products p ON o.ProductID = p.ProductID
    GROUP BY o.CustomerID
)
SELECT 
    ts.CustomerID, ts.FullName,
    ts.TotalSales,hop.Product AS HighestOrderProduct,hc.Category AS HighestCategory,
    lod.LastOrderDate,
    td.TotalDiscounts
FROM CTE_Total_Sales_By_Customer ts
LEFT JOIN (SELECT CustomerID, Product FROM CTE_Highest_Order_Product WHERE rn = 1) hop ON ts.CustomerID = hop.CustomerID
LEFT JOIN (SELECT CustomerID, Category FROM CTE_Highest_Category WHERE rn = 1) hc ON ts.CustomerID = hc.CustomerID
LEFT JOIN CTE_Last_Order_Date lod ON ts.CustomerID = lod.CustomerID
LEFT JOIN  CTE_Total_Discounts_By_Customer td ON ts.CustomerID = td.CustomerID
WHERE  ts.TotalSales > 0
ORDER BY  ts.TotalSales DESC


/* ===========================================================================
   3. Optimize the Performance Query
============================================================================== 

The following SQL Server query is slow. 
Do the following:
	- Propose optimizations to improve its performance.
	- Provide the improved SQL query.
	- Explain each improvement to understand the reasoning behind it.
*/
-- Query with Bar Performance
SELECT 
    o.OrderID,
    o.CustomerID,
    c.FirstName AS CustomerFirstName,
    (SELECT COUNT(o2.OrderID)
     FROM Sales.Orders o2
     WHERE o2.CustomerID = c.CustomerID) AS OrderCount
FROM 
    Sales.Orders o
LEFT JOIN 
    Sales.Customers c ON o.CustomerID = c.CustomerID
WHERE 
    LOWER(o.OrderStatus) = 'delivered'
    OR YEAR(o.OrderDate) = 2025
    OR o.CustomerID =1 OR o.CustomerID =2 OR o.CustomerID =3
    OR o.CustomerID IN (
        SELECT CustomerID
        FROM Sales.Customers
        WHERE Country LIKE '%USA%'
    )
	
/* ===========================================================================
   4. Optimize Execution Plan
============================================================================== 

The image is the execution plan of SQL Server query.
Do the following:
	- Describe the execution plan step by step.
	- Identify performance bottlenecks and issues.
	- Suggest ways to improve performance and optimize the execution plan.
*/

/* ===========================================================================
   5. Debugging
==============================================================================

The following SQL Server Query causing this error: "Msg 8120, Level 16, State 1, Line 5"
Do the following: 
	- Explain the error massage.
	- Find the root cause of the issue.
	- Suggest how to fix it.
*/

SELECT 
    C.CustomerID,
    C.Country,
    SUM(O.Sales) AS TotalSales,
    RANK() OVER (PARTITION BY C.Country ORDER BY O.Sales DESC) AS RankInCountry
FROM Sales.Customers C
LEFT JOIN Sales.Orders O 
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.Country

/* ===========================================================================
   6. Explain the Result
============================================================================== 

I didn't understand the result of the following SQL Server query.
Do the following:
	- Break down how SQL processes the query step by step.
	- Explaining each stage and how the result is formed.
*/
WITH Series AS (
	-- Anchor Query
	SELECT
	1 AS MyNumber
	UNION ALL
	-- Recursive Query
	SELECT
	MyNumber + 1
	FROM Series
	WHERE MyNumber < 20
)
-- Main Query
SELECT *
FROM Series

/* ===========================================================================
   7. Styling & Formatting
============================================================================== 

The following SQL Server query hard to understand. 
Do the following:
	Restyle the code to make it easier to read.
	Align column aliases.
	Keep it compact - do not introduce unnecessary new lines.	
	Ensure the formatting follows best practices.
*/
-- Bad Styled Query
with CTE_Total_Sales as 
(Select 
CustomerID, sum(Sales) as TotalSales 
from Sales.Orders 
group by CustomerID),
cte_customer_segments as 
(SELECT CustomerID, 
case when TotalSales > 100 then 'High Value' 
when TotalSales between 50 and 100 then 'Medium Value' 
else 'Low Value' end as CustomerSegment 
from CTE_Total_Sales)
select c.CustomerID, c.FirstName, c.LastName, 
cts.TotalSales, ccs.CustomerSegment 
FROM sales.customers c 
left join CTE_Total_Sales cts 
ON cts.CustomerID = c.CustomerID 
left JOIN cte_customer_segments ccs ON ccs.CustomerID = c.CustomerID

/* ===========================================================================
   8. Documentations & Comments
==============================================================================

The following SQL Server query lacks comments and documentation.
Do the following:
	Insert a leading comment at the start of the query describing its overall purpose.
	Add comments only where clarification is necessary, avoiding obvious statements.
	Create a separate document explaining the business rules implemented by the query.	
	Create another separate document describing how the query works.
*/

WITH CTE_Total_Sales AS 
(
SELECT 
    CustomerID,
    SUM(Sales) AS TotalSales
FROM Sales.Orders 
GROUP BY CustomerID
),
CTE_Customer_Segements AS (
SELECT 
	CustomerID,
	CASE 
		WHEN TotalSales > 100 THEN 'High Value'
		WHEN TotalSales BETWEEN 50 AND 100 THEN 'Medium Value'
		ELSE 'Low Value'
	END CustomerSegment
FROM CTE_Total_Sales
)

SELECT 
c.CustomerID, 
c.FirstName,
c.LastName,
cts.TotalSales,
ccs.CustomerSegment
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segements ccs
ON ccs.CustomerID = c.CustomerID 

/* ===========================================================================
   9. Improve Database DDL
============================================================================== 
The following SQL Server DDL Script has to be optimized.
Do the following:
	- Naming: Check the consistency of table/column names, prefixes, standards.
	- Data Types: Ensure data types are appropriate and optimized.
	- Integrity: Verify the integrity of primary keys and foreign keys.	
	- Indexes: Check that indexes are sufficient and avoid redundancy.
	- Normalization: Ensure proper normalization and avoid redundancy.

==============================================================================
   10. Generate Test Dataset
==============================================================================

I need dataset for testing the following SQL Server DDL 
Do the following:
	- Generate test dataset as Insert statements.
	- Dataset should be realstic.
	- Keep the dataset small.	
	- Ensure all primary/foreign key relationships are valid (use matching IDs).
	- Dont introduce any Null values.

==============================================================================
   11. Create SQL Course
============================================================================== 

Create a comprehensive SQL course with a detailed roadmap and agenda.
Do the following:
	- Start with SQL fundamentals and advance to complex topics.
	- Make it beginner-friendly.
	- Include topics relevant to data analytics.	
	- Focus on real-world data analytics use cases and scenarios.

==============================================================================
   12. Understand SQL Concept
==============================================================================

I want detailed explanation about SQL Window Functions.
Do the following:
	- Explain what Window Functions are.
	- Give an analogy.
	- Describe why we need them and when to use them.	
	- Explain the syntax.
	- Provide simple examples.
	- List the top 3 use cases.

==============================================================================
   13. Comparing SQL Concepts
============================================================================== 

I want to understand the differences between SQL Windows and GROUP BY.
Do the following:
	- Explain the key differences between the two concepts.
	- Describe when to use each concept, with examples.
	- Provide the pros and cons of each concept.	
	- Summarize the comparison in a clear side-by-side table.

==============================================================================
   14. SQL Questions with Options
==============================================================================

Act as an SQL trainer and help me practice SQL Window Functions.
Do the following:
	- Make it interactive Practicing, you provide task and give solution.
	- Provide a sample dataset.
	- Give SQL tasks that gradually increase in difficulty.	
	- Act as an SQL Server and show the results of my queries.
	- Review my queries, provide feedback, and suggest improvements.

==============================================================================
   15. Prepare for a SQL Interview
==============================================================================

Act as Interviewer and prepare me for a SQL interview.
Do the following:
	- Ask common SQL interview questions.
	- Make it interactive Practicing, you provide question and give answer.
	- Gradually progress to advanced topics.
	- Evaluate my answer and give me a feedback.	

==============================================================================
   16. Prepare for a SQL Exam
==============================================================================

Prepare me for a SQL exam
Do the following:
	- Ask common SQL interview questions.
	- Make it interactive Practicing, you provide question and give answer.
	- Gradually progress to advanced topics.
	- Evaluate my answer and give me a feedback.

==============================================================================
   17. Solve an SQL Problem
==============================================================================

You are a SQL Server tutor. Focus on simple and clear explanations.

Provide the following:
1) The easiest correct SQL solution
2) Step-by-step explanation of how to think
3) Why each clause is used (SELECT, JOIN, WHERE, GROUP BY, etc.)
4) How to recognize this type of problem in the future

============================================================================== */