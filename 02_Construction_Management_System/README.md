# Construction Management System

This project is a SQL Server database project based on the `QLCongTrinh` exercises from the *Database Fundamentals* textbook (`TH1207_GT.pdf`, pages 99–100).

---

## 1. Database Overview & Structure

**Database:** `CONSTRUCTION_DB` (based on `QL_CONGTRINH`)

The database consists of 7 core tables managing information about architects, contractors, clients, workers, construction projects, worker participation, and project design assignments.


### Table List

```text
ARCHITECTS
CONTRACTORS
CLIENTS
WORKERS
CONSTRUCTION_PROJECTS
WORKER_PARTICIPATION
PROJECT_DESIGN
```


### Detailed Table Specifications & Constraints Note

* **Primary Keys (PK):** Explicitly defined for all tables (including composite keys for `WORKER_PARTICIPATION` and `PROJECT_DESIGN`).
* **Foreign Keys (FK):** Explicitly defined linking related entities (e.g., projects to clients and contractors, participation to workers and projects, design assignments to architects and projects).
* **Nullability:** Attributes marked with `NOT NULL` are strictly enforced. Unmarked attributes default to allowing `NULL` values unless constrained by business rules.
* **Identity:** `ProjectID` (in `CONSTRUCTION_PROJECTS`) is an auto-incrementing field.

---

#### 1.1 ARCHITECTS

* **Attributes & Data Types:** `ArchitectName` (NVARCHAR(100)), `BirthYear` (INT), `Gender` (NVARCHAR(3)), `GraduationPlace` (NVARCHAR(200)), `ContactAddress` (NVARCHAR(200))
* **Primary Key:** `ArchitectName`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages personal and contact details of architects.

---

#### 1.2 CONTRACTORS

* **Attributes & Data Types:** `ContractorName` (NVARCHAR(100)), `PhoneNumber` (NVARCHAR(20)), `Address` (NVARCHAR(200))
* **Primary Key:** `ContractorName`
* **Foreign Keys:** None
* **Constraints & Business Rules:**
* `NOT NULL`: `PhoneNumber`.
* Manages contractor contact information.

---

#### 1.3 CLIENTS

* **Attributes & Data Types:** `ClientName` (NVARCHAR(100)), `Address` (NVARCHAR(200))
* **Primary Key:** `ClientName`
* **Foreign Keys:** None
* **Constraints & Business Rules:**
* `NOT NULL`: `Address`.
* Manages client names and addresses.

---

#### 1.4 WORKERS

* **Attributes & Data Types:** `WorkerName` (NVARCHAR(100)), `BirthYear` (INT), `CareerStartDate` (DATETIME), `Specialty` (NVARCHAR(200))
* **Primary Key:** `WorkerName`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages worker profiles, birth years, career start dates, and specializations (`Specialty`).

---

#### 1.5 CONSTRUCTION_PROJECTS

* **Attributes & Data Types:** `ProjectID` (NUMERIC, Identity), `ProjectName` (NVARCHAR(200)), `ProjectAddress` (NVARCHAR(200)), `Province` (NVARCHAR(100)), `Budget` (FLOAT), `ClientName` (NVARCHAR(100)), `ContractorName` (NVARCHAR(100)), `StartDate` (DATETIME)
* **Primary Key:** `ProjectID`
* **Foreign Keys:** `ClientName` (references `CLIENTS`), `ContractorName` (references `CONTRACTORS`)
* **Constraints & Business Rules:**
* `NOT NULL`: `ProjectName`, `ClientName`, `ContractorName`.
* Manages project budgets (`Budget`), locations, start dates, and associated clients/contractors.

---

#### 1.6 WORKER_PARTICIPATION

* **Attributes & Data Types:** `WorkerName` (NVARCHAR(100)), `ProjectID` (NUMERIC), `ParticipationDate` (DATETIME), `NumberOfDays` (INT)
* **Primary Key:** Composite key (`WorkerName`, `ProjectID`)
* **Foreign Keys:** `WorkerName` (references `WORKERS`), `ProjectID` (references `CONSTRUCTION_PROJECTS`)
* **Constraints & Business Rules:** Tracks worker participation dates and total days (`NumberOfDays`) spent on each project.

---

#### 1.7 PROJECT_DESIGN

* **Attributes & Data Types:** `ArchitectName` (NVARCHAR(100)), `ProjectID` (NUMERIC), `DesignFee` (FLOAT)
* **Primary Key:** Composite key (`ArchitectName`, `ProjectID`)
* **Foreign Keys:** `ArchitectName` (references `ARCHITECTS`), `ProjectID` (references `CONSTRUCTION_PROJECTS`)
* **Constraints & Business Rules:** Tracks design fees (`DesignFee`) for architects assigned to specific projects.

---

## 2. Textbook Exercises & Requirements

### PART I: DATA DEFINITION LANGUAGE (DDL)

*(Pages 99–100)*

* **Project Name:** Construction Management Database (`CONSTRUCTION_DB`)
* **Requirements:**
1. Create the database named `CONSTRUCTION_DB`.
2. Create all 7 tables in the database: `ARCHITECTS`, `CONTRACTORS`, `CLIENTS`, `WORKERS`, `CONSTRUCTION_PROJECTS`, `WORKER_PARTICIPATION`, `PROJECT_DESIGN`.
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
2. Create the database and tables with appropriate constraints in English.
3. Define primary keys, foreign keys, and relationships.
4. Organize SQL scripts and finalize project documentation.

---

## 4. Current Progress

* [x] Database analysis
* [x] Database creation
* [x] Table creation (English schema)
* [x] Primary keys, foreign keys, and constraints
* [x] SQL script organization
* [x] Project documentation (`README.md`)