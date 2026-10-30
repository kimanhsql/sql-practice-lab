-- ============================================================
-- SALES MANAGEMENT SYSTEM
-- DATA QUERY LANGUAGE (DQL)
-- ============================================================

USE SALES_DB;
GO


-- Question 1
-- List products (`MASP`, `TENSP`) manufactured by 'Trung Quoc'.

SELECT ProductID,ProductName
	FROM PRODUCTS
	WHERE CountryOfOrigin=N'Trung Quốc';
GO


-- Question 2
-- List products (`MASP`, `TENSP`) with units 'Cây' or 'Quyển'.

SELECT ProductID,ProductName,Unit
	FROM PRODUCTS
	WHERE Unit IN(N'Cây','quyen');
GO


-- Question 3
-- List products (`MASP`, `TENSP`) whose product code
-- starts with 'B' and ends with '01'.

SELECT ProductID,ProductName
	FROM PRODUCTS
	WHERE ProductID LIKE 'B%01';
GO


-- Question 4
-- List products (`MASP`, `TENSP`) manufactured by
-- 'Trung Quoc' priced between 30,000 and 40,000.

SELECT ProductID,ProductName
	FROM PRODUCTS
	WHERE CountryOfOrigin=N'Trung Quốc' AND
		Price BETWEEN 30000 AND 40000;
GO


-- Question 5
-- List products (`MASP`, `TENSP`) manufactured by 'Trung Quoc'
-- or 'Thai Lan' priced between 30,000 and 40,000.

SELECT ProductID,ProductName,CountryOfOrigin,Price
	FROM PRODUCTS
	WHERE (CountryOfOrigin=N'Trung Quốc' OR CountryOfOrigin='Thai Lan') AND
		Price BETWEEN 30000 AND 40000;
GO


-- Question 6
-- List invoice numbers and total values for invoices
-- sold on `2007-01-01` and `2007-02-01`.

SELECT InvoiceID,TotalAmount
	FROM INVOICES
	WHERE InvoiceDate IN('2007-01-01','2007-02-01');
GO


-- Question 7
-- List invoice numbers and values in January 2007,
-- sorted by date (ascending) and invoice value (descending).

SELECT InvoiceID,TotalAmount
	FROM INVOICES
	WHERE MONTH(InvoiceDate)=1 AND YEAR(InvoiceDate)=2007
	ORDER BY InvoiceDate ASC, TotalAmount DESC;
GO


-- Question 8
-- List customers (`MAKH`, `HOTEN`) who made purchases
-- on `2007-01-01`.

SELECT kh.CustomerID,FullName
	FROM CUSTOMERS kh
	JOIN INVOICES hd ON kh.CustomerID=hd.CustomerID
	WHERE InvoiceDate='2007-01-01';
GO


-- Question 9
-- List invoice numbers and values created by
-- employee 'Nguyen Van B' on `2006-10-28`.

SELECT InvoiceID,TotalAmount
	FROM INVOICES hd
	JOIN EMPLOYEES nv ON hd.EmployeeID=nv.EmployeeID
	WHERE FullName='Nguyen Van B' AND
		InvoiceDate='2006-10-28';
GO


-- Question 10
-- List products (`MASP`, `TENSP`) purchased by
-- customer 'Nguyen Van A' in October 2006.

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
-- Find invoice numbers that purchased product 'BB01' or 'BB02'.

SELECT InvoiceID,ct.ProductID
	FROM INVOICE_DETAILS ct
	JOIN PRODUCTS sp ON ct.ProductID=sp.ProductID
	WHERE ct.ProductID IN('BB01','BB02');
GO


-- Question 12
-- Find invoice numbers that purchased product 'BB01' or 'BB02'
-- with a quantity between 10 and 20 for each.

SELECT InvoiceID,ct.ProductID
	FROM INVOICE_DETAILS ct
	JOIN PRODUCTS sp ON ct.ProductID=sp.ProductID
	WHERE ct.ProductID IN('BB01','BB02') AND
			Quantity BETWEEN 10 AND 20;
GO


-- Question 13
-- Find invoice numbers that simultaneously
-- purchased both products 'BB01' and 'BB02'
-- with quantities between 10 and 20 for each.

SELECT InvoiceID
	FROM INVOICE_DETAILS
	WHERE ProductID='BB01' AND Quantity BETWEEN 10 AND 20

INTERSECT

SELECT InvoiceID
	FROM INVOICE_DETAILS
	WHERE ProductID='BB02' AND Quantity BETWEEN 10 AND 20;
GO


-- Question 14
-- List products (`MASP`, `TENSP`) manufactured by 'Trung Quoc'
-- or sold on `2007-01-01`.

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
-- List products (`MASP`, `TENSP`) that have never been sold.

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
-- List products (`MASP`, `TENSP`)
-- that were not sold in the year 2006.

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
-- List products (`MASP`, `TENSP`)
-- manufactured by 'Trung Quoc'
-- that were not sold in the year 2006.

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
-- Find invoice numbers that have purchased
-- all products manufactured by Singapore.

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
-- Find invoice numbers in 2006 that have purchased
-- at least all products manufactured by Singapore.

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
-- How many invoices were made by non-member (guest) customers?

SELECT COUNT(*) AS NON_MEMBER_INVOICES
	FROM INVOICES
	WHERE CustomerID IS NULL;
GO


-- Question 21
-- How many distinct products were sold in the year 2006?

