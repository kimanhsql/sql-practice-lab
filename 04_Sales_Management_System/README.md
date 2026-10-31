# Sales Management System

This project is a SQL Server database project based on the `QLHangHoa` exercises from the *Database Fundamentals* textbook (`TH1207_GT.pdf`, pages 100–102, 108–110, and 116–118).

---

## 1. Database Overview & Structure

**Database:** `SALES_DB` (based on `QLHangHoa`)

The database consists of 5 core tables managing information about customers, employees, products, invoices, and invoice details.


### Table List

```text
CUSTOMERS
EMPLOYEES
PRODUCTS
INVOICES
INVOICE_DETAILS
```


### Detailed Table Specifications & Constraints Note

* **Primary Keys (PK):** `CustomerID` (`CUSTOMERS`), `EmployeeID` (`EMPLOYEES`), `ProductID` (`PRODUCTS`), `InvoiceID` (`INVOICES`), and composite key (`InvoiceID`, `ProductID`) (`INVOICE_DETAILS`).
* **Foreign Keys (FK):** `INVOICES` references `CUSTOMERS` (`CustomerID`) and `EMPLOYEES` (`EmployeeID`); `INVOICE_DETAILS` references `INVOICES` (`InvoiceID`) and `PRODUCTS` (`ProductID`).
* **Schema Modifications & Constraints:** Explicitly required schema changes (`ALTER TABLE`) and integrity rules are outlined in the requirements below.

---

#### 1.1 CUSTOMERS

* **Attributes & Data Types:** `CustomerID` (VARCHAR(4)), `FullName` (NVARCHAR(40)), `Address` (NVARCHAR(50)), `PhoneNumber` (VARCHAR(20)), `DateOfBirth` (SMALLDATETIME), `RegistrationDate` (SMALLDATETIME), `SalesAmount` (MONEY) *(Plus added column: `CustomerType`)*
* **Primary Key:** `CustomerID`

---

#### 1.2 EMPLOYEES

* **Attributes & Data Types:** `EmployeeID` (VARCHAR(4)), `FullName` (NVARCHAR(40)), `PhoneNumber` (VARCHAR(20)), `HireDate` (SMALLDATETIME)
* **Primary Key:** `EmployeeID`

---

#### 1.3 PRODUCTS

* **Attributes & Data Types:** `ProductID` (VARCHAR(4)), `ProductName` (NVARCHAR(40)), `Unit` (NVARCHAR(20)), `CountryOfOrigin` (NVARCHAR(40)), `Price` (MONEY) *(Plus added column: `Notes`)*
* **Primary Key:** `ProductID`

---

#### 1.4 INVOICES

* **Attributes & Data Types:** `InvoiceID` (INT), `InvoiceDate` (SMALLDATETIME), `CustomerID` (VARCHAR(4)), `EmployeeID` (VARCHAR(4)), `TotalAmount` (MONEY)
* **Primary Key:** `InvoiceID`
* **Foreign Keys:** `CustomerID` (references `CUSTOMERS`), `EmployeeID` (references `EMPLOYEES`)

---

#### 1.5 INVOICE_DETAILS

* **Attributes & Data Types:** `InvoiceID` (INT), `ProductID` (VARCHAR(4)), `Quantity` (INT)
* **Primary Key:** Composite key (`InvoiceID`, `ProductID`)
* **Foreign Keys:** `InvoiceID` (references `INVOICES`), `ProductID` (references `PRODUCTS`)

---

## 2. Textbook Exercises & Requirements

### PART I: DATA DEFINITION LANGUAGE (DDL) & SCHEMA MODIFICATION

*(Pages 100–102)*

1. Create the relations (tables) and declare primary keys and foreign keys.
2. Add the `Notes` column with data type `VARCHAR(20)` to the `PRODUCTS` table.
3. Add the `CustomerType` column with data type `TINYINT` to the `CUSTOMERS` table.
4. Alter the data type of the `Notes` column in the `PRODUCTS` table to `VARCHAR(100)`.
5. Drop the `Notes` column from the `PRODUCTS` table.
6. Configure the `CustomerType` column in the `CUSTOMERS` table to store values such as `'Vang lai'`, `'Thuong xuyen'`, `'Vip'`, etc.
7. Restrict product units (`Unit`) to only allow: `('Cây', 'hop', 'cai', 'quyen', 'chuc')`.
8. Ensure the selling price (`Price`) of a product is 500 VND or higher.
9. Each purchase must include at least one product.
10. A member customer's registration date (`RegistrationDate`) must be later than their date of birth (`DateOfBirth`).
11. An invoice date (`InvoiceDate`) for a member customer must be greater than or equal to their registration date (`RegistrationDate`).
12. An invoice date (`InvoiceDate`) created by an employee must be greater than or equal to their hire date (`HireDate`).
13. Each invoice must contain at least one invoice detail item.
14. The total value of an invoice (`TotalAmount`) must equal the sum of line amounts (`Quantity * Price`) of its items.
15. A customer's revenue/sales total (`SalesAmount`) must equal the sum of invoice values (`TotalAmount`) they have purchased.

---

### PART II: DATA MANIPULATION LANGUAGE (DML)

*(Page 110)*

