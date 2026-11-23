-- ============================================================
-- FLIGHT MANAGEMENT SYSTEM
-- CREATE TABLES
-- ============================================================

USE FLIGHT_DB;
GO


CREATE TABLE CUSTOMERS
(
    CustomerID CHAR(15),
    Name NVARCHAR(15),
    Address NVARCHAR(50),
    Phone CHAR(12),

    CONSTRAINT PK_CUSTOMERS PRIMARY KEY (CustomerID)
);
GO


CREATE TABLE EMPLOYEES
(
    EmployeeID CHAR(15),
    Name NVARCHAR(15),
    Address NVARCHAR(50),
    Phone CHAR(12),
    Salary DECIMAL(10, 2),
    EmployeeType CHAR(10),

    CONSTRAINT PK_EMPLOYEES PRIMARY KEY (EmployeeID),
    CONSTRAINT CHK_EMPLOYEES CHECK (EmployeeType IN ('0', '1'))
);
GO


CREATE TABLE AIRCRAFT_TYPES
(
    AircraftTypeID CHAR(15),
    Manufacturer NVARCHAR(15),

    CONSTRAINT PK_AIRCRAFT_TYPES PRIMARY KEY (AircraftTypeID)
);
GO


CREATE TABLE AIRCRAFT
(
    SerialNumber INT,
    AircraftTypeID CHAR(15),

    CONSTRAINT PK_AIRCRAFT PRIMARY KEY (SerialNumber, AircraftTypeID),

    CONSTRAINT FK_AIRCRAFT_AIRCRAFT_TYPES
        FOREIGN KEY (AircraftTypeID)
        REFERENCES AIRCRAFT_TYPES (AircraftTypeID)
);
GO


CREATE TABLE FLIGHTS
(
    FlightID CHAR(4),
    DepartureAirport CHAR(3),
    ArrivalAirport CHAR(3),
    DepartureTime TIME,
    ArrivalTime TIME,

    CONSTRAINT PK_FLIGHTS PRIMARY KEY (FlightID)
);
GO


CREATE TABLE FLIGHT_SCHEDULES
(
    FlightDate DATE,
    FlightID CHAR(4),
    SerialNumber INT,
    AircraftTypeID CHAR(15),

    CONSTRAINT PK_FLIGHT_SCHEDULES PRIMARY KEY (FlightDate, FlightID),

    CONSTRAINT FK_FLIGHT_SCHEDULES_FLIGHTS
        FOREIGN KEY (FlightID)
        REFERENCES FLIGHTS (FlightID),

    CONSTRAINT FK_FLIGHT_SCHEDULES_AIRCRAFT
        FOREIGN KEY (SerialNumber, AircraftTypeID)
        REFERENCES AIRCRAFT (SerialNumber, AircraftTypeID)
);
GO


CREATE TABLE BOOKINGS
(
    CustomerID CHAR(15),
    FlightDate DATE,
    FlightID CHAR(4),

    CONSTRAINT PK_BOOKINGS PRIMARY KEY (CustomerID, FlightDate, FlightID),

    CONSTRAINT FK_BOOKINGS_CUSTOMERS
        FOREIGN KEY (CustomerID)
        REFERENCES CUSTOMERS (CustomerID),

    CONSTRAINT FK_BOOKINGS_FLIGHT_SCHEDULES
        FOREIGN KEY (FlightDate, FlightID)
        REFERENCES FLIGHT_SCHEDULES (FlightDate, FlightID)
);
GO


CREATE TABLE QUALIFICATIONS
(
    EmployeeID CHAR(15),
    AircraftTypeID CHAR(15),

    CONSTRAINT PK_QUALIFICATIONS PRIMARY KEY (EmployeeID, AircraftTypeID),

    CONSTRAINT FK_QUALIFICATIONS_EMPLOYEES
        FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEES (EmployeeID),

    CONSTRAINT FK_QUALIFICATIONS_AIRCRAFT_TYPES
        FOREIGN KEY (AircraftTypeID)
        REFERENCES AIRCRAFT_TYPES (AircraftTypeID)
);
GO


CREATE TABLE ASSIGNMENTS
(
    EmployeeID CHAR(15),
    FlightDate DATE,
    FlightID CHAR(4),

    CONSTRAINT PK_ASSIGNMENTS PRIMARY KEY (EmployeeID, FlightDate, FlightID),

    CONSTRAINT FK_ASSIGNMENTS_EMPLOYEES
        FOREIGN KEY (EmployeeID)
        REFERENCES EMPLOYEES (EmployeeID),

    CONSTRAINT FK_ASSIGNMENTS_FLIGHT_SCHEDULES
        FOREIGN KEY (FlightDate, FlightID)
        REFERENCES FLIGHT_SCHEDULES (FlightDate, FlightID)
);
GO