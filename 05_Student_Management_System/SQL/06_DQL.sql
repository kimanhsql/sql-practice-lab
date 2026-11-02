-- ============================================================
-- STUDENT MANAGEMENT SYSTEM
-- DATA QUERY LANGUAGE (DQL)
-- ============================================================

USE STUDENT_DB;
GO


-- Question 1
-- Print the list (student ID, full name, date of birth, class ID) 
-- of all class monitors.

SELECT
    StudentID,
    FirstName + ' ' + LastName AS FullName,
    DateOfBirth,
    ClassID
FROM STUDENTS
WHERE StudentID IN
(
    SELECT ClassMonitorID
    FROM CLASSES
    WHERE ClassMonitorID IS NOT NULL
);
GO


-- Question 2
-- Print the exam score sheet (student ID, full name, attempt number,
-- score) for the subject 'CTRR' of class 'K12',
-- sorted by student's first name and last name.

SELECT 
    StudentID,
    FirstName + ' ' + LastName AS FullName,
    AttemptNo,
    Score
FROM EXAM_RESULTS
WHERE SubjectID = 'CTRR' AND StudentID IN
(
    SELECT StudentID
    FROM STUDENTS
    WHERE ClassID = 'K12'
)
ORDER BY FullName;
GO


-- Question 3
-- Print the list of students (student ID, full name) 
-- and the subjects that they passed on their 1st attempt.

SELECT
    er.StudentID,
    FirstName + ' ' + LastName AS FullName,
    er.SubjectID,
    AttemptNo,
    Score
FROM EXAM_RESULTS er
INNER JOIN STUDENTS s
    ON er.StudentID = s.StudentID
WHERE AttemptNo = 1 AND Score >= 5.00;
GO


-- Question 4
-- Print the list of students (student ID, full name) of class 'K11' 
-- who failed the subject 'CTRR' (on their 1st attempt).

SELECT
    StudentID,
    FirstName + ' ' + LastName AS FullName
FROM STUDENTS
WHERE StudentID IN
(
    SELECT StudentID
    FROM EXAM_RESULTS
    WHERE SubjectID = 'CTRR'
        AND AttemptNo = 1
        AND Score < 5.00
);
GO


-- Question 5
-- List of students (student ID, full name) of class 'K11' 
-- who failed the subject 'CTRR' in all of their exam attempts.

SELECT
    StudentID,
    FirstName + ' ' + LastName AS FullName
FROM STUDENTS
WHERE ClassID = 'K11' AND StudentID IN
(
    SELECT StudentID
    FROM EXAM_RESULTS
    WHERE SubjectID = 'CTRR'
    GROUP BY StudentID
    HAVING MAX(Score) < 5.00
);
GO


-- Question 6
-- Find the names of subjects taught by the teacher named 'Tran Tam Thanh' 
-- in semester 1 of 2006.

SELECT DISTINCT SubjectName
FROM SUBJECTS
WHERE SubjectID IN
(
    SELECT SubjectID
    FROM TEACHING_SCHEDULE
    WHERE Semester = 1
        AND Year = 2006
        AND TeacherID IN
        (
            SELECT TeacherID
            FROM TEACHERS
            WHERE FullName = 'Tran Tam Thanh'
        )
);
GO


-- Question 7
-- Find the subjects (subject ID, subject name) taught by the head teacher 
-- of class 'K11' in semester 1 of 2006.

SELECT DISTINCT
    SubjectID,
    SubjectName
FROM SUBJECTS
WHERE SubjectID IN
(
    SELECT SubjectID
    FROM TEACHING_SCHEDULE
    WHERE Semester = 1
        AND Year = 2006
        AND TeacherID IN
        (
            SELECT HeadTeacherID
            FROM CLASSES
            WHERE ClassID = 'K11'
        )
);
GO


-- Question 8
-- Find the full name of the class monitor for classes 
-- where the teacher named 'Nguyen To Lan' teaches 'Co So Du Lieu'.

SELECT DISTINCT
    FirstName + ' ' + LastName AS FullName
