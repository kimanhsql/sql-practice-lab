# Project Management System

This project is a SQL Server database project based on the *Project Management* database exercises (`QLDA`).


## 1. Database Overview & Structure

**Database:** `PROJECT_DB` (based on Project Management System)

The database consists of 6 core tables managing information about employees, departments, department locations, projects, project assignments (working hours), and employee dependents.


### Table List

```text
EMPLOYEES
DEPARTMENTS
DEPARTMENT_LOCATIONS
PROJECTS
WORKS_ON
DEPENDENTS
```


### Detailed Table Specifications & Constraints Note

* **Primary Keys (PK):** Explicitly defined for all tables (including composite keys for `DEPARTMENT_LOCATIONS`, `WORKS_ON`, and `DEPENDENTS`).
* **Foreign Keys (FK):** Explicitly defined linking related entities (e.g., employees to departments and supervisors, departments to managers, department locations and projects to departments, works-on assignments to employees and projects, dependents to employees).
* **Nullability & Business Rules:** Attributes marked with `NOT NULL` are strictly enforced. Special business rules govern gender values (`Male`/`Female`), salary thresholds, supervisor/department hierarchies, project timelines, and weekly working hours per project.

---

#### 1.1 EMPLOYEES (`NHANVIEN`)

* **Attributes & Data Types:** `EmployeeID` (`MANV`), `LastName` (`HONV`), `MiddleName` (`TENLOT`), `FirstName` (`TENNV`), `DateOfBirth` (`NGSINH`), `Address` (`DCHI`), `Gender` (`PHAI`), `Salary` (`LUONG` / `MLUONG`), `SupervisorID` (`MA_NQL` / `MANQL`), `DepartmentID` (`PHONG`)
* **Primary Key:** `EmployeeID`
* **Foreign Keys:** `SupervisorID` (self-referencing `EMPLOYEES`), `DepartmentID` (references `DEPARTMENTS`)
* **Constraints & Business Rules:** Each employee has a unique ID, full name components, birth date, address, gender, salary, optional direct supervisor, and assigned department.

---

#### 1.2 DEPARTMENTS (`PHONGBAN`)

* **Attributes & Data Types:** `DepartmentID` (`MAPHG` / `MAPH`), `DepartmentName` (`TENPHG`), `ManagerID` (`TRGPHG` / `TRPHG`), `StartDate` (`NG_NHANCHUC` / `NGNC`)
* **Primary Key:** `DepartmentID`
* **Foreign Keys:** `ManagerID` (references `EMPLOYEES`)
* **Constraints & Business Rules:** Each department has a unique code and name, led by a manager who has a recorded appointment start date.

---

#### 1.3 DEPARTMENT_LOCATIONS (`DIADIEMPHG`)

* **Attributes & Data Types:** `DepartmentID` (`MAPHG`), `Location` (`DIADIEM`)
* **Primary Key:** Composite key (`DepartmentID`, `Location`)
* **Foreign Keys:** `DepartmentID` (references `DEPARTMENTS`)
* **Constraints & Business Rules:** A department can operate across multiple locations.

---

#### 1.4 PROJECTS (`DEAN`)

* **Attributes & Data Types:** `ProjectID` (`MADA`), `ProjectName` (`TENDA`), `ProjectLocation` (`DDIEM_DA` / `DDIEMDA`), `DepartmentID` (`PHONG`), `StartDate` (`NGBD_DA`), `EndDate` (`NGKT_DA`)
* **Primary Key:** `ProjectID`
* **Foreign Keys:** `DepartmentID` (references `DEPARTMENTS`)
* **Constraints & Business Rules:** Each project has a unique ID, name, location, sponsoring/leading department, start date, and end date.

---

#### 1.5 WORKS_ON (`PHANCONG`)

* **Attributes & Data Types:** `EmployeeID` (`MANV`), `ProjectID` (`MADA`), `Hours` (`THOIGIAN`)
* **Primary Key:** Composite key (`EmployeeID`, `ProjectID`)
* **Foreign Keys:** `EmployeeID` (references `EMPLOYEES`), `ProjectID` (references `PROJECTS`)
* **Constraints & Business Rules:** Tracks weekly working hours (`Hours`) spent by each employee on each assigned project.

---

#### 1.6 DEPENDENTS (`THANNHAN`)

* **Attributes & Data Types:** `EmployeeID` (`MANV`), `DependentID` (`MATN`), `LastName` (`HOTN`), `FirstName` (`TENTN`), `Gender` (`PHAI`), `DateOfBirth` (`NGAYSINH`), `Relationship` (`QUANHE`)
* **Primary Key:** Composite key (`EmployeeID`, `DependentID`)
* **Foreign Keys:** `EmployeeID` (references `EMPLOYEES`)
* **Constraints & Business Rules:** Tracks an employee's dependents with a unique dependent ID per employee, name, gender, birth date, and relationship.

---

## 2. Textbook Exercises & Requirements

### PART I: DATA DEFINITION LANGUAGE (DDL) & INTEGRITY CONSTRAINTS

* Create all 6 relations (`EMPLOYEES`, `DEPARTMENTS`, `DEPARTMENT_LOCATIONS`, `PROJECTS`, `WORKS_ON`, `DEPENDENTS`) with appropriate primary and foreign keys.
* Enforce domain constraints on gender, salaries, dates, weekly working hours, and department/manager/project relationships.

---

### PART II: DATA QUERYING LANGUAGE (DQL) - 55 EXERCISES

