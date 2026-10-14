USE PRODUCT_SALES_MANAGEMENT_SYSTEM;
GO

-- ============================================================
-- DML
-- Data Manipulation Language and SELECT exercises.
-- Based on the Product Sales Management exercises from the textbook.
-- ============================================================

-- ============================================================
-- PART III - DML EXERCISES
-- ============================================================
-- Question 1
-- Display the products (ProductID, ProductName)
-- manufactured in China.

SELECT ProductID,ProductName
	FROM PRODUCTS
	WHERE CountryOfOrigin=N'Trung Quốc';
GO


-- Question 2
-- Display the products (ProductID, ProductName)
-- whose units are 'Cây' or 'Quyển'.

SELECT ProductID,ProductName,Unit
	FROM PRODUCTS
	WHERE Unit IN(N'Cây','quyen');
GO


-- Question 3
-- Display the products (ProductID, ProductName)
-- whose product ID starts with 'B' and ends with '01'.

SELECT ProductID,ProductName
	FROM PRODUCTS
	WHERE ProductID LIKE 'B%01';
GO


-- Question 4
-- Display the products (ProductID, ProductName)
-- manufactured in China with prices from 30,000 to 40,000 VND.

SELECT ProductID,ProductName
	FROM PRODUCTS
	WHERE CountryOfOrigin=N'Trung Quốc' AND
		Price BETWEEN 30000 AND 40000;
GO


-- Question 5
-- Display the products (ProductID, ProductName) manufactured in China
-- or Thailand with prices from 30,000 to 40,000 VND.

SELECT ProductID,ProductName,CountryOfOrigin,Price
	FROM PRODUCTS
	WHERE (CountryOfOrigin=N'Trung Quốc' OR CountryOfOrigin='Thai Lan') AND
		Price BETWEEN 30000 AND 40000;
GO


-- Question 6
-- Display the invoice IDs and total amounts of invoices
-- issued on January 1, 2007 and January 2, 2007.

SELECT InvoiceID,TotalAmount
	FROM INVOICES
	WHERE InvoiceDate IN('2007-01-01','2007-01-02');
GO


-- Question 7
-- Display the invoice IDs and total amounts for January 2007,
-- sorted by invoice date ascending and total amount descending.

SELECT InvoiceID,TotalAmount
	FROM INVOICES
	WHERE MONTH(InvoiceDate)=1 AND YEAR(InvoiceDate)=2007
	ORDER BY InvoiceDate ASC, TotalAmount DESC;
GO


-- Question 8
-- Display the customers (CustomerID, FullName) who made a purchase
-- on January 1, 2007.

SELECT kh.CustomerID,FullName
	FROM CUSTOMERS kh
	JOIN INVOICES hd ON kh.CustomerID=hd.CustomerID
	WHERE InvoiceDate='2007-01-01';
GO


-- Question 9
-- Display the invoice IDs and total amounts of invoices issued
-- by the employee named 'Nguyen Van B' on October 28, 2006.

SELECT InvoiceID,TotalAmount
	FROM INVOICES hd
	JOIN EMPLOYEES nv ON hd.EmployeeID=nv.EmployeeID
	WHERE FullName='Nguyen Van B' AND
		InvoiceDate='2006-10-28';
GO


-- Question 10
-- Display the products (ProductID, ProductName) purchased
-- by the customer named 'Nguyen Van A' in October 2006.

SELECT sp.ProductID,sp.ProductName
	FROM CUSTOMERS kh
	JOIN INVOICES hd ON kh.CustomerID=hd.CustomerID
	JOIN INVOICE_DETAILS ct ON hd.InvoiceID=ct.InvoiceID
	JOIN PRODUCTS sp ON ct.ProductID=sp.ProductID
	WHERE kh.FullName='Nguyen Van A' AND
		MONTH(hd.InvoiceDate)=10 AND
		YEAR(hd.InvoiceDate)=2006;
GO


-- Question 11
-- Find the invoice IDs that purchased product 'BB01' or 'BB02'.

SELECT InvoiceID,ct.ProductID
	FROM INVOICE_DETAILS ct
	JOIN PRODUCTS sp ON ct.ProductID=sp.ProductID
	WHERE ct.ProductID IN('BB01','BB02');
GO


-- Question 12
-- Find the invoice IDs that purchased product 'BB01' or 'BB02',
-- with a quantity from 10 to 20 for each product.

SELECT InvoiceID,ct.ProductID
	FROM INVOICE_DETAILS ct
	JOIN PRODUCTS sp ON ct.ProductID=sp.ProductID
	WHERE ct.ProductID IN('BB01','BB02') AND
			Quantity BETWEEN 10 AND 20;
GO