FROM STUDENTS
WHERE StudentID IN
(
    SELECT ClassMonitorID
    FROM CLASSES
    WHERE ClassID IN
    (
        SELECT ClassID
        FROM TEACHING_SCHEDULE
        WHERE SubjectID = 'CSDL' AND TeacherID IN
        (
            SELECT TeacherID
            FROM TEACHERS
            WHERE FullName = 'Nguyen To Lan'
        )
    )
);
GO


-- Question 9
-- Print the list of subjects (subject ID, subject name) 
-- that must be studied immediately before the subject 'Co So Du Lieu'.

SELECT DISTINCT
    SubjectID,
    SubjectName
FROM SUBJECTS
WHERE SubjectID IN
(
    SELECT PrerequisiteSubjectID
    FROM PREREQUISITES
    WHERE SubjectID = 'CSDL'
);
GO


-- Question 10
-- The subject 'Cau Truc Roi Rac' is the mandatory prerequisite 
-- for which subjects (subject ID, subject name)?

SELECT DISTINCT
    SubjectID,
    SubjectName
FROM SUBJECTS
WHERE SubjectID in
(
    SELECT SubjectID
    FROM PREREQUISITES
    WHERE PrerequisiteSubjectID = 'CTRR'
);
GO


-- Question 11
-- Find the full name of the teacher who taught 'CTRR'
-- to both classes 'K11' and 'K12' in the same semester 1 of 2006.

SELECT DISTINCT
    FirstName + ' ' + LastName AS FullName
FROM TEACHERS
WHERE TeacherID IN
(
    SELECT TeacherID
    FROM TEACHING_SCHEDULE
    WHERE SubjectID = 'CTRR'
        AND Semester = 1
        AND Year = 2006
        AND ClassID IN ('K11', 'K12')
);
GO


-- Question 12
-- Find the students (student ID, full name) who failed the subject 'CSDL' 
-- on their 1st attempt and have not retaken it yet.

SELECT
    StudentID,
    FirstName + ' ' + LastName AS FullName
FROM STUDENTS
WHERE StudentID IN
(
    SELECT StudentID
    FROM EXAM_RESULTS
    WHERE SubjectID = 'CSDL'
        AND AttemptNo = 1
        AND Score < 5.00
        AND StudentID NOT IN
        (
            SELECT StudentID
            FROM EXAM_RESULTS
            WHERE SubjectID = 'CSDL'
                AND AttemptNo > 1
        )
);
GO


-- Question 13
-- Find the teachers (teacher ID, full name) who are not assigned 
-- to teach any subjects.

SELECT
    TeacherID,
    FirstName + ' ' + LastName AS FullName
FROM TEACHERS
WHERE TeacherID NOT IN
(
    SELECT TeacherID
    FROM TEACHING_SCHEDULE
);
GO


-- Question 14
-- Find the teachers (teacher ID, full name) who are not assigned 
-- to teach any subjects belonging to their own department.

SELECT
    TeacherID,
    FirstName + ' ' + LastName AS FullName
FROM TEACHERS t
WHERE TeacherID NOT IN
(
    SELECT TeacherID
    FROM TEACHING_SCHEDULE
    WHERE SubjectID IN
    (
        SELECT SubjectID
        FROM SUBJECTS s
        WHERE s.DepartmentID = t.DepartmentID
    )
);
GO


-- Question 15
-- Find the full name of students in class 'K11'
-- who took any subject more than 3 times and still failed,
-- or got exactly 5 points on their 2nd attempt in 'CTRR'.

SELECT DISTINCT
    FirstName + ' ' + LastName AS FullName
FROM STUDENTS
WHERE StudentID IN
(
    SELECT StudentID
    FROM EXAM_RESULTS
    WHERE StudentID IN
    (
        SELECT StudentID
        FROM STUDENTS
        WHERE ClassID = 'K11' AND
        (
            (SubjectID = 'CTRR' AND AttemptNo = 2 AND Score = 5.00)
            OR
            (SubjectID = 'CSDL' AND AttemptNo > 3 AND Result = N'K Đạt')
        )
    )
);
GO


