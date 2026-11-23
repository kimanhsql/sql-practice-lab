-- ============================================================
-- STUDENT MANAGEMENT SYSTEM
-- DATA MANIPULATION LANGUAGE (DML)
-- ============================================================

USE STUDENT_DB;
GO


ALTER TABLE DEPARTMENTS ALTER COLUMN DeanID VARCHAR(4);
GO

INSERT INTO DEPARTMENTS (DepartmentID, DepartmentName, EstablishedDate, DeanID)
VALUES
    ('KHMT', 'Computer Science', '2005-06-07', NULL),
    ('HTTT', 'Information Systems', '2005-06-07', NULL),
    ('CNPM', 'Software Engineering', '2005-06-07', NULL),
    ('MTT', 'Network and Communications', '2005-10-20', NULL),
    ('KTMT', 'Computer Engineering', '2005-12-20', NULL);
GO

-- Insert data into SUBJECTS.

INSERT INTO SUBJECTS (SubjectID, SubjectName, TheoryCredits, LabCredits, DepartmentID)
VALUES
    ('THDC', 'General Informatics', 4, 1, 'KHMT'),
    ('CTRR', 'Discrete Mathematics', 4, 1, 'KHMT'),
    ('CSDL', 'Database Systems', 3, 1, 'HTTT'),
    ('CTDLGT', 'Data Structures and Algorithms', 3, 1, 'KHMT'),
    ('PTTKTT', 'Algorithm Design and Analysis', 3, 0, 'KHMT'),
    ('DHMT', 'Computer Graphics', 3, 1, 'KHMT'),
    ('KTMT', 'Computer Architecture', 3, 0, 'KTMT'),
    ('TKCSDL', 'Database Design', 3, 1, 'HTTT'),
    ('PTTKHTTT', 'Information Systems Analysis and Design', 4, 1, 'HTTT'),
    ('HDH', 'Operating Systems', 3, 1, 'KTMT'),
    ('NMCNPM', 'Introduction to Software Engineering', 3, 0, 'CNPM'),
    ('LTCFW', 'C Programming for Windows', 3, 1, 'CNPM'),
    ('LTHDT', 'Object-Oriented Programming', 3, 1, 'CNPM');
GO

-- Insert data into PREREQUISITES.

INSERT INTO PREREQUISITES (SubjectID, PrerequisiteSubjectID)
VALUES
    ('CSDL', 'CTRR'),
    ('CSDL', 'CTDLGT'),
    ('CTDLGT', 'THDC'),
    ('PTTKTT', 'THDC'),
    ('PTTKTT', 'CTDLGT'),
    ('DHMT', 'THDC'),
    ('LTHDT', 'THDC'),
    ('PTTKHTTT', 'CSDL');
GO

-- Insert data into LECTURERS.

