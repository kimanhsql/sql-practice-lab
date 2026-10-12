/*
    Project: Teaching Management System

    This file modifies the existing tables by adding
    new columns and integrity constraints.

    Source:
    QLGiangDay exercise - Page 100
*/

USE TEACHING_MANAGEMENT_SYSTEM;
GO


-- TEACHERS

ALTER TABLE TEACHERS
    ADD BirthDate DATE;
GO


ALTER TABLE TEACHERS
    ADD Gender VARCHAR(3);
GO


ALTER TABLE TEACHERS
    ADD Age INT;
GO


-- Add an integrity constraint for teacher age.

ALTER TABLE TEACHERS
    ADD CONSTRAINT CHK_Teachers_Age
        CHECK (Age BETWEEN 22 AND 67);
GO


-- CLASSROOMS

ALTER TABLE CLASSROOMS
    ADD Capacity INT;
GO


ALTER TABLE CLASSROOMS
    ADD CONSTRAINT CHK_Classrooms_Capacity
        CHECK (Capacity > 0);
GO


-- SUBJECTS

ALTER TABLE SUBJECTS
    ADD TotalCredits INT;
GO


ALTER TABLE SUBJECTS
    ADD TheoryCredits INT;
GO


ALTER TABLE SUBJECTS
    ADD PracticalCredits INT;
GO


-- Validate the total number of credits.

ALTER TABLE SUBJECTS
    ADD CONSTRAINT CHK_Subjects_TotalCredits
        CHECK (TotalCredits BETWEEN 1 AND 4);
GO


ALTER TABLE SUBJECTS
    ADD CONSTRAINT CHK_Subjects_TheoryCredits
        CHECK (TheoryCredits BETWEEN 0 AND 4);
GO


ALTER TABLE SUBJECTS
    ADD CONSTRAINT CHK_Subjects_PracticalCredits
        CHECK (PracticalCredits BETWEEN 0 AND 4);
GO


ALTER TABLE SUBJECTS
    ADD CONSTRAINT CHK_Subjects_CreditTotal
        CHECK (TotalCredits = TheoryCredits + PracticalCredits);
GO


-- CLASSES

ALTER TABLE Classes
    ADD ClassSize INT;
GO

ALTER TABLE Classes
    ADD CONSTRAINT CHK_Classes_ClassSize
        CHECK (ClassSize > 0);
GO


-- ============================================================
-- Requirement 8
-- Integrity constraints required for:
-- ClassSize
-- TotalCredits
-- TheoryCredits
-- PracticalCredits
-- Capacity
-- Age
-- ============================================================

-- The constraints for these columns were created
-- together with the corresponding ALTER TABLE statements above.