-- Question 16
-- Find the full name of teachers who taught 'CTRR'
-- to at least two classes in the same semester of an academic year.

SELECT DISTINCT
    FirstName + ' ' + LastName AS FullName
FROM TEACHERS
WHERE TeacherID IN
(
    SELECT TeacherID
    FROM TEACHING_SCHEDULE
    WHERE SubjectID = 'CTRR'
    GROUP BY TeacherID, Semester, Year
    HAVING COUNT(DISTINCT ClassID) >= 2
);
GO


-- Question 17
-- List of students and their exam scores for 'CSDL' 
-- (taking only the score of the latest attempt).

SELECT
    StudentID,
    FirstName + ' ' + LastName AS FullName,
    Score
FROM EXAM_RESULTS er
INNER JOIN STUDENTS s
    ON er.StudentID = s.StudentID
WHERE SubjectID = 'CSDL'
AND AttemptNo =
    (
        SELECT MAX(AttemptNo)
        FROM EXAM_RESULTS
        WHERE SubjectID = 'CSDL' AND StudentID = er.StudentID
    );
GO


-- Question 18
-- List of students and their exam scores for 'Co So Du Lieu' 
-- (taking only the highest score among all attempts).

SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS FullName,
    MAX(er.Score) AS MaxScore
FROM EXAM_RESULTS er
INNER JOIN STUDENTS s
    ON er.StudentID = s.StudentID
WHERE er.SubjectID = 'CSDL'
GROUP BY s.StudentID, s.FirstName, s.LastName;
GO


-- Question 19
-- Which department (department ID, department name)
-- was established earliest?

SELECT TOP 1
    DepartmentID,
    DepartmentName,
    EstablishedDate
FROM DEPARTMENTS
ORDER BY EstablishedDate ASC;
GO


-- Question 20
-- How many teachers have an academic title of 'GS' (Professor)
-- or 'PGS' (Associate Professor)?

SELECT COUNT(*) AS TotalCount
FROM TEACHERS
WHERE AcademicTitle IN ('GS', 'PGS');
GO


-- Question 21
-- Statistics on how many teachers have each academic degree 
-- ('CN', 'KS', 'ThS', 'TS', 'PTS') in each department.

SELECT
    DepartmentID,
    SUM(CASE WHEN AcademicDegree = 'CN' THEN 1 ELSE 0 END) AS CN,
    SUM(CASE WHEN AcademicDegree = 'KS' THEN 1 ELSE 0 END) AS KS,
    SUM(CASE WHEN AcademicDegree = 'ThS' THEN 1 ELSE 0 END) AS ThS,
    SUM(CASE WHEN AcademicDegree = 'TS' THEN 1 ELSE 0 END) AS TS,
    SUM(CASE WHEN AcademicDegree = 'PTS' THEN 1 ELSE 0 END) AS PTS
FROM TEACHERS
GROUP BY DepartmentID;
GO


-- Question 22
-- For each subject, statistics on the number of students
-- by result (pass and fail).

SELECT
    SubjectID,
    SUM(CASE WHEN Result = N'Đạt' THEN 1 ELSE 0 END) AS TotalPassed,
    SUM(CASE WHEN Result = N'K Đạt' THEN 1 ELSE 0 END) AS TotalFailed
FROM EXAM_RESULTS
GROUP BY SubjectID;
GO


-- Question 23
-- Find teachers (teacher ID, full name) who are head teachers of a class 
-- and also teach at least one subject to that class.

SELECT DISTINCT
    TeacherID,
    FirstName + ' ' + LastName AS FullName
FROM TEACHERS
WHERE TeacherID IN
(
    SELECT HeadTeacherID
    FROM CLASSES
    WHERE HeadTeacherID IS NOT NULL
);
GO


-- Question 24
-- Find the full name of the class monitor of the class
-- with the highest class size.