-- Question 13
-- Find the invoice IDs that purchased both products 'BB01' and 'BB02',
-- with a quantity from 10 to 20 for each product.

SELECT InvoiceID
	FROM INVOICE_DETAILS
	WHERE ProductID='BB01' AND Quantity BETWEEN 10 AND 20

INTERSECT

SELECT InvoiceID
	FROM INVOICE_DETAILS
	WHERE ProductID='BB02' AND Quantity BETWEEN 10 AND 20;
GO


-- Question 14
-- Display the products (ProductID, ProductName)
-- manufactured in China or sold on January 1, 2007.

SELECT ProductID,ProductName
	FROM PRODUCTS
	WHERE CountryOfOrigin=N'Trung Quốc'

UNION

SELECT sp.ProductID,sp.ProductName
	FROM INVOICES hd
	JOIN INVOICE_DETAILS ct ON hd.InvoiceID=ct.InvoiceID
	JOIN PRODUCTS sp ON ct.ProductID=sp.ProductID
	WHERE InvoiceDate='2007-01-01';
GO


-- Question 15
-- Display the products (ProductID, ProductName)
-- that have never been sold.

SELECT sp.ProductID,sp.ProductName
	FROM PRODUCTS sp
	WHERE NOT EXISTS
	(
		SELECT 1
		FROM INVOICE_DETAILS ct
		WHERE sp.ProductID=ct.ProductID
	);
GO


-- Question 16
-- Display the products (ProductID, ProductName)
-- that were not sold in 2006.

SELECT sp.ProductID,sp.ProductName
	FROM PRODUCTS sp
	WHERE NOT EXISTS
	(
		SELECT 1
		FROM INVOICE_DETAILS ct
		JOIN INVOICES hd ON ct.InvoiceID=hd.InvoiceID
		WHERE sp.ProductID=ct.ProductID AND
				YEAR(hd.InvoiceDate)=2006
	);
GO


-- Question 17
-- Display the products (ProductID, ProductName) manufactured in China
-- that were not sold in 2006.

SELECT sp.ProductID,sp.ProductName
	FROM PRODUCTS sp
	WHERE NOT EXISTS
	(
		SELECT 1
		FROM INVOICE_DETAILS ct
		JOIN INVOICES hd ON ct.InvoiceID=hd.InvoiceID
		WHERE sp.ProductID=ct.ProductID AND
				YEAR(InvoiceDate)=2006
	) AND
	CountryOfOrigin=N'Trung Quốc';
GO


-- Question 18
-- Find the invoice IDs that purchased all products
-- manufactured in Singapore.

SELECT InvoiceID
	FROM INVOICE_DETAILS ct
	JOIN PRODUCTS sp ON ct.ProductID=sp.ProductID
	WHERE CountryOfOrigin='Singapore'
	GROUP BY InvoiceID
	HAVING COUNT(DISTINCT sp.ProductID)=
	(
		SELECT COUNT(*)
		FROM PRODUCTS
		WHERE CountryOfOrigin='Singapore'
	);
GO


-- Question 19
-- Find the invoice IDs in 2006 that purchased at least all products
-- manufactured in Singapore.

SELECT ct.InvoiceID
	FROM INVOICE_DETAILS ct
	JOIN INVOICES hd ON ct.InvoiceID=hd.InvoiceID
	JOIN PRODUCTS sp ON ct.ProductID=sp.ProductID
	WHERE YEAR(InvoiceDate)=2006 AND
			CountryOfOrigin='Singapore'
	GROUP BY ct.InvoiceID
	HAVING COUNT(DISTINCT sp.ProductID)=
	(
		SELECT COUNT(*)
		FROM PRODUCTS
		WHERE CountryOfOrigin='Singapore'
	);
GO


-- Question 20
-- Count the invoices purchased by non-member customers.

SELECT COUNT(*) AS NON_MEMBER_INVOICES
	FROM INVOICES
	WHERE CustomerID IS NULL;
GO


-- Question 21
-- Count the distinct products sold in 2006.

SELECT COUNT(DISTINCT ProductID) AS DISTINCT_PRODUCTS_SOLD_2006
	FROM INVOICE_DETAILS ct
	JOIN INVOICES hd ON ct.InvoiceID=hd.InvoiceID
	WHERE YEAR(InvoiceDate)=2006;
GO


-- Question 22
-- Find the highest and lowest invoice total amounts.

SELECT MAX(TotalAmount) AS HIGHEST_AMOUNT,MIN(TotalAmount) AS LOWEST_AMOUNT
	FROM INVOICES;
GO


-- Question 23
-- Find the average invoice total amount for invoices issued in 2006.

SELECT AVG(TotalAmount) AS AVERAGE_AMOUNT
	FROM INVOICES
	WHERE YEAR(InvoiceDate)=2006;
