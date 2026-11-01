-- ============================================================
-- STUDENT MANAGEMENT SYSTEM
-- DATA DEFINITION LANGUAGE (DDL)
-- ============================================================

USE STUDENT_DB;
GO


-- Question 2
-- Student ID must be a 5-character string where the first 3 characters 
-- represent the class ID and the last 2 characters
-- represent the student sequence number. Ex: 'K1101'.

ALTER TABLE STUDENTS
    ADD CONSTRAINT CHK_StudentID
        CHECK 
        (
            LEN(StudentID) = 5 AND
            LEFT(StudentID, 3) = ClassID AND
            RIGHT(StudentID, 2) LIKE '[0-9][0-9]'
        );
GO


-- Question 3
-- Gender attribute can only be 'Nam' or 'Nữ'.

ALTER TABLE TEACHERS
    ADD CONSTRAINT CHK_Gender_Teacher
        CHECK (Gender IN ('Nam', N'Nữ'));
GO

ALTER TABLE STUDENTS
    ADD CONSTRAINT CHK_Gender_Student
        CHECK (Gender IN ('Nam', N'Nữ'));
GO


-- Question 4
-- Exam scores range from 0 to 10 with up to 2 decimal places (Ex: 6.22).

ALTER TABLE EXAM_RESULTS
    ADD CONSTRAINT CHK_Score
        CHECK (Score BETWEEN 0.00 AND 10.00);
GO


-- Question 5
-- Exam result is 'Đạt' (Pass) if the score is from 5 to 10, 
-- and 'K Đạt' (Fail) if the score is less than 5.

ALTER TABLE EXAM_RESULTS ALTER COLUMN Result NVARCHAR(10);
GO

ALTER TABLE EXAM_RESULTS
    ADD CONSTRAINT CHK_Result
        CHECK 
        (
            (Score >= 5.00 AND Score <= 10.00 AND Result = N'Đạt')
            OR
            (Score < 5.00 AND Result = N'K Đạt')
        );
GO


-- Question 6
-- A student can take an exam for a subject a maximum of 3 times.

ALTER TABLE EXAM_RESULTS
    ADD CONSTRAINT CHK_AttemptNo CHECK (AttemptNo > 0 AND AttemptNo <= 3);
GO


-- Question 7
-- Semester values can only range from 1 to 3.

ALTER TABLE TEACHING_SCHEDULE
    ADD CONSTRAINT CHK_Semester CHECK (Semester BETWEEN 1 AND 3);
GO


-- Question 8
-- Teacher academic degrees can only be 'CN', 'KS', 'ThS', 'TS'.

ALTER TABLE TEACHERS
    ADD CONSTRAINT CHK_AcademicDegree
        CHECK (AcademicDegree IN ('CN', 'KS', 'ThS', 'TS'));
GO


-- Question 9
-- A class monitor must be a student belonging to that class.

CREATE TRIGGER TRG_CheckClassMonitor
ON CLASSES
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN STUDENTS s ON i.ClassMonitorID = s.StudentID
        WHERE i.ClassID <> s.ClassID
    )
    BEGIN
        PRINT 'Error: The class monitor must be a student of that specific class!';
        ROLLBACK TRANSACTION;
    END;
END;
GO


CREATE TRIGGER TRG_CheckStudentClassTransfer
ON STUDENTS
AFTER UPDATE
AS
BEGIN
    IF UPDATE(ClassID)
    BEGIN
        IF EXISTS
        (
            SELECT 1
            FROM CLASSES c
            JOIN inserted i ON c.ClassMonitorID = i.StudentID
            WHERE c.ClassID <> i.ClassID
        )
        BEGIN
            PRINT 'Error: This student is currently acting as a class monitor.';
            PRINT 'You must appoint a new class monitor before transferring this student!';
            ROLLBACK TRANSACTION;
        END;
    END;
END;
GO


-- Question 10
-- Department head must be a teacher belonging to that department 
-- with an academic degree of 'TS' or 'PTS'.

CREATE TRIGGER TRG_CheckDepartmentHead
ON DEPARTMENTS
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN TEACHERS t ON i.HeadTeacherID = t.TeacherID
        WHERE i.DepartmentID <> t.DepartmentID
    )
    BEGIN
        PRINT 'Error: The department head must be a teacher of that department!';
        ROLLBACK TRANSACTION;
    END;
END;
GO


