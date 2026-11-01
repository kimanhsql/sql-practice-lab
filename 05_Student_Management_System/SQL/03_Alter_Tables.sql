-- ============================================================
-- STUDENT MANAGEMENT SYSTEM
-- ALTER TABLES
-- ============================================================

USE STUDENT_DB;
GO


ALTER TABLE DEPARTMENTS
    ADD CONSTRAINT FK_TEACHERS_DEPARTMENTS FOREIGN KEY(HeadTeacherID)
        REFERENCES TEACHERS(TeacherID);
GO


ALTER TABLE CLASSES
    ADD CONSTRAINT FK_STUDENTS_CLASSES FOREIGN KEY(ClassMonitorID)
        REFERENCES STUDENTS(StudentID);
GO


-- Question 1
-- Add 3 attributes: Notes, AverageScore, and Classification
-- to the STUDENTS table.

ALTER TABLE STUDENTS ADD Notes NVARCHAR(20);
GO

ALTER TABLE STUDENTS ADD AverageScore NUMERIC(3,2);
GO

ALTER TABLE STUDENTS ADD Classification NVARCHAR(10);
GO