GO


-- Question 24
-- Calculate the total sales revenue in 2006.

SELECT SUM(TotalAmount) AS SALES_REVENUE_2006
	FROM INVOICES
	WHERE YEAR(InvoiceDate)=2006;
GO


-- Question 25
-- Find the invoice ID(s) with the highest total amount in 2006.

SELECT InvoiceID
	FROM INVOICES
	WHERE YEAR(InvoiceDate)=2006 AND
	TotalAmount=
	(
		SELECT MAX(TotalAmount)
		FROM INVOICES
		WHERE YEAR(InvoiceDate)=2006
	);
GO


-- Question 26
-- Find the customer(s) who purchased the invoice(s)
-- with the highest total amount in 2006.

SELECT kh.CustomerID,kh.FullName
	FROM CUSTOMERS kh
	JOIN INVOICES ct ON kh.CustomerID=ct.CustomerID
	WHERE YEAR(InvoiceDate)=2006 AND
			TotalAmount=
			(
				SELECT MAX(TotalAmount)
				FROM INVOICES
				WHERE YEAR(InvoiceDate)=2006
			);
GO


-- Question 27
-- Display the top 3 customers (CustomerID, FullName) by sales amount.

SELECT TOP 3 CustomerID,FullName,SalesAmount
	FROM CUSTOMERS
	ORDER BY SalesAmount DESC;
GO


-- Question 28
-- Display the products (ProductID, ProductName) whose prices
-- are among the three highest distinct prices.

SELECT ProductID,ProductName,Price
	FROM PRODUCTS
	WHERE Price IN
	(
		SELECT DISTINCT TOP 3 Price
		FROM PRODUCTS
		ORDER BY Price DESC
	);
GO


-- Question 29
-- Display the products (ProductID, ProductName) manufactured
-- in Thailand whose prices are among the three highest distinct
-- prices of all products.

SELECT ProductID,ProductName,Price
	FROM PRODUCTS
	WHERE CountryOfOrigin='Thai Lan' AND
			Price IN
			(
				SELECT DISTINCT TOP 3 Price
				FROM PRODUCTS
				ORDER BY Price DESC
			);
GO


-- Question 30
-- Display the products (ProductID, ProductName) manufactured in China
-- whose prices are among the three highest distinct prices
-- of products manufactured in China.

SELECT ProductID,ProductName,Price
	FROM PRODUCTS
	WHERE CountryOfOrigin=N'Trung Quốc' AND
			Price IN
			(
				SELECT DISTINCT TOP 3 Price
				FROM PRODUCTS
				WHERE CountryOfOrigin=N'Trung Quốc'
				ORDER BY Price DESC
			);
GO


-- Question 31
-- Display the top 3 customers by sales amount using ranking.

WITH CustomerRanking AS
(
	SELECT CustomerID,FullName,SalesAmount,
			DENSE_RANK() OVER (ORDER BY SalesAmount DESC) AS SalesRank
	FROM CUSTOMERS
)
SELECT *
	FROM CustomerRanking
	WHERE SalesRank<=3;
GO


-- Question 32
-- Count the total number of products manufactured in China.

SELECT COUNT(*) AS TOTAL_PRODUCTS_CHINA
	FROM PRODUCTS
	WHERE CountryOfOrigin=N'Trung Quốc';
GO


-- Question 33
-- Count the total number of products for each country of origin.

SELECT CountryOfOrigin,COUNT(*) AS TOTAL_PRODUCTS
	FROM PRODUCTS
	GROUP BY CountryOfOrigin;
GO


-- Question 34
-- For each country of origin, find the highest, lowest,
-- and average product price.

SELECT CountryOfOrigin,
		MAX(Price) AS HIGHEST_PRICE,
		MIN(Price) AS LOWEST_PRICE,
		AVG(Price) AS AVERAGE_PRICE
	FROM PRODUCTS
	GROUP BY CountryOfOrigin;
GO


-- Question 35
-- Calculate the sales revenue for each day.

SELECT InvoiceDate,SUM(TotalAmount) AS DAILY_REVENUE
	FROM INVOICES
	GROUP BY InvoiceDate;
GO


-- Question 36
-- Calculate the total quantity sold for each product in October 2006.

SELECT ct.ProductID,sp.ProductName,SUM(Quantity) AS TOTAL_QUANTITY_SOLD
	FROM INVOICE_DETAILS ct
	JOIN INVOICES hd ON ct.InvoiceID=hd.InvoiceID
	JOIN PRODUCTS sp ON ct.ProductID=sp.ProductID
	WHERE MONTH(InvoiceDate)=10 AND YEAR(InvoiceDate)=2006
	GROUP BY ct.ProductID,sp.ProductName;
