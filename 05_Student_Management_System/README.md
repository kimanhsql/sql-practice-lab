# Student Management System

This project is a SQL Server database project based on the `QLHocVien` exercises from the *Database Fundamentals* textbook (`TH1207_GT.pdf`).

---

## 1. Database Overview & Structure

**Database:** `STUDENT_DB` (based on `QLHocVien`)

The database consists of 8 core tables managing information about students, classes, departments, subjects, prerequisite courses, teachers, teaching schedules, and exam results.


### Table List

```text
STUDENTS
CLASSES
DEPARTMENTS
SUBJECTS
PREREQUISITES
TEACHERS
TEACHING_SCHEDULE
EXAM_RESULTS
```


### Detailed Table Specifications & Constraints Note

* **Primary Keys (PK):** Explicitly defined for all tables (including composite keys for `PREREQUISITES`, `TEACHING_SCHEDULE`, and `EXAM_RESULTS`).
* **Foreign Keys (FK):** Explicitly defined linking related entities (e.g., students to classes, classes/teachers to departments, subjects to departments, teaching schedules and exam results to their respective entities).
* **Nullability & Modifications:** Additional attributes (`Notes`, `AverageScore`, `Classification`) are required to be added to the student records. Integrity rules and business logic are enforced via constraints and triggers.

---

#### 1.1 STUDENTS (`HOCVIEN`)

* **Attributes & Data Types:** `StudentID`, `FirstName`, `LastName`, `DateOfBirth`, `Gender`, `BirthPlace`, `ClassID` *(Plus added columns: `Notes`, `AverageScore`, `Classification`)*
* **Primary Key:** `StudentID`
* **Foreign Keys:** `ClassID` (references `CLASSES`)
* **Constraints & Business Rules:** Student ID format validation, gender check ('Nam'/'Nữ'), age verification (at least 18 years old).

---

#### 1.2 CLASSES (`LOP`)

* **Attributes & Data Types:** `ClassID`, `ClassName`, `ClassMonitorID`, `ClassSize`, `HeadTeacherID`
* **Primary Key:** `ClassID`
* **Foreign Keys:** `ClassMonitorID` (references `STUDENTS`), `HeadTeacherID` (references `TEACHERS`)
* **Constraints & Business Rules:** Class monitor must belong to the respective class; class size must match actual enrolled students.

---

#### 1.3 DEPARTMENTS (`KHOA`)

* **Attributes & Data Types:** `DepartmentID`, `DepartmentName`, `EstablishedDate`, `HeadTeacherID`
* **Primary Key:** `DepartmentID`
* **Foreign Keys:** `HeadTeacherID` (references `TEACHERS`)
* **Constraints & Business Rules:** Department head must be a teacher belonging to that department with an academic degree of 'TS' or 'PTS'.

---

#### 1.4 SUBJECTS (`MONHOC`)

* **Attributes & Data Types:** `SubjectID`, `SubjectName`, `TheoryCredits`, `PracticalCredits`, `DepartmentID`
* **Primary Key:** `SubjectID`
* **Foreign Keys:** `DepartmentID` (references `DEPARTMENTS`)
* **Constraints & Business Rules:** Theory and practical credits difference cannot exceed 3.

---

#### 1.5 PREREQUISITES (`DIEUKIEN`)

* **Attributes & Data Types:** `SubjectID`, `PrerequisiteSubjectID`
* **Primary Key:** Composite key (`SubjectID`, `PrerequisiteSubjectID`)
* **Foreign Keys:** `SubjectID`, `PrerequisiteSubjectID` (reference `SUBJECTS`)
* **Constraints & Business Rules:** A subject cannot require itself as a prerequisite; asymmetric relationships must be maintained.

---

#### 1.6 TEACHERS (`GIAOVIEN`)

* **Attributes & Data Types:** `TeacherID`, `FullName`, `AcademicDegree`, `AcademicTitle`, `Gender`, `DateOfBirth`, `HireDate`, `SalaryCoefficient`, `SalaryLevel`, `DepartmentID`
* **Primary Key:** `TeacherID`
* **Foreign Keys:** `DepartmentID` (references `DEPARTMENTS`)
* **Constraints & Business Rules:** Valid academic degrees ('CN', 'KS', 'Ths', 'TS'); minimum entry age of 22; salary consistency rule based on academic credentials and coefficient.

