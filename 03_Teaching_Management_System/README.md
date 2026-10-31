# Teaching Management System

This project is a SQL Server database project based on the `QLGiangDay` exercises from the *Database Fundamentals* textbook (`TH1207_GT.pdf`, page 100).

---

## 1. Database Overview & Structure

**Database:** `TEACHING_DB` (based on `QLGiangDay`)

The database consists of 6 core tables managing information about teachers, subjects, classrooms, departments, classes, and teaching schedules.


### Table List

```text
DEPARTMENTS
TEACHERS
SUBJECTS
CLASSROOMS
CLASSES
TEACHING_SCHEDULE
```


### Detailed Table Specifications & Constraints Note

* **Primary Keys (PK):** Explicitly defined for all tables (including a composite key for `TEACHING_SCHEDULE`).
* **Foreign Keys (FK):** Explicitly defined linking related entities (e.g., teachers and classes to departments, teaching schedules to teachers, subjects, classrooms, and classes).
* **Nullability:** Attributes marked with `NOT NULL` are strictly enforced. Unmarked attributes default to allowing `NULL` values unless constrained by business rules.
* **Schema Modifications & Constraints:** Additional attributes (`DateOfBirth`, `Gender`, `Age`, `Capacity`, `Credits`, `TheoryCredits`, `PracticalCredits`, `ClassSize`) and integrity constraints are required to be added via DDL modification statements (`ALTER TABLE`).

---

#### 1.1 TEACHERS

* **Attributes & Data Types:** `TeacherID` (VARCHAR(5)), `FullName` (VARCHAR(100)), `DepartmentID` (VARCHAR(5)) *(Plus expected added columns: `DateOfBirth`, `Gender`, `Age`)*
* **Primary Key:** `TeacherID`
* **Foreign Keys:** `DepartmentID` (references `DEPARTMENTS`)
* **Constraints & Business Rules:** Manages teacher profiles, departmental affiliations, personal attributes, and age constraints (`TuoiGV`).

---

#### 1.2 SUBJECTS

* **Attributes & Data Types:** `SubjectID` (VARCHAR(20)), `SubjectName` (VARCHAR(200)) *(Plus expected added columns: `Credits`, `TheoryCredits`, `PracticalCredits`)*
* **Primary Key:** `SubjectID`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages subject details, total credits (`Credits`), theory credits (`TheoryCredits`), and practical credits (`PracticalCredits`).

---

#### 1.3 CLASSROOMS

* **Attributes & Data Types:** `ClassroomID` (VARCHAR(5)), `FunctionDescription` (VARCHAR(200)) *(Plus expected added column: `Capacity`)*
* **Primary Key:** `ClassroomID`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages classroom identifiers, functions, and capacity (`Capacity`).

---

#### 1.4 DEPARTMENTS

* **Attributes & Data Types:** `DepartmentID` (VARCHAR(5)), `DepartmentName` (VARCHAR(200))
* **Primary Key:** `DepartmentID`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages academic department information.

---

#### 1.5 CLASSES

* **Attributes & Data Types:** `ClassID` (VARCHAR(5)), `ClassName` (VARCHAR(200)), `DepartmentID` (VARCHAR(5)) *(Plus expected added column: `ClassSize`)*
* **Primary Key:** `ClassID`
* **Foreign Keys:** `DepartmentID` (references `DEPARTMENTS`)
* **Constraints & Business Rules:** Manages class profiles, departmental links, and class size (`ClassSize`).

---

#### 1.6 TEACHING_SCHEDULE

* **Attributes & Data Types:** `TeacherID` (VARCHAR(5)), `SubjectID` (VARCHAR(20)), `ClassroomID` (VARCHAR(5)), `ClassID` (VARCHAR(5)), `TeachingDate` (DATETIME), `StartPeriod` (INT), `EndPeriod` (INT), `Lesson` (VARCHAR(200)), `Theory` (VARCHAR(200)), `Notes` (VARCHAR(200))
* **Primary Key:** Composite key (`TeacherID`, `SubjectID`, `ClassroomID`, `ClassID`)
* **Foreign Keys:** `TeacherID` (references `TEACHERS`), `SubjectID` (references `SUBJECTS`), `ClassroomID` (references `CLASSROOMS`), `ClassID` (references `CLASSES`)
* **Constraints & Business Rules:** Tracks teaching assignments, schedule periods, and lesson details.

---

## 2. Textbook Exercises & Requirements

### PART I: DATA DEFINITION LANGUAGE (DDL) & SCHEMA MODIFICATION

*(Page 100)*

* **Project Name:** Teaching Management Database (`TEACHING_DB`)
* **Requirements:**
1. Create the database named `TEACHING_DB`.
2. Create all required tables (`DEPARTMENTS`, `TEACHERS`, `SUBJECTS`, `CLASSROOMS`, `CLASSES`, `TEACHING_SCHEDULE`) with primary key and foreign key constraints.
3. Review and view the relationship model (ERD) among the tables.
4. Add columns for date of birth, gender, and age (`DateOfBirth`, `Gender`, `Age`) to the `TEACHERS` table.
5. Add the capacity column (`Capacity`) to the `CLASSROOMS` table.
6. Add credit columns (`Credits`, `TheoryCredits`, `PracticalCredits`) to the `SUBJECTS` table.
7. Add the class size column (`ClassSize`) to the `CLASSES` table.
8. Define integrity constraints for `ClassSize`, `Credits`, `TheoryCredits`, `PracticalCredits`, `Capacity`, and teacher age.

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
2. Create the database and tables with appropriate constraints in English.
3. Review table relationships.
4. Modify schema by adding new columns (`ALTER TABLE`).
5. Implement data integrity constraints (`CHECK`, `DEFAULT`, etc.).
6. Organize SQL scripts and finalize project documentation.

---

## 4. Current Progress

* [x] Database creation
* [x] Table creation (English schema)
* [x] Primary keys, foreign keys, and constraints
* [x] Table relationship review
* [x] Additional columns setup (`ALTER TABLE`)
* [x] Integrity constraints implementation
* [x] SQL script organization
* [x] Project documentation (`README.md`)