GO


-- Question 37
-- Calculate the sales revenue for each month in 2006.

SELECT MONTH(InvoiceDate) AS MONTH_NUMBER,SUM(TotalAmount) AS MONTHLY_REVENUE
	FROM INVOICES
	WHERE YEAR(InvoiceDate)=2006
	GROUP BY MONTH(InvoiceDate);
GO


-- Question 38
-- Find invoices that purchased at least four distinct products.

SELECT InvoiceID
	FROM INVOICE_DETAILS
	GROUP BY InvoiceID
	HAVING COUNT(DISTINCT ProductID)>=4;
GO


-- Question 39
-- Find invoices that purchased three distinct products
-- manufactured in Vietnam.

SELECT InvoiceID
	FROM INVOICE_DETAILS ct
	JOIN PRODUCTS sp ON ct.ProductID=sp.ProductID
	WHERE CountryOfOrigin='Viet Nam'
	GROUP BY InvoiceID
	HAVING COUNT(DISTINCT ct.ProductID)=3;
GO


-- Question 40
-- Find the customer (CustomerID, FullName) with
-- the highest number of purchases.

WITH PurchaseCount AS
(
	SELECT CustomerID,COUNT(InvoiceID) AS PurchaseCount
	FROM INVOICES
	WHERE CustomerID IS NOT NULL
	GROUP BY CustomerID
)
SELECT kh.CustomerID,kh.FullName,sl.PurchaseCount
	FROM CUSTOMERS kh
	JOIN PurchaseCount sl ON kh.CustomerID=sl.CustomerID
	WHERE sl.PurchaseCount=
			(
				SELECT MAX(PurchaseCount)
				FROM PurchaseCount
			);
GO


-- Question 41
-- Find the month in 2006 with the highest sales revenue.

WITH MonthlyRevenue AS
(
	SELECT MONTH(InvoiceDate) AS MonthNumber,SUM(TotalAmount) AS TotalRevenue
		FROM INVOICES
		WHERE YEAR(InvoiceDate)=2006
		GROUP BY MONTH(InvoiceDate)
)
SELECT MonthNumber,TotalRevenue
	FROM MonthlyRevenue
	WHERE TotalRevenue=
			(
				SELECT MAX(TotalRevenue)
				FROM MonthlyRevenue
			);
GO


-- Question 42
-- Find the product (ProductID, ProductName) with
-- the lowest total quantity sold in 2006.

WITH ProductSales2006 AS
(
	SELECT ct.ProductID,SUM(Quantity) AS TotalQuantity
		FROM INVOICE_DETAILS ct
		JOIN INVOICES hd ON ct.InvoiceID=hd.InvoiceID
		WHERE YEAR(hd.InvoiceDate)=2006
		GROUP BY ct.ProductID
)
SELECT sp.ProductID,sp.ProductName,t.TotalQuantity
	FROM PRODUCTS sp
	JOIN ProductSales2006 t ON sp.ProductID=t.ProductID
	WHERE t.TotalQuantity=
			(
				SELECT MIN(TotalQuantity)
				FROM ProductSales2006
			);
GO


-- Question 43
-- For each country of origin, find the product
-- (ProductID, ProductName)
-- with the highest selling price.

WITH ProductPriceRanking AS
(
	SELECT ProductID,ProductName,CountryOfOrigin,Price,
			ROW_NUMBER() OVER
			(
				PARTITION BY CountryOfOrigin
				ORDER BY Price DESC
			) AS RowNumber
	FROM PRODUCTS
)
SELECT ProductID,ProductName,CountryOfOrigin,Price
	FROM ProductPriceRanking
	WHERE RowNumber=1;
GO


-- Question 44
-- Find the countries of origin that have at least three products
-- with different selling prices.

SELECT CountryOfOrigin
	FROM PRODUCTS
	GROUP BY CountryOfOrigin
	HAVING COUNT(DISTINCT Price)>=3;
GO


-- Question 45
-- Among the top 10 customers by sales amount,
-- find the customer with the highest number of purchases.

WITH Top10Customers AS
(
	SELECT TOP 10 CustomerID,FullName
		FROM CUSTOMERS
		ORDER BY SalesAmount DESC
),
PurchaseCounts AS
(
	SELECT t.CustomerID,t.FullName,COUNT(hd.InvoiceID) AS PurchaseCount
		FROM Top10Customers t
		JOIN INVOICES hd ON t.CustomerID=hd.CustomerID
		GROUP BY t.CustomerID,t.FullName
)
SELECT TOP 1 CustomerID,FullName,PurchaseCount
	FROM PurchaseCounts
	ORDER BY PurchaseCount DESC;
GO