---

#### 1.7 TEACHING_SCHEDULE (`GIANGDAY`)

* **Attributes & Data Types:** `ClassID`, `SubjectID`, `TeacherID`, `Semester`, `Year`, `StartDate`, `EndDate`
* **Primary Key:** Composite key (`ClassID`, `SubjectID`, `TeacherID`, `Semester`, `Year`)
* **Foreign Keys:** `ClassID` (references `CLASSES`), `SubjectID` (references `SUBJECTS`), `TeacherID` (references `TEACHERS`)
* **Constraints & Business Rules:** Start date must precede end date; semester restricted to values 1–3; maximum 3 subjects per class per semester; teachers can only teach subjects belonging to their department.

---

#### 1.8 EXAM_RESULTS (`KETQUATHI`)

* **Attributes & Data Types:** `StudentID`, `SubjectID`, `AttemptNo`, `ExamDate`, `Score`, `Result`
* **Primary Key:** Composite key (`StudentID`, `SubjectID`, `AttemptNo`)
* **Foreign Keys:** `StudentID` (references `STUDENTS`), `SubjectID` (references `SUBJECTS`)
* **Constraints & Business Rules:** Score ranges from 0 to 10 with up to 2 decimal places; result automatically evaluated ('Đạt' if score >= 5, 'K Đạt' otherwise); maximum 3 attempts per subject; re-tests allowed only if the previous attempt score was < 5; exam dates must be sequential; students can only take exams for subjects their class has completed.

---

## 2. Textbook Exercises & Requirements

### PART I: DATA DEFINITION LANGUAGE (DDL) & INTEGRITY CONSTRAINTS

1. Create tables (`STUDENTS`, `CLASSES`, `DEPARTMENTS`, `SUBJECTS`, `PREREQUISITES`, `TEACHERS`, `TEACHING_SCHEDULE`, `EXAM_RESULTS`) and declare primary keys and foreign keys.
2. Add `GHICHU` (Notes), `DIEMTB` (Average Score), and `XEPLOAI` (Classification) columns to the `STUDENTS` table.
3. Validate Student ID format (5 characters: 3 class prefix characters + 2 sequence digits, e.g., ‘K1101’).
4. Restrict gender (`Gender`) to values `'Nam'` or `'Nữ'`.
5. Restrict exam score range (0 to 10 with up to 2 decimal places) and automatic evaluation of result (`Result`: `'Đạt'` if score >= 5, `'K Đạt'` otherwise).
6. Restrict maximum exam attempts per subject to 3 times.
7. Restrict semester values (`Semester`) to range from 1 to 3.
8. Restrict teacher academic degrees (`AcademicDegree`) to only `'CN'`, `'KS'`, `'Ths'`, `'TS'`.
9. Ensure the class monitor (`ClassMonitorID`) belongs to the respective class.
10. Ensure the department head (`HeadTeacherID`) is a teacher belonging to that department with an academic degree of `'TS'` or `'PTS'`.
11. Enforce minimum age for students (at least 18 years old).
12. Ensure teaching schedule start date (`StartDate`) precedes end date (`EndDate`).
13. Enforce minimum hire age for teachers (at least 22 years old).
14. Ensure theory and practical credits difference for any subject does not exceed 3.
15. Ensure students can only take exams for subjects whose course has been completed by their class.
16. Restrict each class to a maximum of 3 subjects per semester in any academic year.
17. Ensure class size (`ClassSize`) equals the actual number of students enrolled in that class.
18. In the prerequisite table (`PREREQUISITES`), ensure subject codes are not identical in the same row (`'A'`, `'A'`) and prevent reverse/symmetric circular dependencies (`('A','B')` and `('B','A')`).
19. Ensure teachers with the same academic degree, academic title, and salary coefficient have equal salaries.
20. Allow students to retake an exam (attempt > 1) only if the score of the previous attempt was below 5.
21. Ensure the exam date of a subsequent attempt is later than the previous attempt (for the same student and subject).
22. Ensure students only take exams for subjects completed by their class (schedule-based verification).
23. Enforce prerequisite sequence rules when assigning teaching schedules (subsequent subjects can only be taught after prerequisite subjects are completed).
24. Ensure teachers are only assigned to teach subjects belonging to the department they manage/belong to.