1. Find employees (`MANV`, `HONV`, `TENLOT`, `TENNV`) working in department `'NC'`.
2. Find employees (`MANV`, `HONV`, `TENLOT`, `TENNV`, `PHAI`) with a salary greater than `2,000,000`.
3. Find employee full names and their department names for employees earning between `2,000,000` and `3,000,000`.
4. Find employees earning over `2,500,000` in department `'NC'` or over `3,000,000` in department `'DH'`.
5. List the full names of employees located in `'Tp HCM'`.
6. List the full names of employees whose last name (`HONV`) starts with `'N'`.
7. Retrieve the birth date and address of employee `'Đinh Bá Tiến'`.
8. List employees born between `1960` and `1965`.
9. List employees along with their ages.
10. List dependents under 18 years old for employees with ID `'001'`.
11. List all female employees over 30 years old.
12. For each department, list the department name and department location(s).
13. Find the names of the managers for each department.
14. Retrieve `TENDA`, `MADA`, `DDIEM_DA`, `TENPHG`, `MAPHG`, `TRPHG`, and `NGNC`.
15. Find the name and address of all employees in the `'Nghiên cứu'` department.
16. Find the names of female employees and the names of their dependents.
17. Find the ID and name of employees in the `'Nghiên Cứu'` department working on the `'Tin Học Hóa'` project for `20` hours/week.
18. For every project in `'Hà Nội'`, list the project ID (`MADA`) and the name of the department leading the project.
19. For each project in `'Hà Nội'`, list the project name, department name, and the manager's full name and appointment start date.
20. For each project in `'Hà Nội'`, list the department (`PHONG`), manager's full name (`HONV`, `TENLOT`, `TENNV`), address (`DCHI`), and birth date (`NGSINH`).
21. For each employee, list the employee's full name and the full name of their direct supervisor.
22. For each employee, list the employee's full name and the full name of the manager of the department they work in.
23. List employee full names (`HONV`, `TENLOT`, `TENNV`) and the names of the projects they participate in (if any).
24. List the names of projects that employee `'Đinh Bá Tiến'` participates in.
25. Count the total number of projects in the company.
26. Count the number of projects led by the `'Nghiên Cứu'` department.
27. Calculate the average salary of all female employees.
28. Count the number of dependents of employee `'Đinh Bá Tiến'`.
29. For each project, list the project name (`TENDA`) and the total weekly working hours of all employees on that project.
30. For each project, list how many employees participate in it.
31. For each project, list the project name and the number of tasks/assignments on that project.
32. For each task/assignment in project `'Đào Tạo'`, list the number of assigned employees.
33. For each employee, list their full name and how many dependents they have.
34. For each employee, list the number of employees they directly supervise.
35. For each department, list the department name (`TENPHG`) and the average salary of employees working in that department.
36. For departments with an average salary over `30,000`, list the department name and the number of employees in that department.
37. For each department, list the department name and the number of projects it leads.
38. For each department, list the department name, manager's full name, and the number of projects it leads.
39. List the number of projects taking place at each location.
40. List project IDs (`MADA`) that have a worker with last name (`HONV`) `'Dinh'` or a leading department manager with last name (`HONV`) `'Dinh'`.
41. List employees (`HONV`, `TENLOT`, `TENNV`) who have more than 2 dependents.
42. List employees (`HONV`, `TENLOT`, `TENNV`) who have no dependents.
43. List department managers (`HONV`, `TENLOT`, `TENNV`) who have at least one dependent.
44. Find the last name (`HONV`) of department managers who have no dependents/family records.
45. List employee full names (`HONV`, `TENLOT`, `TENNV`) earning more than the average salary of the `'Nghiên cứu'` department.
46. List the department name and manager's full name for the department with the most employees.
47. Find the full name (`HONV`, `TENLOT`, `TENNV`) and address (`DCHI`) of employees working on a project in `'TP HCM'` whose department is not located in `'TP HCM'`.
48. Generalize Query 47: find the full name and address of employees working on a project in a city whose department is not located in that city.
49. List employees (`HONV`, `TENLOT`, `TENNV`) working on every project of the company.
50. List employees (`HONV`, `TENLOT`, `TENNV`) assigned to all projects led by the `'Nghien cuu'` department.
51. Find the full names of employees who participate in all projects led by their own department.
52. Find employees (`HONV`, `TENLOT`, `TENNV`) assigned to all projects that employee `'Đinh Bá Tiến'` works on.
53. List employees assigned to all tasks/assignments in project `'Sản phẩm X'`.
54. List employees participating in all projects located in `'TP HCM'`.
55. List the department(s) leading all projects located in `'TP HCM'`.

---

## 3. Project Structure & Workflow

```text
07_Project_Management_System/
├── SQL/
├── QLDeAn.sql
└── README.md
```

* **Workflow:**

1. Analyze database requirements from the textbook.
2. Create database, tables, primary keys, and foreign keys in English.
3. Implement schema modifications and integrity constraints (`ALTER TABLE`, `CHECK`, `TRIGGERS`).
4. Perform data insertion and DML updates.
5. Execute and verify all 55 data querying tasks.
6. Organize SQL scripts and finalize project documentation.

---

## 4. Current Progress

* [x] Database analysis
* [x] Database creation (English schema)
* [x] Table creation, primary keys, and foreign keys
* [x] Sample data setup
* [x] DML exercises execution & updates
* [ ] 55 SQL queries implementation and verification
* [x] Integrity constraints & Triggers implementation
* [x] SQL script organization
* [x] Project documentation (`README.md`)