1. Insert sample data into all relations.
2. Create `PRODUCTS1` containing all data from `PRODUCTS`, and `CUSTOMERS1` containing all data from `CUSTOMERS`.
3. Update prices up by 5% for products manufactured in 'Thai Lan' (for `PRODUCTS1`).
4. Update prices down by 5% for products manufactured in 'Trung Quoc' with a price of 10,000 or less (for `PRODUCTS1`).
5. Update `CustomerType` to `'Vip'` for customers who registered before `2007-01-01` with a total sales (`SalesAmount`) of `10,000,000` or more, or customers who registered on or after `2007-01-01` with a sales total of `2,000,000` or more (for `CUSTOMERS1`).

---

### PART III: DATA QUERYING (SQL)

*(Pages 116–118)*

1. List products (`ProductID`, `ProductName`) manufactured by 'Trung Quoc'.
2. List products (`ProductID`, `ProductName`) with units 'Cây' or 'Quyển'.
3. List products (`ProductID`, `ProductName`) whose product code starts with 'B' and ends with '01'.
4. List products (`ProductID`, `ProductName`) manufactured by 'Trung Quoc' priced between 30,000 and 40,000.
5. List products (`ProductID`, `ProductName`) manufactured by 'Trung Quoc' or 'Thai Lan' priced between 30,000 and 40,000.
6. List invoice numbers and total values for invoices sold on `2007-01-01` and `2007-02-01`.
7. List invoice numbers and values in January 2007, sorted by date (ascending) and invoice value (descending).
8. List customers (`CustomerID`, `FullName`) who made purchases on `2007-01-01`.
9. List invoice numbers and values created by employee 'Nguyen Van B' on `2006-10-28`.
10. List products (`ProductID`, `ProductName`) purchased by customer 'Nguyen Van A' in October 2006.
11. Find invoice numbers that purchased product 'BB01' or 'BB02'.
12. Find invoice numbers that purchased product 'BB01' or 'BB02' with a quantity between 10 and 20 for each.
13. Find invoice numbers that simultaneously purchased both products 'BB01' and 'BB02' with quantities between 10 and 20 for each.
14. List products (`ProductID`, `ProductName`) manufactured by 'Trung Quoc' or sold on `2007-01-01`.
15. List products (`ProductID`, `ProductName`) that have never been sold.
16. List products (`ProductID`, `ProductName`) that were not sold in the year 2006.
17. List products (`ProductID`, `ProductName`) manufactured by 'Trung Quoc' that were not sold in the year 2006.
18. Find invoice numbers that have purchased all products manufactured by Singapore.
19. Find invoice numbers in 2006 that have purchased at least all products manufactured by Singapore.
20. How many invoices were made by non-member (guest) customers?
21. How many distinct products were sold in the year 2006?
22. What are the maximum and minimum invoice values?
23. What is the average invoice value of all invoices sold in the year 2006?
24. Calculate total sales revenue for the year 2006.
25. Find the invoice number with the highest invoice value in the year 2006.
26. Find the customer name who purchased the highest-value invoice in the year 2006.
27. List the top 3 customers (`CustomerID`, `FullName`) with the highest total sales (`SalesAmount`).
28. List products (`ProductID`, `ProductName`) whose price matches one of the top 3 highest prices.
29. List products (`ProductID`, `ProductName`) manufactured by 'Thai Lan' whose price matches one of the top 3 highest prices across all products.
30. List products (`ProductID`, `ProductName`) manufactured by 'Trung Quoc' whose price matches one of the top 3 highest prices among products manufactured by 'Trung Quoc'.
31. List the top 3 customers with the highest sales using ranking functions.
32. Calculate the total number of products manufactured by 'Trung Quoc'.
33. Calculate the total number of products for each country of manufacture.
34. For each country of manufacture, find the maximum, minimum, and average product prices.
35. Calculate daily sales revenue.
36. Calculate total quantity sold for each product in October 2006.
37. Calculate monthly sales revenue for each month in the year 2006.
38. Find invoices that purchased at least 4 different products.
39. Find invoices that purchased 3 different products manufactured by 'Viet Nam'.
40. Find the customer (`CustomerID`, `FullName`) with the highest number of purchases.
41. Which month in 2006 had the highest sales revenue?
42. Find the product (`ProductID`, `ProductName`) with the lowest total quantity sold in the year 2006.
43. For each country of manufacture, find the product (`ProductID`, `ProductName`) with the highest price.
44. Find countries of manufacture that produce at least 3 products with different prices.
45. Among the top 10 customers with the highest sales, find the customer with the most purchases.

---

## 3. Project Structure & Workflow

```text
04_Sales_Management_System/
├── Images/
├── SQL/
├── QLHangHoa.sql
└── README.md
```

* **Workflow:**
1. Analyze database requirements from the textbook.
2. Create database, tables, primary keys, and foreign keys in English.
3. Implement schema modifications and integrity constraints (`ALTER TABLE`, `CHECK`, `TRIGGERS`).
4. Perform data insertion and DML updates.
5. Execute and verify all 45 data querying tasks.
6. Organize SQL scripts and finalize project documentation.

---

## 4. Current Progress

* [x] Database creation
* [x] Table creation (English schema)
* [x] Primary keys and foreign keys
* [x] Sample data setup
* [x] DML exercises execution
* [x] 45 SQL queries implementation and verification
* [x] Integrity constraints & Triggers implementation
* [x] SQL script organization
* [x] Project documentation (`README.md`)