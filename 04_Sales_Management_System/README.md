# Sales Management System

This project is a SQL Server database project based on the `QLHangHoa` exercises from the *Database Fundamentals* textbook (`TH1207_GT.pdf`, pages 100–102, 108–110, and 116–118).

---

## 1. Database Overview & Structure

**Database:** `QLHangHoa`

The database consists of 5 core tables managing information about customers, employees, products, invoices, and invoice details.


### Table List

```text
KHACHHANG
NHANVIEN
SANPHAM
HOADON
CTHD
```


### Detailed Table Specifications & Constraints Note

* **Primary Keys (PK):** `MAKH` (`KHACHHANG`), `MANV` (`NHANVIEN`), `MASP` (`SANPHAM`), `SOHD` (`HOADON`), and composite key (`SOHD`, `MASP`) (`CTHD`).
* **Foreign Keys (FK):** `HOADON` references `KHACHHANG` (`MAKH`) and `NHANVIEN` (`MANV`); `CTHD` references `HOADON` (`SOHD`) and `SANPHAM` (`MASP`).
* **Schema Modifications & Constraints:** Explicitly required schema changes (`ALTER TABLE`) and integrity rules are outlined in the requirements below.


#### 1.1 KHACHHANG (Customers)

* **Attributes & Data Types:** `MAKH`, `HOTEN`, `DCHI`, `SODT`, `NGSINH`, `DOANHSO`, `NGDK` *(Plus added column: `LOAIKH`)*
* **Primary Key:** `MAKH`

---

#### 1.2 NHANVIEN (Employees)

* **Attributes & Data Types:** `MANV`, `HOTEN`, `NGVL`, `SODT`
* **Primary Key:** `MANV`

---

#### 1.3 SANPHAM (Products)

* **Attributes & Data Types:** `MASP`, `TENSP`, `DVT`, `NUOCSX`, `GIA` *(Plus added column: `GHICHU`)*
* **Primary Key:** `MASP`

---

#### 1.4 HOADON (Invoices)

* **Attributes & Data Types:** `SOHD`, `NGHD`, `MAKH`, `MANV`, `TRIGIA`
* **Primary Key:** `SOHD`
* **Foreign Keys:** `MAKH` (references `KHACHHANG`), `MANV` (references `NHANVIEN`)

---

#### 1.5 CTHD (Invoice Details)

* **Attributes & Data Types:** `SOHD`, `MASP`, `SL`
* **Primary Key:** Composite key (`SOHD`, `MASP`)
* **Foreign Keys:** `SOHD` (references `HOADON`), `MASP` (references `SANPHAM`)

---

## 2. Textbook Exercises & Requirements

### PART I: DATA DEFINITION LANGUAGE (DDL) & SCHEMA MODIFICATION

*(Pages 100–102)*

1. Create the relations (tables) and declare primary keys and foreign keys.
2. Add the `GHICHU` column with data type `VARCHAR(20)` to the `SANPHAM` table.
3. Add the `LOAIKH` column with data type `TINYINT` to the `KHACHHANG` table.
4. Alter the data type of the `GHICHU` column in the `SANPHAM` table to `VARCHAR(100)`.
5. Drop the `GHICHU` column from the `SANPHAM` table.
6. Configure the `LOAIKH` column in the `KHACHHANG` table to store values such as `'Vang lai'`, `'Thuong xuyen'`, `'Vip'`, etc.
7. Restrict product units (`DVT`) to only allow: `('Cây', 'hop', 'cai', 'quyen', 'chuc')`.
8. Ensure the selling price (`GIA`) of a product is 500 VND or higher.
9. Each purchase must include at least one product.
10. A member customer's registration date (`NGDK`) must be later than their date of birth (`NGSINH`).
11. An invoice date (`NGHD`) for a member customer must be greater than or equal to their registration date (`NGDK`).
12. An invoice date (`NGHD`) created by an employee must be greater than or equal to their hire date (`NGVL`).
13. Each invoice must contain at least one invoice detail item.
14. The total value of an invoice (`TRIGIA`) must equal the sum of line amounts (`SL * GIA`) of its items.
15. A customer's revenue/sales total (`DOANHSO`) must equal the sum of invoice values (`TRIGIA`) they have purchased.

---

### PART II: DATA MANIPULATION LANGUAGE (DML)

*(Page 110)*

1. Insert sample data into all relations.
2. Create `SANPHAM1` containing all data from `SANPHAM`, and `KHACHHANG1` containing all data from `KHACHHANG`.
3. Update prices up by 5% for products manufactured in 'Thai Lan' (for `SANPHAM1`).
4. Update prices down by 5% for products manufactured in 'Trung Quoc' with a price of 10,000 or less (for `SANPHAM1`).
5. Update `LOAIKH` to `'Vip'` for customers who registered before `2007-01-01` with a total sales (`DOANHSO`) of `10,000,000` or more, or customers who registered on or after `2007-01-01` with a sales total of `2,000,000` or more (for `KHACHHANG1`).

