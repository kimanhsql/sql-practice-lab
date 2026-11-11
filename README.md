# SQL Practice Lab

Welcome to my **SQL Practice Lab** repository! This collection documents my journey learning, designing databases, enforcing integrity constraints, writing triggers, and solving complex querying problems (DQL) using Microsoft SQL Server (T-SQL).

---

## Repository Structure

```text
sql-practice-lab/
├── 01_Football_League_Management_System/
|   ├── Images/
|   ├── SQL/
│   ├── QLBongDa.sql
│   └── README.md
|
├── 02_Construction_Management_System/
|   ├── SQL/
│   ├── QLCongTrinh.sql
│   └── README.md
|
├── 03_Teaching_Management_System/
|   ├── SQL/
│   ├── QLGiangDay.sql
│   └── README.md
|
├── 04_Sales_Management_System/
|   ├── Images/
|   ├── SQL/
│   ├── QLHangHoa.sql
│   └── README.md
|
├── 05_Student_Management_System/
|   ├── Images/
|   ├── SQL/
│   ├── QLHocVien.sql
│   └── README.md
|
├── 06_Flight_Management_System/
|   ├── Images/
|   ├── SQL/
│   ├── QLChuyenBay.sql
│   └── README.md
|
├── 07_Project_Management_System/
|   ├── Images/
|   ├── SQL/
│   ├── QLDeAn.sql
│   └── README.md
└── README.md
```

---

## Projects Included

### 1. Football League Management System (`FOOTBALL_LEAGUE_DB`)

* **Overview:** Manages football league operations, including teams, players, matches, match schedules, stadiums, and tournament rankings.
* **Key Highlights:** Handles match results, point calculations, standings tables, and player performance tracking.

### 2. Construction Management System (`CONSTRUCTION_DB`)

* **Overview:** Tracks construction projects, contractors, workers, materials, equipment allocation, and site assignments.
* **Key Highlights:** Manages resource distribution across multiple job sites and tracks project cost and progress.

### 3. Teaching Management System (`TEACHING_DB`)

* **Overview:** Oversees academic teaching schedules, instructors, classrooms, courses, and student enrollments.
* **Key Highlights:** Manages teacher-course assignments, room scheduling conflicts, and academic allocation.

### 4. Sales Management System (`SALES_DB`)

* **Overview:** Handles retail/wholesale operations including products, categories, customers, sales orders, invoices, and employee sales performance.
* **Key Highlights:** Implements relational order processing, calculates total invoice values, and tracks inventory levels.

### 5. Student Management System (`STUDENT_DB`)

* **Overview:** A comprehensive database schema managing departments, subjects, prerequisite rules, teachers, classes, students, teaching schedules, and exam results.
* **Key Highlights:** Strict validation constraints, advanced business logic via Triggers (e.g., prerequisite order enforcement), and 35+ complex DQL solutions.

### 6. Flight Management System (`FLIGHT_DB`)

* **Overview:** A robust relational database managing airline operations including customers, employees (pilots and flight attendants), aircraft types, specific aircraft, flights, flight schedules, bookings, pilot capabilities, and crew assignments.
* **Key Highlights:** Role-based employee classification, complex composite primary/foreign keys, and 56 advanced operational DQL queries.

### 7. Project Management System (`PROJECT_DB`)

* **Overview:** Manages corporate or academic projects/schemes, departments, employee assignments, working hours, supervisors, and dependent/family profiles.
* **Key Highlights:** Complex relational joins tracking employee contributions per project, workload distribution, and hierarchical department-supervisor structures.

---

## Tech Stack & Tools

* **Database Management System:** Microsoft SQL Server (T-SQL)
* **Development Environment:** VS Code / SSMS (SQL Server Management Studio)
* **Version Control:** Git & GitHub

---

## Purpose of This Lab

* Master relational database design principles (1NF, 2NF, 3NF, ERD mapping).
* Implement robust data integrity using constraints, defaults, checks, and active triggers.
* Write efficient, clean, and optimized SQL queries (`JOIN`, `GROUP BY`, `HAVING`, CTEs, Window Functions).