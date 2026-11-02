-- ============================================================
-- STUDENT MANAGEMENT SYSTEM
-- DATA MANIPULATION LANGUAGE (DML)
-- ============================================================

USE STUDENT_DB;
GO


-- Question 1
-- Increase the salary coefficient by 0.2 for teachers
-- who are department heads.

UPDATE TEACHERS
    SET SalaryCoefficient = SalaryCoefficient + 0.2
    WHERE TeacherID IN
    (
        SELECT HeadTeacherID
        FROM DEPARTMENTS
        WHERE HeadTeacherID IS NOT NULL
    );
GO


-- Question 2
-- Update the average score (AverageScore) for
-- all subjects of each student 
-- (all subjects have a weight of 1, and if a student
-- takes an exam multiple times, 
-- only the score of the latest attempt is used).

WITH LatestExamScores AS
(
    SELECT StudentID, SubjectID, Score,
        ROW_NUMBER() OVER (PARTITION BY StudentID, SubjectID ORDER BY AttemptNo DESC) AS RowRank
    FROM EXAM_RESULTS
),
StudentAverageScore AS
(
    SELECT StudentID, AVG(Score) AS NewAverageScore
    FROM LatestExamScores
    WHERE RowRank = 1
    GROUP BY StudentID
)
UPDATE STUDENTS
    SET AverageScore = ROUND(sas.NewAverageScore, 2)
    FROM STUDENTS s
    JOIN StudentAverageScore sas ON s.StudentID = sas.StudentID;
GO


-- Question 3
-- Update the Notes (GHICHU) column to 'Cấm thi' (Banned)
-- for cases where:
-- a student scored below 5 on their 3rd attempt in any subject.

UPDATE STUDENTS
    SET Notes = N'Cấm thi'
    WHERE StudentID IN
    (
        SELECT DISTINCT StudentID
        FROM EXAM_RESULTS
        WHERE AttemptNo = 3 AND Score < 5.00
    );
GO

-- Question 4
-- Update the Classification (XEPLOAI) column
-- in the STUDENTS table as follows:
-- * If AverageScore >= 9 then Classification = 'XS'
-- * If 8 <= AverageScore < 9 then Classification = 'G'
-- * If 6.5 <= AverageScore < 8 then Classification = 'K'
-- * If 5 <= AverageScore < 6.5 then Classification = 'TB'
-- * If AverageScore < 5 then Classification = 'Y'

UPDATE STUDENTS
    SET Classification =
        CASE
            WHEN AverageScore >= 9.00 THEN 'XS'
            WHEN AverageScore >= 8.00 AND AverageScore < 9.00 THEN 'G'
            WHEN AverageScore >= 6.50 AND AverageScore < 8.00 THEN 'K'
            WHEN AverageScore >= 5.00 AND AverageScore < 6.50 THEN 'TB'
            ELSE 'Y'
        END
    WHERE AverageScore IS NOT NULL;
GO