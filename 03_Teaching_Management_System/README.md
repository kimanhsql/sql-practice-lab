# Teaching Management System

This project is a SQL Server database project based on the QLGiangDay exercises from the *Database Fundamentals* textbook.

It is designed to practice relational database design, table relationships, schema modification, integrity constraints, and SQL data management through a teaching management database.

---

## 1. Database Overview

**Database:** `QLGiangDay`

The database manages information about:

- Teachers
- Subjects
- Classrooms
- Departments
- Classes
- Teaching Schedules

### Tables

```text
GIAOVIEN
MONHOC
PHONGHOC
KHOA
LOP
LICHDAY
```

### Requirements

The textbook exercises cover the following tasks:

1. Create the `QLGiangDay` database.
2. Create the required tables.
3. Define primary keys and foreign keys.
4. Review the relationships between tables.
5. Add the following columns to `GIAOVIEN`:
   - Date of birth
   - Gender
   - Age
6. Add the `SucChua` (capacity) column to `PHONGHOC`.
7. Add the following columns to `MONHOC`:
   - `SoTC`
   - `TCLT`
   - `TCTH`
8. Add the `SiSo` (class size) column to `LOP`.
9. Define integrity constraints for:
   - `SiSo`
   - `SoTC`
   - `TCLT`
   - `TCTH`
   - `SucChua`
   - `TuoiGV`

---

## 2. Source

**Document:** `TH1207_GT.pdf`

| Pages | Content |
|---|---|
| 100 | QLGiangDay database structure and exercises |

The project is based on the original Vietnamese textbook exercises. The original terminology is preserved in the reference notes, while the SQL implementation is organized in English where appropriate.

---

## 3. Project Structure

```text
Teaching_Management_System/
├── SQL/
|
├── Notes.md
├── QLGiangDay.sql
└── README.md
```

- `SQL/`: SQL scripts organized by topic or exercise.
- `Notes.md`: Notes, explanations, and relevant information from the original exercises.
- `QLGiangDay.sql`: Complete SQL script containing the database implementation and exercises.
- `README.md`: Project documentation.

The complete SQL script is preserved as a reference, while individual exercises are organized into separate files in the `SQL/` directory.

---

## 4. Project Workflow

The project follows these steps:

1. Analyze the database requirements.
2. Create the database and tables.
3. Define primary keys, foreign keys, and constraints.
4. Review the relationships between tables.
5. Modify the existing tables by adding the required columns.
6. Define and test integrity constraints.
7. Verify the database structure and behavior.
8. Organize SQL scripts and document the solutions.

---

## 5. Current Progress

- [x] Database creation
- [x] Table creation
- [x] Primary keys, foreign keys, and constraints
- [x] Table relationship review
- [x] Additional columns
- [x] Integrity constraints
- [x] SQL script organization
- [x] Project documentation

---

## 6. Notes

This project is part of a collection of SQL Server database projects used to practice database design and SQL programming.

The database structure and requirements are based on the textbook exercises. The project also focuses on understanding relational integrity, schema modification, and the practical application of SQL constraints.

The original complete SQL script is preserved in `QLGiangDay.sql` for reference.