---

### PART III: DATA QUERYING (SQL)

*(Pages 116–118)*

1. List products (`MASP`, `TENSP`) manufactured by 'Trung Quoc'.
2. List products (`MASP`, `TENSP`) with units 'Cây' or 'Quyển'.
3. List products (`MASP`, `TENSP`) whose product code starts with 'B' and ends with '01'.
4. List products (`MASP`, `TENSP`) manufactured by 'Trung Quoc' priced between 30,000 and 40,000.
5. List products (`MASP`, `TENSP`) manufactured by 'Trung Quoc' or 'Thai Lan' priced between 30,000 and 40,000.
6. List invoice numbers and total values for invoices sold on `2007-01-01` and `2007-02-01`.
7. List invoice numbers and values in January 2007, sorted by date (ascending) and invoice value (descending).
8. List customers (`MAKH`, `HOTEN`) who made purchases on `2007-01-01`.
9. List invoice numbers and values created by employee 'Nguyen Van B' on `2006-10-28`.
10. List products (`MASP`, `TENSP`) purchased by customer 'Nguyen Van A' in October 2006.
11. Find invoice numbers that purchased product 'BB01' or 'BB02'.
12. Find invoice numbers that purchased product 'BB01' or 'BB02' with a quantity between 10 and 20 for each.
13. Find invoice numbers that simultaneously purchased both products 'BB01' and 'BB02' with quantities between 10 and 20 for each.
14. List products (`MASP`, `TENSP`) manufactured by 'Trung Quoc' or sold on `2007-01-01`.
15. List products (`MASP`, `TENSP`) that have never been sold.
16. List products (`MASP`, `TENSP`) that were not sold in the year 2006.
17. List products (`MASP`, `TENSP`) manufactured by 'Trung Quoc' that were not sold in the year 2006.
18. Find invoice numbers that have purchased all products manufactured by Singapore.
19. Find invoice numbers in 2006 that have purchased at least all products manufactured by Singapore.
20. How many invoices were made by non-member (guest) customers?
21. How many distinct products were sold in the year 2006?
22. What are the maximum and minimum invoice values?
23. What is the average invoice value of all invoices sold in the year 2006?
24. Calculate total sales revenue for the year 2006.
25. Find the invoice number with the highest invoice value in the year 2006.
26. Find the customer name who purchased the highest-value invoice in the year 2006.
27. List the top 3 customers (`MAKH`, `HOTEN`) with the highest total sales (`DOANHSO`).
28. List products (`MASP`, `TENSP`) whose price matches one of the top 3 highest prices.
29. List products (`MASP`, `TENSP`) manufactured by 'Thai Lan' whose price matches one of the top 3 highest prices across all products.
30. List products (`MASP`, `TENSP`) manufactured by 'Trung Quoc' whose price matches one of the top 3 highest prices among products manufactured by 'Trung Quoc'.
31. List the top 3 customers with the highest sales using ranking functions.
32. Calculate the total number of products manufactured by 'Trung Quoc'.
33. Calculate the total number of products for each country of manufacture.
34. For each country of manufacture, find the maximum, minimum, and average product prices.
35. Calculate daily sales revenue.
36. Calculate total quantity sold for each product in October 2006.
37. Calculate monthly sales revenue for each month in the year 2006.
38. Find invoices that purchased at least 4 different products.
39. Find invoices that purchased 3 different products manufactured by 'Viet Nam'.
40. Find the customer (`MAKH`, `HOTEN`) with the highest number of purchases.
41. Which month in 2006 had the highest sales revenue?
42. Find the product (`MASP`, `TENSP`) with the lowest total quantity sold in the year 2006.
43. For each country of manufacture, find the product (`MASP`, `TENSP`) with the highest price.
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
2. Create database, tables, primary keys, and foreign keys.
3. Implement schema modifications and integrity constraints (`ALTER TABLE`, `CHECK`, `TRIGGERS`).
4. Perform data insertion and DML updates.
5. Execute and verify all 45 data querying tasks.
6. Organize SQL scripts and finalize project documentation.

---

## 4. Current Progress

* [x] Database creation
* [x] Table creation
* [x] Primary keys and foreign keys
* [x] Sample data setup
* [x] DML exercises execution
* [x] 45 SQL queries implementation and verification
* [x] Integrity constraints & Triggers implementation
* [x] SQL script organization
* [x] Project documentation (`README.md`)