SELECT TOP 1
    FirstName + ' ' + LastName AS FullName
FROM STUDENTS
WHERE StudentID IN
(
    SELECT ClassMonitorID
    FROM CLASSES
    WHERE ClassSize =
    (
        SELECT MAX(ClassSize)
        FROM CLASSES
    )
);
GO


-- Question 25
-- Find the full name of class monitors who failed 3 or fewer subjects 
-- (every subject failed in all attempts).

SELECT DISTINCT
    FirstName + ' ' + LastName AS FullName
FROM STUDENTS
WHERE StudentID IN
(
    SELECT StudentID
    FROM EXAM_RESULTS
    GROUP BY StudentID
    HAVING SUM(CASE WHEN Result = N'K Đạt' THEN 1 ELSE 0 END) <= 3
);
GO


-- Question 26
-- Find the student (student ID, full name)
-- with the highest number of subjects scoring 9 or 10.

SELECT TOP 1
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS FullName,
    COUNT(*) AS TotalTopScores
FROM EXAM_RESULTS er
INNER JOIN STUDENTS s
    ON er.StudentID = s.StudentID
WHERE er.Score >= 9.00
GROUP BY s.StudentID, s.FirstName, s.LastName
ORDER BY TotalTopScores DESC;
GO


-- Question 27
-- In each class, find the student (student ID, full name) 
-- with the highest number of subjects scoring 9 or 10.

SELECT
    s.ClassID,
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS FullName,
    COUNT(*) AS TotalTopScores
FROM EXAM_RESULTS er
INNER JOIN STUDENTS s
    ON er.StudentID = s.StudentID
WHERE er.Score >= 9.00
GROUP BY s.ClassID, s.StudentID, s.FirstName, s.LastName
ORDER BY s.ClassID, TotalTopScores DESC;
GO


-- Question 28
-- In each semester of each year, how many subjects and how many classes 
-- is each teacher assigned to teach?

SELECT
    Semester,
    Year,
    TeacherID,
    COUNT(DISTINCT SubjectID) AS TotalSubjects,
    COUNT(DISTINCT ClassID) AS TotalClasses
FROM TEACHING_SCHEDULE
GROUP BY Semester, Year, TeacherID
ORDER BY Semester, Year, TeacherID;
GO


-- Question 29
-- In each semester of each year, find the teacher (teacher ID, full name) 
-- who teaches the most.

WITH TeachingWorkload AS (
    SELECT 
        gd.Semester, gd.Year, gd.TeacherID, 
        gv.FirstName + ' ' + gv.LastName AS FullName,
        COUNT(DISTINCT gd.SubjectID) AS TotalSubjects,
        COUNT(DISTINCT gd.ClassID) AS TotalClasses,
        ROW_NUMBER() OVER (
            PARTITION BY gd.Semester, gd.Year
            ORDER BY COUNT(DISTINCT gd.SubjectID) DESC,
            COUNT(DISTINCT gd.ClassID) DESC) as RowRank
    FROM TEACHING_SCHEDULE gd
    INNER JOIN TEACHERS gv
        ON gd.TeacherID = gv.TeacherID
    GROUP BY
        gd.Semester,
        gd.Year,
        gd.TeacherID,
        gv.FirstName,
        gv.LastName
)
SELECT
    Semester,
    Year,
    TeacherID,
    FullName,
    TotalSubjects,
    TotalClasses
FROM TeachingWorkload
WHERE RowRank = 1;
GO


-- Question 30
-- Find the subject (subject ID, subject name) with the highest number of students 
-- failing on their 1st attempt.

SELECT TOP 1
    er.SubjectID,
    sub.SubjectName,
    COUNT(*) AS TotalFailedFirstAttempt
FROM EXAM_RESULTS er
INNER JOIN SUBJECTS sub
    ON er.SubjectID = sub.SubjectID
WHERE er.AttemptNo = 1 AND er.Result = N'K Đạt'
GROUP BY er.SubjectID, sub.SubjectName
ORDER BY TotalFailedFirstAttempt DESC;
GO