INSERT INTO LECTURERS (LecturerID, FullName, Degree, AcademicTitle, Gender, DateOfBirth, HireDate, SalaryFactor, BaseSalary, DepartmentID)
VALUES
    ('GV01', 'Ho Thanh Son', 'PhD', 'Prof', 'Male', '1950-05-02', '2004-01-11', 5.00, 2250000, 'KHMT'),
    ('GV02', 'Tran Tam Thanh', 'PhD', 'AssocProf', 'Male', '1965-12-17', '2004-04-20', 4.50, 2025000, 'HTTT'),
    ('GV03', 'Do Nghiem Phung', 'PhD', 'Prof', 'Female', '1950-08-01', '2004-09-23', 4.00, 1800000, 'CNPM'),
    ('GV04', 'Tran Nam Son', 'PhD', 'AssocProf', 'Male', '1961-02-22', '2005-01-12', 4.50, 2025000, 'KTMT'),
    ('GV05', 'Mai Thanh Danh', 'MSc', 'Lec', 'Male', '1958-03-12', '2005-01-12', 3.00, 1350000, 'HTTT'),
    ('GV06', 'Tran Doan Hung', 'PhD', 'Lec', 'Male', '1953-03-11', '2005-01-12', 4.50, 2025000, 'KHMT'),
    ('GV07', 'Nguyen Minh Tien', 'MSc', 'Lec', 'Male', '1971-11-23', '2005-03-01', 4.00, 1800000, 'KHMT'),
    ('GV08', 'Le Thi Tran', 'BEng', NULL, 'Female', '1974-03-26', '2005-03-01', 1.69, 760500, 'KHMT'),
    ('GV09', 'Nguyen To Lan', 'MSc', 'Lec', 'Female', '1966-12-31', '2005-03-01', 4.00, 1800000, 'HTTT'),
    ('GV10', 'Le Tran Anh Loan', 'BEng', NULL, 'Female', '1972-07-17', '2005-03-01', 1.86, 837000, 'CNPM'),
    ('GV11', 'Ho Thanh Tung', 'BSc', 'Lec', 'Male', '1980-01-12', '2005-05-15', 2.67, 1201500, 'MTT'),
    ('GV12', 'Tran Van Anh', 'BSc', NULL, 'Female', '1981-03-29', '2005-05-15', 1.69, 760500, 'CNPM'),
    ('GV13', 'Nguyen Linh Dan', 'BSc', NULL, 'Female', '1980-05-23', '2005-05-15', 1.69, 760500, 'KTMT'),
    ('GV14', 'Truong Minh Chau', 'MSc', 'Lec', 'Female', '1976-11-30', '2005-05-15', 3.00, 1350000, 'MTT'),
    ('GV15', 'Le Ha Thanh', 'MSc', 'Lec', 'Male', '1978-05-04', '2005-05-15', 3.00, 1350000, 'KHMT');
GO

-- Update department deans.

UPDATE DEPARTMENTS SET DeanID = 'GV01' WHERE DepartmentID = 'KHMT';
GO
UPDATE DEPARTMENTS SET DeanID = 'GV02' WHERE DepartmentID = 'HTTT';
GO
UPDATE DEPARTMENTS SET DeanID = 'GV03' WHERE DepartmentID = 'CNPM';
GO

-- Insert data into CLASSES.

ALTER TABLE CLASSES ALTER COLUMN ClassMonitorID VARCHAR(5);
GO

INSERT INTO CLASSES (ClassID, ClassName, ClassMonitorID, ClassSize, AdvisorID)
VALUES
    ('K11', 'Class 1 Cohort 1', NULL, 11, 'GV07'),
    ('K12', 'Class 2 Cohort 1', NULL, 12, 'GV09'),
    ('K13', 'Class 3 Cohort 1', NULL, 12, 'GV14');
GO

-- Insert data into STUDENTS.