CREATE TRIGGER TRG_ManageDepartmentHeadUpdate
ON TEACHERS
AFTER UPDATE, DELETE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM deleted d
        JOIN DEPARTMENTS dep ON d.TeacherID = dep.HeadTeacherID
    )
    AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        PRINT 'Error: Cannot delete this teacher because they are currently serving as a Department Head.';
        PRINT 'Please assign someone else as Department Head before performing this operation.';
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN DEPARTMENTS dep ON i.TeacherID = dep.HeadTeacherID
        WHERE i.DepartmentID <> dep.DepartmentID OR i.AcademicDegree NOT IN ('TS', 'PTS')
    )
    BEGIN
        PRINT 'Error: This teacher is currently a Department Head!';
        PRINT 'Unauthorized department transfer or invalid academic degree modification.';
        PRINT 'Department Head degree must be TS or PTS.';
        ROLLBACK TRANSACTION;
    END;
END;
GO


ALTER TABLE TEACHERS DROP CONSTRAINT CHK_AcademicDegree;
GO


ALTER TABLE TEACHERS
    ADD CONSTRAINT CHK_AcademicDegree_Updated
        CHECK (AcademicDegree IN ('CN', 'KS', 'ThS', 'TS', 'PTS'));
GO


-- Question 11
-- Students must be at least 18 years old.

ALTER TABLE STUDENTS
    ADD CONSTRAINT CHK_StudentAge
        CHECK 
        (
            (YEAR(GETDATE()) - YEAR(DateOfBirth) > 18)
            OR
            (
                (YEAR(GETDATE()) - YEAR(DateOfBirth) = 18)
                AND
                (
                    MONTH(DateOfBirth) < 4 OR
                    (MONTH(DateOfBirth) = 4 AND DAY(DateOfBirth) <= 29)
                )
            )
        );
GO


-- Question 12
-- For any teaching schedule, the start date (StartDate) 
-- must be earlier than the end date (EndDate).

ALTER TABLE TEACHING_SCHEDULE
    ADD CONSTRAINT CHK_TeachingDates
        CHECK (StartDate < EndDate);
GO


-- Question 13
-- Teachers must be at least 22 years old upon hiring.

ALTER TABLE TEACHERS
    ADD CONSTRAINT CHK_TeacherAge
        CHECK 
        (
            (YEAR(GETDATE()) - YEAR(DateOfBirth) > 22)
            OR
            (
                (YEAR(GETDATE()) - YEAR(DateOfBirth) = 22)
                AND
                (
                    MONTH(DateOfBirth) < 4 OR
                    (MONTH(DateOfBirth) = 4 AND DAY(DateOfBirth) <= 29)
                )
            )
        );
GO


-- Question 14
-- The difference between theory credits and practical credits 
-- for any subject must not exceed 3.

ALTER TABLE SUBJECTS
    ADD CONSTRAINT CHK_CreditDifference
        CHECK (ABS(TheoryCredits - PracticalCredits) <= 3);
GO


-- Question 15
-- Students can only take an exam for a subject after 
-- their class has finished learning that subject.

CREATE TRIGGER TRG_CheckExamAfterCourseCompletion
ON EXAM_RESULTS
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN STUDENTS s ON i.StudentID = s.StudentID
        JOIN TEACHING_SCHEDULE ts ON s.ClassID = ts.ClassID AND i.SubjectID = ts.SubjectID
        WHERE i.ExamDate <= ts.EndDate
    )
    BEGIN
        PRINT 'Error: The student''s class has not finished this subject yet!';
        PRINT 'The exam date must take place AFTER the course end date.';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- Question 16
-- In each semester of an academic year, a class
-- can be taught a maximum of 3 subjects.

CREATE TRIGGER TRG_MaxSubjectsPerSemester
ON TEACHING_SCHEDULE
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT ts.ClassID, ts.Semester, ts.Year
        FROM TEACHING_SCHEDULE ts
        JOIN inserted i ON i.ClassID = ts.ClassID AND i.Semester = ts.Semester AND i.Year = ts.Year
        GROUP BY ts.ClassID, ts.Semester, ts.Year
        HAVING COUNT(DISTINCT ts.SubjectID) > 3
    )
    BEGIN
        PRINT 'Error: Exceeded the maximum allowed subjects!';
        PRINT 'Each class can take a maximum of 3 subjects per semester in any academic year.';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- Question 17
-- The class size must equal the actual number of students
-- belonging to that class.

CREATE TRIGGER TRG_VerifyClassSize
ON CLASSES
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN STUDENTS s ON i.ClassID = s.ClassID
        GROUP BY s.ClassID, i.ClassSize
        HAVING i.ClassSize <> COUNT(s.StudentID)
    )
    BEGIN
        PRINT 'Error: Class size does not match the actual number of enrolled students.';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- Question 18
