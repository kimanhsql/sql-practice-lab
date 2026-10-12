-- ============================================================
-- CONSTRUCTION MANAGEMENT SYSTEM
-- CREATE TABLES
-- ============================================================

USE CONSTRUCTION_MANAGEMENT_SYSTEM;
GO


-- ARCHITECTS

CREATE TABLE ARCHITECTS
(
    ArchitectName NVARCHAR(100),
    BirthYear INT,
    Gender NVARCHAR(3),
    GraduationPlace NVARCHAR(200),
    ContactAddress NVARCHAR(200),

    CONSTRAINT PK_Architects
        PRIMARY KEY (ArchitectName)
);
GO


-- CONTRACTORS

CREATE TABLE CONTRACTORS
(
    ContractorName NVARCHAR(100),
    PhoneNumber NVARCHAR(20) NOT NULL,
    Address NVARCHAR(200),

    CONSTRAINT PK_Contractors
        PRIMARY KEY (ContractorName)
);
GO


-- CLIENTS

CREATE TABLE CLIENTS
(
    ClientName NVARCHAR(100),
    Address NVARCHAR(200) NOT NULL,

    CONSTRAINT PK_Clients
        PRIMARY KEY (ClientName)
);
GO


-- WORKERS

CREATE TABLE WORKERS
(
    WorkerName NVARCHAR(100),
    BirthYear INT,
    CareerStartDate DATETIME,
    Specialty NVARCHAR(200),

    CONSTRAINT PK_Workers
        PRIMARY KEY (WorkerName)
);
GO


-- CONSTRUCTION PROJECTS

CREATE TABLE CONSTRUCTION_PROJECTS
(
    ProjectID NUMERIC IDENTITY(1,1),
    ProjectName NVARCHAR(200) NOT NULL,
    ProjectAddress NVARCHAR(200),
    Province NVARCHAR(100),
    Budget FLOAT,
    ClientName NVARCHAR(100) NOT NULL,
    ContractorName NVARCHAR(100) NOT NULL,
    StartDate DATETIME,

    CONSTRAINT PK_ConstructionProjects
        PRIMARY KEY (ProjectID),

    CONSTRAINT FK_Projects_Clients
        FOREIGN KEY (ClientName)
        REFERENCES Clients(ClientName),

    CONSTRAINT FK_Projects_Contractors
        FOREIGN KEY (ContractorName)
        REFERENCES Contractors(ContractorName)
);
GO


-- WORKER PARTICIPATION

CREATE TABLE WORKER_PARTICIPATION
(
    WorkerName NVARCHAR(100),
    ProjectID NUMERIC,
    ParticipationDate DATETIME,
    NumberOfDays INT,

    CONSTRAINT PK_WorkerParticipation
        PRIMARY KEY (WorkerName, ProjectID),

    CONSTRAINT FK_Participation_Workers
        FOREIGN KEY (WorkerName)
        REFERENCES Workers(WorkerName),

    CONSTRAINT FK_Participation_Projects
        FOREIGN KEY (ProjectID)
        REFERENCES ConstructionProjects(ProjectID)
);
GO


-- PROJECT DESIGN

CREATE TABLE PROJECT_DESIGN
(
    ArchitectName NVARCHAR(100),
    ProjectID NUMERIC,
    DesignFee FLOAT,

    CONSTRAINT PK_ProjectDesign
        PRIMARY KEY (ArchitectName, ProjectID),

    CONSTRAINT FK_ProjectDesign_Architects
        FOREIGN KEY (ArchitectName)
        REFERENCES Architects(ArchitectName),

    CONSTRAINT FK_ProjectDesign_Projects
        FOREIGN KEY (ProjectID)
        REFERENCES ConstructionProjects(ProjectID)
);
GO