INSERT INTO STUDENTS (StudentID, LastName, FirstName, DateOfBirth, Gender, BirthPlace, ClassID)
VALUES
    ('K1101', 'Nguyen Van', 'A', '1986-01-27', 'Male', 'Ho Chi Minh City', 'K11'),
    ('K1102', 'Tran Ngoc', 'Han', '1986-03-14', 'Female', 'Kien Giang', 'K11'),
    ('K1103', 'Ha Duy', 'Lap', '1986-04-18', 'Male', 'Nghe An', 'K11'),
    ('K1104', 'Tran Ngoc', 'Linh', '1986-03-30', 'Female', 'Tay Ninh', 'K11'),
    ('K1105', 'Tran Minh', 'Long', '1986-02-27', 'Male', 'Ho Chi Minh City', 'K11'),
    ('K1106', 'Le Nhat', 'Minh', '1986-01-24', 'Male', 'Ho Chi Minh City', 'K11'),
    ('K1107', 'Nguyen Nhu', 'Nhut', '1986-01-27', 'Male', 'Ha Noi', 'K11'),
    ('K1108', 'Nguyen Manh', 'Tam', '1986-02-27', 'Male', 'Kien Giang', 'K11'),
    ('K1109', 'Phan Thi Thanh', 'Tam', '1986-01-27', 'Female', 'Vinh Long', 'K11'),
    ('K1110', 'Le Hoai', 'Thuong', '1986-02-05', 'Female', 'Can Tho', 'K11'),
    ('K1111', 'Le Ha', 'Vinh', '1986-12-25', 'Male', 'Vinh Long', 'K11'),
    ('K1201', 'Nguyen Van', 'B', '1986-02-11', 'Male', 'Ho Chi Minh City', 'K12'),
    ('K1202', 'Nguyen Thi Kim', 'Duyen', '1986-01-18', 'Female', 'Ho Chi Minh City', 'K12'),
    ('K1203', 'Tran Thi Kim', 'Duyen', '1986-09-17', 'Female', 'Ho Chi Minh City', 'K12'),
    ('K1204', 'Truong My', 'Hanh', '1986-05-19', 'Female', 'Dong Nai', 'K12'),
    ('K1205', 'Nguyen Thanh', 'Nam', '1986-04-17', 'Male', 'Ho Chi Minh City', 'K12'),
    ('K1206', 'Nguyen Thi Truc', 'Thanh', '1986-03-04', 'Female', 'Kien Giang', 'K12'),
    ('K1207', 'Tran Thi Bich', 'Thuy', '1986-02-08', 'Female', 'Nghe An', 'K12'),
    ('K1208', 'Huynh Thi Kim', 'Trieu', '1986-04-08', 'Female', 'Tay Ninh', 'K12'),
    ('K1209', 'Pham Thanh', 'Trieu', '1986-02-23', 'Male', 'Ho Chi Minh City', 'K12'),
    ('K1210', 'Ngo Thanh', 'Tuan', '1986-02-14', 'Male', 'Ho Chi Minh City', 'K12'),
    ('K1211', 'Do Thi', 'Xuan', '1986-03-09', 'Female', 'Ha Noi', 'K12'),
    ('K1212', 'Le Thi Phi', 'Yen', '1986-03-12', 'Female', 'Ho Chi Minh City', 'K12'),
    ('K1301', 'Nguyen Thi Kim', 'Cuc', '1986-06-09', 'Female', 'Kien Giang', 'K13'),
    ('K1302', 'Truong Thi My', 'Hien', '1986-03-18', 'Female', 'Nghe An', 'K13'),
    ('K1303', 'Le Duc', 'Hien', '1986-03-21', 'Male', 'Tay Ninh', 'K13'),
    ('K1304', 'Le Quang', 'Hien', '1986-04-18', 'Male', 'Ho Chi Minh City', 'K13'),
    ('K1305', 'Le Thi', 'Huong', '1986-03-27', 'Female', 'Ho Chi Minh City', 'K13'),
    ('K1306', 'Nguyen Thai', 'Huu', '1986-03-30', 'Male', 'Ha Noi', 'K13'),
    ('K1307', 'Le Thanh', 'Cong', '1986-10-20', 'Male', 'Hai Phong', 'K13'),
    ('K1308', 'Tran Thi Le', 'Thanh', '1986-01-01', 'Female', 'Ca Mau', 'K13'),
    ('K1309', 'Huynh Ngoc', 'Tham', '1986-11-05', 'Female', 'Vinh Long', 'K13'),
    ('K1310', 'Tran Thi Ngoc', 'Tuyen', '1986-03-10', 'Female', 'Bac Kan', 'K13'),
    ('K1311', 'Tran Pham', 'Linh', '1986-11-11', 'Male', 'Soc Trang', 'K13'),
    ('K1312', 'Nguyen', 'Minh', '1986-02-14', 'Male', 'Da Lat', 'K13');
GO

-- Update class monitors.

UPDATE CLASSES SET ClassMonitorID = 'K1108' WHERE ClassID = 'K11';
GO
UPDATE CLASSES SET ClassMonitorID = 'K1205' WHERE ClassID = 'K12';
GO
UPDATE CLASSES SET ClassMonitorID = 'K1305' WHERE ClassID = 'K13';
GO

-- Insert data into TEACHINGS.