-- In the prerequisites table, SubjectID and PrerequisiteSubjectID
-- in the same row cannot be identical ('A', 'A'),
-- nor can there exist two reverse rows ('A', 'B') and ('B', 'A').

ALTER TABLE PREREQUISITES
    ADD CONSTRAINT CHK_PrereqNotSelf
        CHECK (SubjectID <> PrerequisiteSubjectID);
GO

CREATE TRIGGER TRG_CheckCircularPrerequisites
ON PREREQUISITES
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM PREREQUISITES p
        JOIN inserted i ON p.SubjectID = i.PrerequisiteSubjectID AND p.PrerequisiteSubjectID = i.SubjectID
    )
    BEGIN
        PRINT 'Error: Circular dependency detected in prerequisites!';
        PRINT 'This subject and its prerequisite are mutually constrained.';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- Question 19
-- Teachers with the same academic degree, academic title, 
-- and salary coefficient must have equal salaries.

CREATE TRIGGER TRG_SalaryConsistency
ON TEACHERS
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN TEACHERS t ON i.AcademicDegree = t.AcademicDegree AND i.AcademicTitle = t.AcademicTitle AND i.SalaryCoefficient = t.SalaryCoefficient
        WHERE i.Salary <> t.Salary
    )
    BEGIN
        PRINT 'Error: Teachers sharing the same academic degree, title, and coefficient.';
        PRINT 'Their salaries must be identical.';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- Question 20
-- Students are only allowed to retake an exam (AttemptNo > 1) 
-- if the score of their previous attempt was below 5.

CREATE TRIGGER TRG_AllowRetestOnlyIfFailed
ON EXAM_RESULTS
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN EXAM_RESULTS er ON i.StudentID = er.StudentID AND i.SubjectID = er.SubjectID AND i.AttemptNo - 1 = er.AttemptNo
        WHERE i.AttemptNo > 1 AND er.Score >= 5
    )
    BEGIN
        PRINT 'Error: Students are only allowed to retake an exam if their previous score was below 5.';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- Question 21
-- The exam date of a subsequent attempt must be later than 
-- the exam date of the previous attempt (for the same student and subject).

CREATE TRIGGER TRG_ExamDateSequence
ON EXAM_RESULTS
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN EXAM_RESULTS er ON i.StudentID = er.StudentID AND i.SubjectID = er.SubjectID AND i.AttemptNo > er.AttemptNo
        WHERE i.ExamDate <= er.ExamDate
    )
    BEGIN
        PRINT 'Error: The exam date for a subsequent attempt must be later than the previous attempt.';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- Question 22
-- Students can only take exams for subjects
-- that their class has completed.

CREATE TRIGGER TRG_ExamAllowedAfterClassCompleted
ON EXAM_RESULTS
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM STUDENTS s
            JOIN TEACHING_SCHEDULE ts ON s.ClassID = ts.ClassID
            WHERE s.StudentID = i.StudentID AND ts.SubjectID = i.SubjectID AND i.ExamDate > ts.EndDate
        )
    )
    BEGIN
        PRINT 'Error: Students can only take exams after their class has finished studying this subject!';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- Question 23
-- When assigning teaching schedules, prerequisite subject order
-- must be respected (subsequent subjects can only be taught
-- after prerequisite subjects are completed).

CREATE TRIGGER TRG_CheckPrerequisiteTeachingOrder
ON TEACHING_SCHEDULE
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN PREREQUISITES p ON i.SubjectID = p.SubjectID
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM TEACHING_SCHEDULE pre_schedule
            WHERE pre_schedule.ClassID = i.ClassID AND pre_schedule.SubjectID = p.PrerequisiteSubjectID AND pre_schedule.EndDate < i.StartDate
        )
    )
    BEGIN
        PRINT 'Error: The assigned teaching sequence must comply with prerequisite rules.';
    END;
END;
GO


-- Question 24
-- Teachers can only be assigned to teach subjects 
-- that belong to the department they manage/belong to.

CREATE TRIGGER TRG_CheckTeacherDepartmentAssignment
ON TEACHING_SCHEDULE
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN TEACHERS t ON i.TeacherID = t.TeacherID
        JOIN SUBJECTS sub ON i.SubjectID = sub.SubjectID
        WHERE t.DepartmentID <> sub.DepartmentID
    )
    BEGIN
        PRINT 'Error: Teachers can only be assigned to teach subjects belonging to their own department.';
        ROLLBACK TRANSACTION;
    END;
END;
GO