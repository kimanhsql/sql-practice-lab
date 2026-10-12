# Teaching Management System

This project is a SQL Server database project based on the **QLGiangDay (Teaching Management System)** exercise from the *Database Fundamentals* textbook.

The project focuses on designing a database for managing teachers, subjects, classrooms, departments, classes, and teaching schedules.

---

## 1. Database Overview

**Original Database:** `QLGiangDay`

The database manages information about:

- Teachers
- Subjects
- Classrooms
- Departments
- Classes
- Teaching schedules

### Original Tables

```text
GIAOVIEN
MONHOC
PHONGHOC
KHOA
LOP
LICHDAY
```

Main Relationships:

- A teacher belongs to a department.
- A class belongs to a department.
- A teaching schedule is associated with a teacher.
- A teaching schedule is associated with a subject.
- A teaching schedule is associated with a classroom.
- A teaching schedule is associated with a class.
  
---

## 2. Source

Document: `TH1207_GT.pdf`

Relevant Page:

 Pages | Content |
|---|---|
| 100 | QLGiangDay database and exercises |

The original exercise is written in Vietnamese.

The repository version is translated into English for easier use in the SQL project.

---

## 3. Database Structure

- GIAOVIEN

```sql
GIAOVIEN(
    MaGV,
    HoTen,
    MaKhoa
)
```

Stores teacher information and the department to which each teacher belongs.

- MONHOC

```sql
MONHOC(
    MaMH,
    TenMH
)
```

Stores subject information.

- PHONGHOC

```sql
PHONGHOC(
    Phong,
    ChucNang
)
```

Stores classroom information and its function.

- KHOA

```sql
KHOA(
    MaKhoa,
    TenKhoa
)
```

Stores department information.

- LOP

```sql
LOP(
    MaLop,
    TenLop,
    MaKhoa
)
```

Stores class information and the department to which each class belongs.

- LICHDAY

```sql
LICHDAY(
    MaGV,
    MaMH,
    Phong,
    MaLop,
    NgayDay,
    TuTiet,
    DenTiet,
    BaiDay,
    LyThuyet,
    GhiChu
)
```

Stores teaching schedule information, including the teacher, subject, classroom, class, teaching date, periods, lesson, theory information, and notes.

---

## 4. Requirements

The textbook exercise requires the following tasks:

1. Create a database named QLGiangDay.

2. Create the following tables:

- GIAOVIEN
- MONHOC
- PHONGHOC
- KHOA
- LOP
- LICHDAY

3. Configure primary keys and foreign keys between the tables.

4. View the relationship model between the tables.

5. Add the following columns to GIAOVIEN:

- Date of birth
- Gender
- Age

6. Add SucChua (capacity) to PHONGHOC.

7. Add the following columns to MONHOC:

- SoTC
- TCLT
- TCTH

8. Add SiSo (class size) to LOP.

9. Add integrity constraints for:

- SiSo
- SoTC
- TCLT
- TCTH
- SucChua
- TuoiGV

---

## 5. Project Files

Teaching_Management_System/
│
├── SQL/
|
├── Notes.md
├── QLGiangDay.sql
└── README.md

`QLGiangDay.sql` contains the complete SQL work for the database.

The SQL/ directory contains the separated and translated SQL scripts used for the project.

---

## 6. Project Workflow

The project follows this general workflow:

1. Create the database.
2. Create the tables.
3. Define primary keys.
4. Define foreign keys.
5. Review the table relationships.
6. Modify the existing tables by adding required columns.
7. Add integrity constraints.
8. Test the database.

---

## 7.  Current Progress

Database creation: ✅ Completed
Table creation: ✅ Completed
Primary keys: ✅ Completed
Foreign keys: ✅ Completed
Table relationships: ✅ Completed
Additional columns: ✅ Completed
Integrity constraints: ✅ Completed
SQL file organization: ✅ Completed

---

## 8. Notes

This project is based on the QLGiangDay exercise from the textbook.

The original Vietnamese terminology is preserved in the reference notes, while the separated SQL files use English naming for tables, columns, and constraints.

The project will be expanded gradually as additional exercises are reviewed and implemented.