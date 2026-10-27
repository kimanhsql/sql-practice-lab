# Football League Management System

This project is a SQL Server database project based on the `QLBongDa` exercises from the *Database Fundamentals* textbook (`TH1207_GT.pdf`, pages 96–99 and 105–108).

---

## 1. Database Overview & Structure

**Database:** `QLBongDa`

The database consists of 9 core tables managing information about countries, stadiums, provinces, clubs, players, coaches, club-coaches, matches, and standings.


### Table List

```text
QUOCGIA
SANVD
TINH
CAULACBO
CAUTHU
HUANLV
HLV_CLB
TRANDAU
BANGXH
```


### Detailed Table Specifications & Constraints Note

- **Primary Keys (PK):** Explicitly defined in the textbook for all tables (including composite keys for `HLV_CLB` and `BANGXH`).
- **Foreign Keys (FK):** Described conceptually through business relationships in the textbook (e.g., a player belongs to a club and a country), though explicit foreign key names or `ON DELETE / ON UPDATE` actions are not specified in the source tables.
- **Nullability:** Attributes marked as **NOT NULL** are strictly enforced. Unmarked attributes (such as `NGAYSINH`, `DIACHI`, `DIENTHOAI`) default to allowing `NULL` values unless constrained by business rules.
- **Identity:** `MACT` (in `CAUTHU`) and `MATRAN` (in `TRANDAU`) are auto-incrementing fields.


#### 1.1 CAUTHU (Players)

* **Attributes & Data Types:** `MACT` (NUMERIC, Identity), `HOTEN` (NVARCHAR(100)), `VITRI` (NVARCHAR(20)), `NGAYSINH` (DATETIME), `DIACHI` (NVARCHAR(200)), `MACLB` (VARCHAR(5)), `MAQG` (VARCHAR(5)), `SO` (INT)
* **Primary Key:** `MACT`
* **Foreign Keys:** `MACLB` (references `CAULACBO`), `MAQG` (references `QUOCGIA`)
* **Constraints & Business Rules:**
`NOT NULL`: `HOTEN`, `VITRI`, `MACLB`, `MAQG`, `SO`.
`VITRI` restricted to: `'Thủ môn'`, `'Tiền đạo'`, `'Tiền vệ'`, `'Trung vệ'`, `'Hậu vệ'`.

Players in the same club must have unique shirt numbers (`SO`).

---

#### 1.2 QUOCGIA (Countries)

* **Attributes & Data Types:** `MAQG` (VARCHAR(5)), `TENQG` (NVARCHAR(60))
* **Primary Key:** `MAQG`
* **Foreign Keys:** None
* **Constraints & Business Rules:**
* `NOT NULL`: `TENQG`.
* `TENQG` must be unique.

---

#### 1.3 CAULACBO (Clubs)

* **Attributes & Data Types:** `MACLB` (VARCHAR(5)), `TENCLB` (NVARCHAR(100)), `MASAN` (VARCHAR(5)), `MATINH` (VARCHAR(5))
* **Primary Key:** `MACLB`
* **Foreign Keys:** `MASAN` (references `SANVD`), `MATINH` (references `TINH`)
* **Constraints & Business Rules:**
* `NOT NULL`: `TENCLB`, `MASAN`, `MATINH`.

Each club can register a maximum of 8 foreign players.

---

#### 1.4 TINH (Provinces)

* **Attributes & Data Types:** `MATINH` (VARCHAR(5)), `TENTINH` (NVARCHAR(100))
* **Primary Key:** `MATINH`
* **Foreign Keys:** None
* **Constraints & Business Rules:**
* `NOT NULL`: `TENTINH`.
* `TENTINH` must be unique.

---

#### 1.5 SANVD (Stadiums)

* **Attributes & Data Types:** `MASAN` (VARCHAR(5)), `TENSAN` (NVARCHAR(100)), `DIACHI` (NVARCHAR(200))
* **Primary Key:** `MASAN`
* **Foreign Keys:** None
* **Constraints & Business Rules:**
* `NOT NULL`: `TENSAN`.
* `TENSAN` must be unique.

---

#### 1.6 HUANLV (Coaches)

* **Attributes & Data Types:** `MAHLV` (VARCHAR(5)), `TENHLV` (NVARCHAR(100)), `NGAYSINH` (DATETIME), `DIACHI` (NVARCHAR(200)), `DIENTHOAI` (NVARCHAR(20)), `MAQG` (VARCHAR(5))
* **Primary Key:** `MAHLV`
* **Foreign Keys:** `MAQG` (references `QUOCGIA`)
* **Constraints & Business Rules:**
* `NOT NULL`: `TENHLV`, `MAQG`.