-- Question 31
-- Find students (student ID, full name)
-- who passed every subject they took (considering only the 1st attempt).

SELECT
    StudentID,
    FirstName + ' ' + LastName AS FullName
FROM STUDENTS
WHERE StudentID NOT IN
(
    SELECT StudentID
    FROM EXAM_RESULTS
    WHERE AttemptNo = 1 AND Result = N'K Đạt'
)
AND StudentID IN
(
    SELECT StudentID
    FROM EXAM_RESULTS
    WHERE AttemptNo = 1
);
GO


-- Question 32
-- Find students (student ID, full name)
-- who passed every subject they took (considering only the latest attempt).

SELECT
    StudentID,
    FirstName + ' ' + LastName AS FullName
FROM STUDENTS
WHERE StudentID NOT IN
(
    SELECT er1.StudentID
    FROM EXAM_RESULTS er1
    WHERE er1.Result = N'K Đạt'
        AND er1.AttemptNo =
        (
            SELECT MAX(AttemptNo)
            FROM EXAM_RESULTS er2
            WHERE er1.StudentID = er2.StudentID 
                AND er1.SubjectID = er2.SubjectID
        )
)
AND StudentID IN (SELECT StudentID FROM EXAM_RESULTS);
GO


-- Question 33
-- Find students (student ID, full name) who have taken
-- and passed all subjects 
-- (considering only the 1st attempt).

SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS FullName
FROM STUDENTS s
INNER JOIN EXAM_RESULTS er
    ON s.StudentID = er.StudentID
WHERE er.AttemptNo = 1 AND er.Result = N'Đạt'
GROUP BY
    s.StudentID,
    s.FirstName,
    s.LastName
HAVING COUNT(DISTINCT er.SubjectID) =
(
    SELECT COUNT(*) 
    FROM SUBJECTS
);
GO


-- Question 34
-- Find students (student ID, full name) who have taken
-- and passed all subjects (considering only the latest attempt).

WITH LatestExamResult AS
(
    SELECT
        er1.StudentID,
        er1.SubjectID,
        er1.Result
    FROM EXAM_RESULTS er1
    WHERE er1.AttemptNo =
    (
        SELECT MAX(AttemptNo)
        FROM EXAM_RESULTS er2
        WHERE er1.StudentID = er2.StudentID 
            AND er1.SubjectID = er2.SubjectID
    )
)
SELECT
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS FullName
FROM STUDENTS s
INNER JOIN LatestExamResult ler
    ON s.StudentID = ler.StudentID
WHERE ler.Result = N'Đạt'
GROUP BY
    s.StudentID,
    s.FirstName,
    s.LastName
HAVING COUNT(DISTINCT ler.SubjectID) =
(
    SELECT COUNT(*) 
    FROM SUBJECTS
);
GO


-- Question 35
-- Find the student (student ID, full name)
-- with the highest score in each subject 
-- (taking the score of the latest attempt).

WITH MaxScorePerSubject AS (
    SELECT SubjectID, MAX(Score) AS MaxScore
    FROM EXAM_RESULTS er1
    WHERE AttemptNo =
    (
        SELECT MAX(AttemptNo)
        FROM EXAM_RESULTS er2
        WHERE er1.StudentID = er2.StudentID 
            AND er1.SubjectID = er2.SubjectID
    )
    GROUP BY SubjectID
)
SELECT
    er.SubjectID,
    er.StudentID,
    s.FirstName + ' ' + s.LastName AS FullName,
    er.Score
FROM EXAM_RESULTS er
INNER JOIN STUDENTS s
    ON er.StudentID = s.StudentID
INNER JOIN MaxScorePerSubject m
    ON er.SubjectID = m.SubjectID
        AND er.Score = m.MaxScore
WHERE er.AttemptNo =
(
    SELECT MAX(AttemptNo)
    FROM EXAM_RESULTS er2
    WHERE er2.StudentID = er.StudentID 
        AND er2.SubjectID = er.SubjectID
);
GO