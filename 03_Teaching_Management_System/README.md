# Teaching Management System

This project is a SQL Server database project based on the `QLGiangDay` exercises from the *Database Fundamentals* textbook (`TH1207_GT.pdf`, page 100).

---

## 1. Database Overview & Structure

**Database:** `QLGiangDay`

The database consists of 6 core tables managing information about teachers, subjects, classrooms, departments, classes, and teaching schedules.


### Table List

```text
GIAOVIEN
MONHOC
PHONGHOC
KHOA
LOP
LICHDAY
```


### Detailed Table Specifications & Constraints Note

* **Primary Keys (PK):** Explicitly defined or derived from entity attributes and relationships in the textbook.
* **Foreign Keys (FK):** Described through structural links between tables (e.g., teacher belongs to a department, class belongs to a department, schedule links teacher, subject, classroom, and class).
* **Schema Modifications & Constraints:** Additional attributes (`NgaySinh`, `GioiTinh`, `Tuoi`, `SucChua`, `SoTC`, `TCLT`, `TCTH`, `SiSo`) and integrity constraints are explicitly required to be added via DDL modification statements (`ALTER TABLE`).


#### 1.1 GIAOVIEN (Teachers)

* **Attributes & Data Types:** `MaGV`, `HoTen`, `MaKhoa` *(Plus added columns: `NgaySinh`, `GioiTinh`, `Tuoi`)*
* **Primary Key:** `MaGV`
* **Foreign Keys:** `MaKhoa` (references `KHOA`)
* **Constraints & Business Rules:** Manages teacher profiles, departmental affiliations, personal attributes, and age constraints (`TuoiGV`).

---

#### 1.2 MONHOC (Subjects)

* **Attributes & Data Types:** `MaMH`, `TenMH` *(Plus added columns: `SoTC`, `TCLT`, `TCTH`)*
* **Primary Key:** `MaMH`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages subject details, total credits (`SoTC`), theory credits (`TCLT`), and practical credits (`TCTH`).

---

#### 1.3 PHONGHOC (Classrooms)

* **Attributes & Data Types:** `Phong`, `ChucNang` *(Plus added column: `SucChua`)*
* **Primary Key:** `Phong`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages classroom identifiers, functions, and capacity (`SucChua`).

---

#### 1.4 KHOA (Departments)

* **Attributes & Data Types:** `MaKhoa`, `TenKhoa`
* **Primary Key:** `MaKhoa`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages academic department information.

---

#### 1.5 LOP (Classes)

* **Attributes & Data Types:** `MaLop`, `TenLop`, `MaKhoa` *(Plus added column: `SiSo`)*
* **Primary Key:** `MaLop`
* **Foreign Keys:** `MaKhoa` (references `KHOA`)
* **Constraints & Business Rules:** Manages class profiles, departmental links, and class size (`SiSo`).

---

#### 1.6 LICHDAY (Teaching Schedules)

* **Attributes & Data Types:** `MaGV`, `MaMH`, `Phong`, `MaLop`, `NgayDay`, `TuTiet`, `DenTiet`, `BaiDay`, `LyThuyet`, `GhiChu`
* **Primary Key:** Composite key based on scheduling attributes (`MaGV`, `MaMH`, `Phong`, `MaLop`, `NgayDay`, `TuTiet`)
* **Foreign Keys:** `MaGV` (references `GIAOVIEN`), `MaMH` (references `MONHOC`), `Phong` (references `PHONGHOC`), `MaLop` (references `LOP`)
* **Constraints & Business Rules:** Tracks teaching assignments, schedule periods, and lesson details.

---

## 2. Textbook Exercises & Requirements

### PART I: DATA DEFINITION LANGUAGE (DDL) & SCHEMA MODIFICATION

*(Page 100)*

* **Project Name:** Teaching Management Database (`QLGiangDay`)
* **Requirements:**
1. Create the database named `QLGiangDay`.
2. Create all required tables (`GIAOVIEN`, `MONHOC`, `PHONGHOC`, `KHOA`, `LOP`, `LICHDAY`) with primary key and foreign key constraints.
3. Review and view the relationship model (ERD) among the tables.
4. Add columns for date of birth, gender, and age (`NgaySinh`, `GioiTinh`, `Tuoi`) to the `GIAOVIEN` table.
5. Add the capacity column (`SucChua`) to the `PHONGHOC` table.
6. Add credit columns (`SoTC`, `TCLT`, `TCTH`) to the `MONHOC` table.
7. Add the class size column (`SiSo`) to the `LOP` table.
8. Define integrity constraints for `SiSo`, `SoTC`, `TCLT`, `TCTH`, `SucChua`, and `TuoiGV`.

---

## 3. Project Structure & Workflow

```text
03_Teaching_Management_System/
├── SQL/
├── QLGiangDay.sql
└── README.md
```

* **Workflow:**
1. Analyze database requirements from the textbook.
2. Create the database and tables with appropriate constraints.
3. Review table relationships.
4. Modify schema by adding new columns (`ALTER TABLE`).
5. Implement data integrity constraints (`CHECK`, `DEFAULT`, etc.).
6. Organize SQL scripts and finalize project documentation.

---

## 4. Current Progress

* [x] Database creation
* [x] Table creation
* [x] Primary keys, foreign keys, and constraints
* [x] Table relationship review
* [x] Additional columns setup (`ALTER TABLE`)
* [x] Integrity constraints implementation
* [x] SQL script organization
* [x] Project documentation (`README.md`)