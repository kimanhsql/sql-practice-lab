# Sales Management System

This project is a SQL Server database project based on the QLHangHoa exercises from the *Database Fundamentals* textbook.

It is designed to practice relational database design, SQL queries, data manipulation, integrity constraints, triggers, and database management.

---

## 1. Database Overview

**Database:** `QLHangHoa`

The database manages information about:

- Customers
- Employees
- Products
- Invoices
- Invoice Details

### Tables

```text
KHACHHANG
NHANVIEN
SANPHAM
HOADON
CTHD
```

The project covers the following SQL topics and database operations:

- Database and table creation
- Primary keys and foreign keys
- Data insertion, deletion, and modification
- SELECT, WHERE, ORDER BY, and DISTINCT
- LIKE, BETWEEN, and IN
- Aggregate functions
- GROUP BY and HAVING
- JOIN and subqueries
- Common Table Expressions (CTEs)
- Window functions and CASE expressions
- Integrity constraints
- Triggers and data validation

---

## 2. Source

**Document:** `TH1207_GT.pdf`

| Pages | Content |
|---|---|
| 100–102 | QLHangHoa database description and table structure |
| 108–110 | Data manipulation exercises |
| 116–118 | Data query exercises |

The project is based on the original Vietnamese textbook exercises. The original exercise statements are preserved in `Notes.md`, while the SQL implementation is organized in English where appropriate.

---

## 3. Project Structure

```text
QLHangHoa/
├── Images/
├── SQL/
├── Notes.md
├── QLHangHoa.sql
└── README.md
```

- `Images/`: Database diagrams and other project-related images.
- `SQL/`: SQL scripts organized by topic or exercise.
- `Notes.md`: Original Vietnamese exercise statements and relevant notes.
- `QLHangHoa.sql`: Complete SQL script containing the database implementation and exercises.
- `README.md`: Project documentation.

The complete SQL script is preserved as a reference, while individual exercises are organized into separate files in the `SQL/` directory.

---

## 4. Project Workflow

The project follows these steps:

1. Analyze the database requirements.
2. Create the database and tables.
3. Define primary keys, foreign keys, and integrity constraints.
4. Insert sample data.
5. Practice data manipulation and SQL queries.
6. Implement and test triggers.
7. Verify query results and data integrity.
8. Organize SQL scripts and document the solutions.

---

## 5. Current Progress

- [x] Database creation
- [x] Table creation
- [x] Primary keys and foreign keys
- [x] Sample data
- [x] DML exercises
- [x] Basic and advanced queries
- [x] Integrity constraints
- [x] Triggers
- [x] SQL script organization
- [x] Project documentation

---

## 6. Notes

This project is part of a collection of SQL Server database projects used to practice database design and SQL programming.

The project focuses on understanding relational integrity, business rules, query logic, and the practical application of SQL features.

The original complete SQL script is preserved in `QLHangHoa.sql` for reference.