---

#### 1.7 HLV_CLB (Coach-Club Assignment)

* **Attributes & Data Types:** `MAHLV` (VARCHAR(5)), `MACLB` (VARCHAR(5)), `VAITRO` (NVARCHAR(100))
* **Primary Key:** Composite key (`MAHLV`, `MACLB`)
* **Foreign Keys:** `MAHLV` (references `HUANLV`), `MACLB` (references `CAULACBO`)
* **Constraints & Business Rules:**
* `NOT NULL`: `VAITRO`.
* `VAITRO` restricted to: `'HLV chính'`, `'HLV phụ'`, `'HLV thể lực'`, `'HLV thủ môn'`.

Each club can have a maximum of 2 head coaches (`'HLV chính'`).

---

#### 1.8 TRANDAU (Matches)

* **Attributes & Data Types:** `MATRAN` (NUMERIC, Identity), `NAM` (INT), `VONG` (INT), `NGAYTD` (DATETIME), `MACLB1` (VARCHAR(5)), `MACLB2` (VARCHAR(5)), `MASAN` (VARCHAR(5)), `KETQUA` (VARCHAR(5))
* **Primary Key:** `MATRAN`
* **Foreign Keys:** `MACLB1`, `MACLB2` (reference `CAULACBO`), `MASAN` (references `SANVD`)
* **Constraints & Business Rules:**
* `NOT NULL`: `NAM`, `VONG`, `MACLB1`, `MACLB2`, `MASAN`, `KETQUA`.

---

#### 1.9 BANGXH (Standings)

* **Attributes & Data Types:** `MACLB` (VARCHAR(5)), `NAM` (INT), `VONG` (INT), `SOTRAN` (INT), `THANG` (INT), `HOA` (INT), `THUA` (INT), `HIEUSO` (VARCHAR(5)), `DIEM` (INT), `HANG` (INT)
* **Primary Key:** Composite key (`MACLB`, `NAM`, `VONG`)
* **Foreign Keys:** `MACLB` (references `CAULACBO`)
* **Constraints & Business Rules:**
* `NOT NULL`: All performance metrics (`SOTRAN`, `THANG`, `HOA`, `THUA`, `HIEUSO`, `DIEM`, `HANG`).

---

## 2. Textbook Exercises & Requirements

### PART I: DATA DEFINITION LANGUAGE (DDL)

*(Pages 96–99)*

* **Project Name:** Football League Management Database (`QLBongDa`)
* **Requirements:**
1. Create the database named `QLBongDa`.
2. Create all 9 tables: `CAUTHU`, `QUOCGIA`, `CAULACBO`, `TINH`, `HUANLV`, `HLV_CLB`, `TRANDAU`, `BANGXH`.
3. Establish relational links (Foreign Keys) among the tables.

---

### PART II: DATA MANIPULATION LANGUAGE (DML)

*(Pages 105–108)*

* **Requirements:**
1. Insert sample data into all tables: `CAUTHU`, `QUOCGIA`, `CAULACBO`, `TINH`, `SANVD`, `HUANLV`, `HLV_CLB`, `TRANDAU`, `BANGXH`.
2. Delete the player named 'Nguyễn Vũ Phong'.
3. Delete all players older than 40 years.
4. Delete players older than 35 in the club 'BBD'.
5. Delete players older than 35 in the club 'BECAMEX BÌNH DƯƠNG'.
6. Update the playing position of player 'Nguyễn Trường Sơn' to 'Tiền đạo' (Forward).
7. Update the address of coach 'Lê Huỳnh Đức' to 'TP.HCM'.
8. Swap the playing positions between player 'Nguyễn Công Vinh' and player 'Trần Tấn Tài'.
9. Assign a new coach 'Nguyễn Đức Thắng' to the club 'GẠCH ĐỒNG TÂM LONG AN'.
10. Rename the club 'BECAMEX BÌNH DƯƠNG' to 'BÌNH DƯƠNG'.

---

## 3. Project Structure & Workflow

```text
01_Football League Management System/
├── Images/
├── SQL/
├── QLBongDa.sql
└── README.md
```

* **Workflow:**
1. Analyze database requirements from the textbook.
2. Create the database and tables with appropriate constraints.
3. Insert and verify sample data.
4. Execute and document DML exercises.
5. Organize SQL scripts and finalize documentation.

---

## 4. Current Progress

* [x] Database creation
* [x] Table creation
* [x] Primary keys, foreign keys, and constraints
* [x] Sample data setup
* [x] DML exercises execution
* [x] SQL script organization
* [x] Project documentation (`README.md`)