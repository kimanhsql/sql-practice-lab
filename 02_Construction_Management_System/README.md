# Construction Management System

This project is a SQL Server database project based on the `QLCongTrinh` exercises from the *Database Fundamentals* textbook (`TH1207_GT.pdf`, pages 99–100).

---

## 1. Database Overview & Structure

**Database:** `QL_CONGTRINH`

The database consists of 7 core tables managing information about architects, contractors, clients, workers, construction projects, worker participation, and project design assignments.


### Table List

```text
KTRUCSU
CHUTHAU
CHUNHAN
CONGNHAN
CONGTRINH
THAMGIA
THIETKE
```


### Detailed Table Specifications & Constraints Note

* **Primary Keys (PK):** Described conceptually based on entity attributes and relationships in the textbook.
* **Foreign Keys (FK):** Described through business relationships and entity references in the textbook source, though explicit foreign key names or actions are not defined in the original text.
* **Nullability:** Attributes without explicit requirements default to allowing `NULL` values unless constrained by business rules.


#### 1.1 KTRUCSU (Architects)

* **Attributes & Data Types:** `HOTEN_KTS`, `NAMS_KTS`, `PHAI`, `NOI_TN`, `DCHI_LL_KTS`
* **Primary Key:** Described in database design (Architect name/ID attributes)
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages personal and contact details of architects.

---

#### 1.2 CHUTHAU (Contractors)

* **Attributes & Data Types:** `TEN_THAU`, `TEL`, `DCHI_THAU`
* **Primary Key:** `TEN_THAU`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages contractor contact information.

---

#### 1.3 CHUNHAN (Clients / Owners)

* **Attributes & Data Types:** `TEN_CHU`, `DCHI_CHU`
* **Primary Key:** `TEN_CHU`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages client names and addresses.

---

#### 1.4 CONGNHAN (Workers)

* **Attributes & Data Types:** `HOTEN_CN`, `NAMS_CN`, `NAM_VAO_N`, `CH_MON`
* **Primary Key:** Described in database design
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages worker profiles, birth years, entry years, and specializations (`CH_MON`).

---

#### 1.5 CONGTRINH (Construction Projects)

* **Attributes & Data Types:** `STT_CTR`, `TEN_CTR`, `DCHI_CTR`, `TINH_THANH`, `KINH_PHI`, `TEN_CHU`, `TEN_THAU`, `NGAY_BD`
* **Primary Key:** `STT_CTR`
* **Foreign Keys:** `TEN_CHU` (references `CHUNHAN`), `TEN_THAU` (references `CHUTHAU`)
* **Constraints & Business Rules:** Manages project budgets (`KINH_PHI`), locations, start dates, and associated clients/contractors.

---

#### 1.6 THAMGIA (Worker Participation)

* **Attributes & Data Types:** `HOTEN_CN`, `STT_CTR`, `NGAY_TGIA`, `SO_NGAY`
* **Primary Key:** Composite key (`HOTEN_CN`, `STT_CTR`)
* **Foreign Keys:** `HOTEN_CN` (references `CONGNHAN`), `STT_CTR` (references `CONGTRINH`)
* **Constraints & Business Rules:** Tracks worker participation dates and total days (`SO_NGAY`) spent on each project.

---

#### 1.7 THIETKE (Architectural Design Assignments)

* **Attributes & Data Types:** `HOTEN_KTS`, `STT_CTR`, `THU_LAO`
* **Primary Key:** Composite key (`HOTEN_KTS`, `STT_CTR`)
* **Foreign Keys:** `HOTEN_KTS` (references `KTRUCSU`), `STT_CTR` (references `CONGTRINH`)
* **Constraints & Business Rules:** Tracks design fees (`THU_LAO`) for architects assigned to specific projects.

---

## 2. Textbook Exercises & Requirements

### PART I: DATA DEFINITION LANGUAGE (DDL)

*(Pages 99–100)*

* **Project Name:** Construction Management Database (`QL_CONGTRINH`)
* **Requirements:**
1. Create the database named `QL_CONGTRINH`.
2. Create all 7 tables in the database: `KTRUCSU`, `CHUTHAU`, `CHUNHAN`, `CONGNHAN`, `CONGTRINH`, `THAMGIA`, `THIETKE`.
3. Establish relational links (Foreign Keys) among the tables.
4. View the entity relationship diagram (ERD) of the database.

---

## 3. Project Structure & Workflow

```text
02_Construction Management System/
├── SQL/
├── QLCongTrinh.sql
└── README.md
```

* **Workflow:**
1. Analyze database requirements from the textbook.
2. Create the database and tables with appropriate constraints.
3. Define primary keys, foreign keys, and relationships.
4. Organize SQL scripts and finalize project documentation.

---

## 4. Current Progress

* [x] Database analysis
* [x] Database creation
* [x] Table creation
* [x] Primary keys, foreign keys, and constraints
* [x] SQL script organization
* [x] Project documentation (`README.md`)