INSERT INTO TEACHINGS (ClassID, SubjectID, LecturerID, Semester, AcademicYear, StartDate, EndDate)
VALUES
    ('K11', 'THDC', 'GV07', 1, 2006, '2006-01-02', '2006-05-12'),
    ('K12', 'THDC', 'GV06', 1, 2006, '2006-01-02', '2006-05-12'),
    ('K13', 'THDC', 'GV15', 1, 2006, '2006-01-02', '2006-05-12'),
    ('K11', 'CTRR', 'GV01', 1, 2006, '2006-01-09', '2006-05-17'),
    ('K12', 'CTRR', 'GV15', 1, 2006, '2006-01-09', '2006-05-17'),
    ('K13', 'CTRR', 'GV08', 1, 2006, '2006-01-09', '2006-05-17'),
    ('K11', 'CTDLGT', 'GV06', 2, 2006, '2006-06-01', '2006-07-15'),
    ('K12', 'CTDLGT', 'GV08', 2, 2006, '2006-06-01', '2006-07-15'),
    ('K13', 'CTDLGT', 'GV15', 2, 2006, '2006-06-01', '2006-07-15'),
    ('K13', 'CSDL', 'GV05', 3, 2006, '2006-08-01', '2006-12-15'),
    ('K13', 'DHMT', 'GV07', 3, 2006, '2006-08-01', '2006-12-15'),
    ('K11', 'CSDL', 'GV02', 3, 2006, '2006-08-01', '2006-12-15'),
    ('K12', 'CSDL', 'GV09', 3, 2006, '2006-08-01', '2006-12-15'),
    ('K11', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-02-18'),
    ('K12', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-03-20'),
    ('K11', 'DHMT', 'GV07', 1, 2007, '2007-02-18', '2007-03-20');
GO

-- Insert data into EXAM_RESULTS.

INSERT INTO EXAM_RESULTS (StudentID, SubjectID, AttemptNumber, ExamDate, Score, Result)
VALUES
    ('K1101', 'CSDL', 1, '2006-12-20', 10.00, NULL),
    ('K1101', 'CTDLGT', 1, '2006-07-25', 9.00, NULL),
    ('K1101', 'THDC', 1, '2006-05-20', 9.00, NULL),
    ('K1101', 'CTRR', 1, '2006-05-20', 9.50, NULL),
    ('K1102', 'CSDL', 1, '2006-12-20', 4.00, NULL),
    ('K1102', 'CSDL', 2, '2006-12-27', 4.25, NULL),
    ('K1102', 'CSDL', 3, '2007-01-10', 4.50, NULL),
    ('K1102', 'CTDLGT', 1, '2006-07-25', 4.50, NULL),
    ('K1102', 'CTDLGT', 2, '2006-08-05', 4.00, NULL),
    ('K1102', 'CTDLGT', 3, '2006-08-15', 6.00, NULL),
    ('K1102', 'THDC', 1, '2006-05-20', 5.00, NULL),
    ('K1102', 'CTRR', 1, '2006-05-20', 7.00, NULL),
    ('K1103', 'CSDL', 1, '2006-12-20', 3.50, NULL),
    ('K1103', 'CSDL', 2, '2007-01-05', 8.25, NULL),
    ('K1103', 'CTDLGT', 1, '2006-07-25', 7.00, NULL),
    ('K1103', 'THDC', 1, '2006-05-20', 8.00, NULL),
    ('K1103', 'CTRR', 1, '2006-05-20', 6.50, NULL),
    ('K1104', 'CSDL', 1, '2006-12-20', 3.75, NULL),
    ('K1104', 'CTDLGT', 1, '2006-07-25', 4.00, NULL),
    ('K1104', 'THDC', 1, '2006-05-20', 4.00, NULL),
    ('K1104', 'CTRR', 1, '2006-05-20', 4.00, NULL),
    ('K1104', 'CTRR', 2, '2006-05-25', 3.50, NULL),
    ('K1104', 'CTRR', 3, '2006-06-30', 5.00, NULL),
    ('K1201', 'CSDL', 1, '2006-12-20', 6.00, NULL),
    ('K1201', 'CTDLGT', 1, '2006-07-25', 5.00, NULL),
    ('K1201', 'THDC', 1, '2006-05-20', 8.50, NULL),
    ('K1201', 'CTRR', 1, '2006-05-20', 9.00, NULL),
    ('K1202', 'CSDL', 1, '2006-12-20', 8.00, NULL),
    ('K1202', 'CTDLGT', 1, '2006-07-25', 4.00, NULL),
    ('K1202', 'CTDLGT', 2, '2006-08-05', 5.00, NULL),
    ('K1202', 'THDC', 1, '2006-05-20', 4.00, NULL),
    ('K1202', 'THDC', 2, '2006-05-27', 5.00, NULL),
    ('K1202', 'CTRR', 1, '2006-05-20', 3.00, NULL),
    ('K1202', 'CTRR', 2, '2006-05-25', 4.00, NULL),
    ('K1202', 'CTRR', 3, '2006-06-30', 6.25, NULL),
    ('K1203', 'CSDL', 1, '2006-12-20', 9.25, NULL),
    ('K1203', 'CTDLGT', 1, '2006-07-25', 9.50, NULL),
    ('K1203', 'THDC', 1, '2006-05-20', 10.00, NULL),
    ('K1203', 'CTRR', 1, '2006-05-20', 10.00, NULL),
    ('K1204', 'CSDL', 1, '2006-12-20', 8.50, NULL),
    ('K1204', 'CTDLGT', 1, '2006-07-25', 6.75, NULL),
    ('K1204', 'THDC', 1, '2006-05-20', 5.00, NULL),
    ('K1204', 'CTRR', 1, '2006-05-20', 6.00, NULL),
    ('K1301', 'CSDL', 1, '2006-12-20', 4.25, NULL),
    ('K1301', 'CTDLGT', 1, '2006-07-25', 8.00, NULL),
    ('K1301', 'THDC', 1, '2006-05-20', 7.75, NULL),
    ('K1301', 'CTRR', 1, '2006-05-20', 8.00, NULL),
    ('K1302', 'CSDL', 1, '2006-12-20', 6.75, NULL),
    ('K1302', 'CTDLGT', 1, '2006-07-25', 5.00, NULL),
    ('K1302', 'THDC', 1, '2006-05-20', 8.00, NULL),
    ('K1302', 'CTRR', 1, '2006-05-20', 8.50, NULL),
    ('K1303', 'CSDL', 1, '2006-12-20', 4.00, NULL),
    ('K1303', 'CTDLGT', 1, '2006-07-25', 4.50, NULL),
    ('K1303', 'CTDLGT', 2, '2006-08-07', 4.00, NULL),
    ('K1303', 'CTDLGT', 3, '2006-08-15', 5.00, NULL),
    ('K1303', 'THDC', 1, '2006-05-20', 4.50, NULL),
    ('K1303', 'CTRR', 1, '2006-05-20', 3.25, NULL),
    ('K1303', 'CTRR', 2, '2006-05-25', 5.00, NULL),
    ('K1304', 'CSDL', 1, '2006-12-20', 7.75, NULL),
    ('K1304', 'CTDLGT', 1, '2006-07-25', 9.75, NULL),
    ('K1304', 'THDC', 1, '2006-05-20', 5.50, NULL),
    ('K1304', 'CTRR', 1, '2006-05-20', 5.00, NULL),
    ('K1305', 'CSDL', 1, '2006-12-20', 9.25, NULL),
    ('K1305', 'CTDLGT', 1, '2006-07-25', 10.00, NULL),
    ('K1305', 'THDC', 1, '2006-05-20', 8.00, NULL),
    ('K1305', 'CTRR', 1, '2006-05-20', 10.00, NULL);
GO

-- Update exam results for students.

UPDATE EXAM_RESULTS SET Result = 'Passed' WHERE Score >= 5.0 AND Result IS NULL;
GO
UPDATE EXAM_RESULTS SET Result = 'Failed' WHERE Score < 5.0 AND Result IS NULL;
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