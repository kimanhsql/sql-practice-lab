-- ============================================================
-- TEACHING MANAGEMENT SYSTEM
-- CREATE TABLES
-- ============================================================

USE TEACHING_MANAGEMENT_SYSTEM;
GO


-- DEPARTMENTS

CREATE TABLE DEPARTMENTS
(
    DepartmentID VARCHAR(5),
    DepartmentName VARCHAR(200) NOT NULL,

    CONSTRAINT PK_Departments
        PRIMARY KEY (DepartmentID)
);
GO


-- TEACHERS

CREATE TABLE TEACHERS
(
    TeacherID VARCHAR(5),
    FullName VARCHAR(100) NOT NULL,
    DepartmentID VARCHAR(5) NOT NULL,

    CONSTRAINT PK_Teachers
        PRIMARY KEY (TeacherID),

    CONSTRAINT FK_Departments_Teachers
        FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);
GO


-- SUBJECTS

CREATE TABLE SUBJECTS
(
    SubjectID VARCHAR(20),
    SubjectName VARCHAR(200) NOT NULL,

    CONSTRAINT PK_Subjects
        PRIMARY KEY (SubjectID)
);
GO


-- CLASSROOMS

CREATE TABLE CLASSROOMS
(
    ClassroomID VARCHAR(5),
    FunctionDescription VARCHAR(200),

    CONSTRAINT PK_Classrooms
        PRIMARY KEY (ClassroomID)
);
GO


-- CLASSES

CREATE TABLE CLASSES
(
    ClassID VARCHAR(5),
    ClassName VARCHAR(200) NOT NULL,
    DepartmentID VARCHAR(5) NOT NULL,

    CONSTRAINT PK_Classes
        PRIMARY KEY (ClassID),

    CONSTRAINT FK_Departments_Classes
        FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);
GO


-- TEACHING SCHEDULE

CREATE TABLE TEACHING_SCHEDULE
(
    TeacherID VARCHAR(5),
    SubjectID VARCHAR(20),
    ClassroomID VARCHAR(5),
    ClassID VARCHAR(5),
    TeachingDate DATETIME,
    StartPeriod INT,
    EndPeriod INT,
    Lesson VARCHAR(200),
    Theory VARCHAR(200),
    Notes VARCHAR(200),

    CONSTRAINT PK_TeachingSchedule
        PRIMARY KEY (TeacherID, SubjectID, ClassroomID, ClassID),

    CONSTRAINT FK_Teachers_TeachingSchedule
        FOREIGN KEY (TeacherID)
        REFERENCES Teachers(TeacherID),

    CONSTRAINT FK_Subjects_TeachingSchedule
        FOREIGN KEY (SubjectID)
        REFERENCES Subjects(SubjectID),

    CONSTRAINT FK_Classrooms_TeachingSchedule
        FOREIGN KEY (ClassroomID)
        REFERENCES Classrooms(ClassroomID),

    CONSTRAINT FK_Classes_TeachingSchedule
        FOREIGN KEY (ClassID)
        REFERENCES Classes(ClassID)
);
GO