---

### PART II: DATA MANIPULATION LANGUAGE (DML)

1. Increase salary coefficient by 0.2 for department heads.
2. Calculate and update `AverageScore` for all students (weight 1, taking the latest exam score).
3. Update `Notes` to 'Cấm thi' (Banned) for students who scored below 5 on their 3rd attempt in any subject.
4. Update `Classification` based on average score thresholds:
* AverageScore >= 9: 'XS' (Excellent)
* 8 <= AverageScore < 9: 'G' (Good)
* 6.5 <= AverageScore < 8: 'K' (Fair)
* 5 <= AverageScore < 6.5: 'TB' (Average)
* AverageScore < 5: 'Y' (Poor)

---

### PART III: DATA QUERYING (SQL)

1. List class monitors (Student ID, full name, date of birth, class ID).
2. List scorecards for subject 'CTRR' of class 'K12', sorted by student name and first name.
3. List students and subjects passed on the 1st attempt.
4. List students of class 'K11' who failed subject 'CTRR' on the 1st attempt.
5. List students of class 'K11' who failed subject 'CTRR' across all attempts.
6. Find subject names taught by teacher 'Tran Tam Thanh' in Semester 1, 2006.
7. Find subjects taught by the head teacher of class 'K11' in Semester 1, 2006.
8. Find full names of class monitors whose classes are taught subject 'Co So Du Lieu' by teacher 'Nguyen To Lan'.
9. List prerequisite subjects for 'Co So Du Lieu'.
10. List subjects that directly depend on 'Cau Truc Roi Rac'.
11. Find teachers who taught 'CTRR' for both classes 'K11' and 'K12' in Semester 1, 2006.
12. Find students who failed 'CSDL' on the 1st attempt and have not re-tested yet.
13. Find teachers not assigned to teach any subjects.
14. Find teachers not assigned to teach any subjects belonging to their own department.
15. Find students of class 'K11' who failed any subject more than 3 times or scored exactly 5 on the 2nd attempt of 'CTRR'.
16. Find teachers who taught 'CTRR' for at least two classes in the same semester and year.
17. Student list and scores for 'CSDL' (taking the latest attempt).
18. Student list and scores for 'Co So Du Lieu' (taking the highest attempt score).
19. Find the department established earliest.
20. Count teachers with academic titles 'GS' or 'PGS'.
21. Statistics of teachers by academic degree in each department.
22. Statistics of student results (pass/fail count) for each subject.
23. Find teachers who are head teachers of a class and also teach at least one subject to that class.
24. Find the class monitor of the class with the highest class size.
25. Find class monitors who failed more than 3 subjects (failed all attempts for those subjects).
26. Find the student with the most subjects achieving scores of 9 or 10.
27. Within each class, find the student with the most subjects achieving scores of 9 or 10.
28. Statistics of teaching workload (number of subjects and classes) for each teacher in each semester of each year.
29. Find the teacher with the heaviest teaching workload in each semester of each year.
30. Find the subject with the most students failing on the 1st attempt.
31. Find students who pass every subject on the 1st attempt.
32. Find students who pass every subject on the final attempt.
33. Find students who have passed all subjects on the 1st attempt.
34. Find students who have passed all subjects on the final attempt.
35. Find students with the highest exam score in each subject (using the latest attempt score).

---

## 3. Project Structure & Workflow

```text
05_Student_Management_System/
├── Images/
├── SQL/
├── QLHocVien.sql
└── README.md
```

* **Workflow:**
1. Analyze database requirements from the textbook.
2. Create database, tables, primary keys, and foreign keys in English.
3. Implement schema modifications and integrity constraints (`ALTER TABLE`, `CHECK`, `TRIGGERS`).
4. Perform data insertion and DML updates.
5. Execute and verify all data querying tasks.
6. Organize SQL scripts and finalize project documentation.

---

## 4. Current Progress

* [x] Database creation
* [x] Table creation (English schema)
* [x] Primary keys and foreign keys
* [x] Sample data setup
* [x] DML exercises execution & updates
* [x] SQL queries implementation and verification
* [x] Integrity constraints & Triggers implementation
* [x] SQL script organization
* [x] Project documentation (`README.md`)