SELECT COUNT(DISTINCT ProductID) AS DISTINCT_PRODUCTS_SOLD_2006
	FROM INVOICE_DETAILS ct
	JOIN INVOICES hd ON ct.InvoiceID=hd.InvoiceID
	WHERE YEAR(InvoiceDate)=2006;
GO


-- Question 22
-- What are the maximum and minimum invoice values?

SELECT MAX(TotalAmount) AS HIGHEST_AMOUNT,MIN(TotalAmount) AS LOWEST_AMOUNT
	FROM INVOICES;
GO


-- Question 23
-- What is the average invoice value of
-- all invoices sold in the year 2006?

SELECT AVG(TotalAmount) AS AVERAGE_AMOUNT
	FROM INVOICES
	WHERE YEAR(InvoiceDate)=2006;
GO


-- Question 24
-- Calculate total sales revenue for the year 2006.

SELECT SUM(TotalAmount) AS SALES_REVENUE_2006
	FROM INVOICES
	WHERE YEAR(InvoiceDate)=2006;
GO


-- Question 25
-- Find the invoice number with
-- the highest invoice value in the year 2006.

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
-- Find the customer name who purchased
-- the highest-value invoice in the year 2006.

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
-- List the top 3 customers (`MAKH`, `HOTEN`)
-- with the highest total sales (`DOANHSO`).

SELECT TOP 3 CustomerID,FullName,SalesAmount
	FROM CUSTOMERS
	ORDER BY SalesAmount DESC;
GO


-- Question 28
-- List products (`MASP`, `TENSP`)
-- whose price matches one of the top 3 highest prices.

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
-- List products (`MASP`, `TENSP`) manufactured by 'Thai Lan'
-- whose price matches one of the top 3 highest prices
-- across all products.

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
-- List products (`MASP`, `TENSP`) manufactured by 'Trung Quoc'
-- whose price matches one of the top 3 highest prices
-- among products manufactured by 'Trung Quoc'.

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
-- List the top 3 customers with the highest sales
-- using ranking functions.

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
-- Calculate the total number of products
-- manufactured by 'Trung Quoc'.

SELECT COUNT(*) AS TOTAL_PRODUCTS_CHINA
	FROM PRODUCTS
	WHERE CountryOfOrigin=N'Trung Quốc';
GO


-- Question 33
-- Calculate the total number of products
-- for each country of manufacture.

SELECT CountryOfOrigin,COUNT(*) AS TOTAL_PRODUCTS
	FROM PRODUCTS
	GROUP BY CountryOfOrigin;
GO


-- Question 34
-- For each country of manufacture, find the maximum,
-- minimum, and average product prices.

SELECT CountryOfOrigin,
		MAX(Price) AS HIGHEST_PRICE,
		MIN(Price) AS LOWEST_PRICE,
		AVG(Price) AS AVERAGE_PRICE
	FROM PRODUCTS
	GROUP BY CountryOfOrigin;
GO


-- Question 35
-- Calculate daily sales revenue.

SELECT InvoiceDate,SUM(TotalAmount) AS DAILY_REVENUE
	FROM INVOICES
	GROUP BY InvoiceDate;
GO


-- Question 36
-- Calculate total quantity sold for each product in October 2006.

SELECT ct.ProductID,sp.ProductName,SUM(Quantity) AS TOTAL_QUANTITY_SOLD
	FROM INVOICE_DETAILS ct
	JOIN INVOICES hd ON ct.InvoiceID=hd.InvoiceID
	JOIN PRODUCTS sp ON ct.ProductID=sp.ProductID
	WHERE MONTH(InvoiceDate)=10 AND YEAR(InvoiceDate)=2006
	GROUP BY ct.ProductID,sp.ProductName;
GO


-- Question 37
-- Calculate monthly sales revenue for each month in the year 2006.

SELECT MONTH(InvoiceDate) AS MONTH_NUMBER,SUM(TotalAmount) AS MONTHLY_REVENUE
	FROM INVOICES
	WHERE YEAR(InvoiceDate)=2006
	GROUP BY MONTH(InvoiceDate);
GO


-- Question 38
-- Find invoices that purchased at least 4 different products.

SELECT InvoiceID
	FROM INVOICE_DETAILS
	GROUP BY InvoiceID
	HAVING COUNT(DISTINCT ProductID)>=4;
GO


-- Question 39
-- Find invoices that purchased 3 different products
-- manufactured by 'Viet Nam'.

SELECT InvoiceID
	FROM INVOICE_DETAILS ct
	JOIN PRODUCTS sp ON ct.ProductID=sp.ProductID
	WHERE CountryOfOrigin='Viet Nam'
	GROUP BY InvoiceID
	HAVING COUNT(DISTINCT ct.ProductID)=3;
GO


-- Question 40
-- Find the customer (`MAKH`, `HOTEN`)
-- with the highest number of purchases.

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
-- Which month in 2006 had the highest sales revenue?

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
-- Find the product (`MASP`, `TENSP`)
-- with the lowest total quantity sold in the year 2006.

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
-- For each country of manufacture,
-- find the product (`MASP`, `TENSP`) with the highest price.

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
-- Find countries of manufacture that produce
-- at least 3 products with different prices.

SELECT CountryOfOrigin
	FROM PRODUCTS
	GROUP BY CountryOfOrigin
	HAVING COUNT(DISTINCT Price)>=3;
GO


-- Question 45
-- Among the top 10 customers with the highest sales,
-- find the customer with the most purchases.

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