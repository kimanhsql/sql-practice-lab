# Product Sales Management System

This project is a SQL Server database project based on the **QLHangHoa (Product Sales Management System)** exercises from the *Database Fundamentals* textbook.

The project is used to practice database design, data manipulation, SQL querying, constraints, triggers, and data integrity.

---

## 1. Database Overview

**Database:** `QLHangHoa`

The database manages information about:

- Customers
- Employees
- Products
- Invoices
- Invoice details

### Tables

```text
KHACHHANG
NHANVIEN
SANPHAM
HOADON
CTHD
```

### Main Relationships

- A customer can have many invoices.
- An employee can create many invoices.
- An invoice can contain multiple products.
- A product can appear in multiple invoices.
- CTHD represents the many-to-many relationship between invoices and products.

---

## 2. Source

Document: `TH1207_GT.pdf`

Relevant textbook sections:

 Pages | Content |
|---|---|
| 100–102 | QLHangHoa database description and table structure |
| 108–110 | Data Manipulation Language (DML) exercises using QLHangHoa |
| 116–118 | Data Query exercises using QLHangHoa |

The textbook exercises are originally written in Vietnamese.

The Vietnamese exercise statements are kept separately in Notes.md.

The SQL implementation is written and organized in English for this repository.

---

## 3. Project Files

QLHangHoa/
├── Images/
|
├── SQL/
|
├── Notes.md
├── QLHangHoa.sql
└── README.md

The exact file structure may be expanded as the project is organized further.

`QLHangHoa.sql` is kept as the complete reference SQL script.

The files inside SQL/ are separated versions of the same database work.

---

## 4. Database Structure

The database contains five main tables:

 Pages | Purpose |
|---|---|
| KHACHHANG | Stores customer information |
| NHANVIEN | Stores employee information |
| SANPHAM | Stores product information |
| HOADON | Stores invoice information |
| CTHD | Stores products and quantities included in each invoice |

The database uses primary keys and foreign keys to maintain relationships between the tables.

---

## 5. SQL Topics Practiced

This project covers:

- Database creation
- Table creation
- Primary keys
- Foreign keys
- Data insertion
- Data deletion
- Data modification
- SELECT
- WHERE
- ORDER BY
- DISTINCT
- LIKE
- BETWEEN
- IN
- Aggregate functions
- GROUP BY
- HAVING
- JOIN
- Subqueries
- Common Table Expressions (CTEs)
- Window functions
- CASE
- Constraints
- Triggers
- Data integrity

The query section progresses from basic filtering and sorting to more complex queries involving multiple tables, aggregation, subqueries, ranking, and CTEs.

---

## 6. Data Manipulation

The QLHangHoa exercises include operations such as:

- Creating temporary copies of tables for testing changes
- Updating product prices
- Updating customer classifications
- Modifying customer and product information
- Working with invoice and invoice-detail data

The project also includes validation and comparison of modified data against the original data.

---

## 7. Data Integrity

The database includes several constraints and triggers to enforce business rules.

Examples include:

- Valid customer classifications
- Valid product units
- Minimum product prices
- Customer registration date must be later than date of birth
- Invoice date must not be earlier than the customer's registration date
- Invoice date must not be earlier than the employee's start date
- An invoice must contain at least one invoice detail
- A product cannot be removed when it would violate invoice-detail requirements
- Invoice totals are recalculated when invoice details change
- Customer sales totals are recalculated when invoices change

These rules are implemented using CHECK constraints and triggers.

---

## 8. Query Practice

The query exercises use the QLHangHoa database to retrieve and analyze information such as:

- Products by country of origin
- Products within a price range
- Products matching specific codes or units
- Invoices by date
- Customers who purchased on specific dates
- Products purchased by specific customers
- Sales information by month
- Product quantities sold
- Number of products in invoices
- Sales by customer
- Revenue by month
- Product statistics by country
- Customer rankings
- Top customers and products

The SQL script contains more advanced queries using GROUP BY, HAVING, subqueries, CTEs, and ranking functions.

---

## 9. Current Progress

Database creation: ✅ Completed
Table creation: ✅ Completed
Primary keys and foreign keys: ✅ Completed
Sample data: ✅ Completed
DML exercises: ✅ Completed
Basic queries: ✅ Completed
Advanced queries: ✅ Completed
Constraints: ✅ Completed
Triggers: ✅ Completed
Project organization: ✅ Completed
SQL files separation: ✅ Completed

---

## 10. Reference SQL

`QLHangHoa.sql` contains the complete SQL work for this database, including:

- Database creation
- Table creation
- Constraints
- Sample data
- DML exercises
- Query exercises
- Triggers
- Data integrity rules
- Additional testing and verification queries

This file is kept as the main reference while the project is gradually separated into smaller SQL files.

---

## 11. Notes

Notes.md stores the original Vietnamese exercise statements from the textbook.

The purpose of keeping the Vietnamese statements separately is to preserve the original requirements while keeping the SQL implementation in English.

The project is organized gradually as each section is reviewed and separated.