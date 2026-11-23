-- ============================================================
-- FLIGHT MANAGEMENT SYSTEM
-- DATA QUERY LANGUAGE (DQL)
-- ============================================================

USE FLIGHT_DB;
GO


-- Query 1
-- Retrieve the employee ID, name, address, and phone number
-- of pilots who have flown B747 aircraft.

SELECT DISTINCT
    emp.EmployeeID,
    emp.Name,
    emp.Address,
    emp.Phone
FROM EMPLOYEES emp
INNER JOIN ASSIGNMENTS asg
    ON asg.EmployeeID = emp.EmployeeID
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightDate = asg.FlightDate
    AND fs.FlightID = asg.FlightID
WHERE emp.EmployeeType = '1'
    AND fs.AircraftTypeID = 'B747';
GO


-- Query 2
-- Retrieve the flight ID and flight date of flights departing
-- from airport DCA between 14:00 and 18:00.

SELECT
    fs.FlightID,
    fs.FlightDate
FROM FLIGHT_SCHEDULES fs
INNER JOIN FLIGHTS flt
    ON flt.FlightID = fs.FlightID
WHERE flt.DepartureAirport = 'DCA'
    AND (flt.DepartureTime BETWEEN '14:00:00' AND '18:00:00');
GO


-- Query 3
-- Retrieve the names of employees assigned to flight 100
-- departing from airport SLC. Duplicate rows are not allowed.

SELECT DISTINCT
    emp.EmployeeID,
    emp.Name,
    asg.FlightID
FROM ASSIGNMENTS asg
INNER JOIN EMPLOYEES emp
    ON emp.EmployeeID = asg.EmployeeID
INNER JOIN FLIGHTS flt
    ON flt.FlightID = asg.FlightID
WHERE flt.FlightID = '100'
    AND flt.DepartureAirport = 'SLC';
GO


-- Query 4
-- Retrieve the aircraft type ID and serial number of aircraft
-- that have departed from airport MIA. Duplicate rows are not allowed.

SELECT DISTINCT
    ac.AircraftTypeID,
    ac.SerialNumber
FROM AIRCRAFT ac
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.AircraftTypeID = ac.AircraftTypeID
    AND fs.SerialNumber = ac.SerialNumber
INNER JOIN FLIGHTS flt
    ON flt.FlightID = fs.FlightID
WHERE flt.DepartureAirport = 'MIA';
GO


-- Query 5
-- Retrieve the flight ID, flight date, along with the name, address,
-- and phone number of all passengers on each flight.
-- Sort by flight ID ascending and flight date descending.

SELECT
    fs.FlightID,
    fs.FlightDate,
    cust.Name,
    cust.Address,
    cust.Phone
FROM FLIGHT_SCHEDULES fs
INNER JOIN BOOKINGS bk
    ON fs.FlightID = bk.FlightID
    AND fs.FlightDate = bk.FlightDate
INNER JOIN CUSTOMERS cust
    ON cust.CustomerID = bk.CustomerID
ORDER BY fs.FlightID ASC, fs.FlightDate DESC;
GO


-- Query 6
-- Retrieve the flight ID, flight date, along with the name, address,
-- and phone number of all employees assigned to each flight.
-- Sort by flight ID ascending and flight date descending.

SELECT
    fs.FlightID,
    fs.FlightDate,
    emp.Name,
    emp.Address,
    emp.Phone
FROM FLIGHT_SCHEDULES fs
INNER JOIN ASSIGNMENTS asg
    ON asg.FlightID = fs.FlightID
    AND asg.FlightDate = fs.FlightDate
INNER JOIN EMPLOYEES emp
    ON emp.EmployeeID = asg.EmployeeID
ORDER BY fs.FlightID ASC, fs.FlightDate DESC;
GO


-- Query 7
-- Retrieve the flight ID, flight date, employee ID, and name of pilots
-- assigned to flights landing at airport ORD.

SELECT
    fs.FlightID,
    fs.FlightDate,
    emp.EmployeeID,
    emp.Name
FROM FLIGHT_SCHEDULES fs
INNER JOIN FLIGHTS flt
    ON flt.FlightID = fs.FlightID
INNER JOIN ASSIGNMENTS asg
    ON asg.FlightID = fs.FlightID
    AND asg.FlightDate = fs.FlightDate
INNER JOIN EMPLOYEES emp
    ON emp.EmployeeID = asg.EmployeeID
WHERE emp.EmployeeType = '1'
    AND flt.ArrivalAirport = 'ORD';
GO


-- Query 8
-- Retrieve the flights (flight ID, flight date, and pilot name)
-- where pilot 1001 is assigned to fly.

SELECT
    fs.FlightID,
    fs.FlightDate,
    emp.Name
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
INNER JOIN ASSIGNMENTS asg
    ON asg.FlightID = flt.FlightID
    AND asg.FlightDate = fs.FlightDate
INNER JOIN EMPLOYEES emp
    ON emp.EmployeeID = asg.EmployeeID
WHERE asg.EmployeeID = '1001';
GO


-- Query 9
-- Retrieve details (flight ID, departure airport, departure time,
-- arrival time, flight date) of flights landing at DEN.
-- Sort by flight date descending and departure airport ascending.

SELECT
    flt.FlightID,
    flt.DepartureAirport,
    flt.DepartureTime,
    flt.ArrivalTime,
    fs.FlightDate
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
WHERE flt.ArrivalAirport = 'DEN'
ORDER BY fs.FlightDate DESC, flt.DepartureAirport ASC;
GO


-- Query 10
-- For each pilot, retrieve the manufacturer and aircraft type ID
-- they are qualified to fly. Output pilot name, manufacturer, and aircraft type ID.

SELECT
    emp.Name,
    at.Manufacturer,
    at.AircraftTypeID
FROM AIRCRAFT_TYPES at
INNER JOIN QUALIFICATIONS qual
    ON qual.AircraftTypeID = at.AircraftTypeID
INNER JOIN EMPLOYEES emp
    ON emp.EmployeeID = qual.EmployeeID
WHERE emp.EmployeeType = '1';
GO


-- Query 11
-- Retrieve the pilot ID and name of pilots who flew flight 100
-- on 2000-01-11.

SELECT
    emp.EmployeeID,
    emp.Name
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
INNER JOIN ASSIGNMENTS asg
    ON asg.FlightID = flt.FlightID
    AND asg.FlightDate = fs.FlightDate
INNER JOIN EMPLOYEES emp
    ON emp.EmployeeID = asg.EmployeeID
WHERE emp.EmployeeType = '1'
    AND flt.FlightID = '100'
    AND fs.FlightDate = '2000-01-11';
GO


-- Query 12
-- Retrieve the flight ID, employee ID, and employee name assigned
-- to the flight departing on 2000-10-31 from MIA at 20:30.

SELECT
    flt.FlightID,
    emp.EmployeeID,
    emp.Name
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
INNER JOIN ASSIGNMENTS asg
    ON asg.FlightID = flt.FlightID
    AND asg.FlightDate = fs.FlightDate
INNER JOIN EMPLOYEES emp
    ON emp.EmployeeID = asg.EmployeeID
WHERE fs.FlightDate = '2000-10-31'
    AND flt.DepartureAirport = 'MIA'
    AND flt.DepartureTime = '20:30:00';
GO


-- Query 13
-- Retrieve flight information (flight ID, serial number,
-- aircraft type ID, manufacturer) flown by pilot 'Quang'.

SELECT
    flt.FlightID,
    fs.SerialNumber,
    fs.AircraftTypeID,
    at.Manufacturer
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
INNER JOIN AIRCRAFT_TYPES at
    ON at.AircraftTypeID = fs.AircraftTypeID
INNER JOIN ASSIGNMENTS asg
    ON asg.FlightID = flt.FlightID
    AND asg.FlightDate = fs.FlightDate
INNER JOIN EMPLOYEES emp
    ON emp.EmployeeID = asg.EmployeeID
WHERE emp.Name = N'Quang';
GO


-- Query 14
-- Retrieve the names of pilots
-- who have not been assigned to any flight.

SELECT emp.Name
FROM EMPLOYEES emp
WHERE emp.EmployeeType = '1'
    AND NOT EXISTS
    (
        SELECT 1
        FROM ASSIGNMENTS asg
        WHERE asg.EmployeeID = emp.EmployeeID
    );
GO


-- Query 15
-- Retrieve the names of customers who have flown on Boeing aircraft.

SELECT DISTINCT cust.Name
FROM CUSTOMERS cust
INNER JOIN BOOKINGS bk
    ON bk.CustomerID = cust.CustomerID
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = bk.FlightID
    AND fs.FlightDate = bk.FlightDate
INNER JOIN AIRCRAFT_TYPES at
    ON at.AircraftTypeID = fs.AircraftTypeID
WHERE at.Manufacturer = N'Boeing';
GO


-- Query 16
-- Retrieve the flight IDs of flights operated exclusively
-- with aircraft serial number 10 and type B747.

SELECT FlightID
FROM FLIGHT_SCHEDULES
WHERE SerialNumber = 10 AND AircraftTypeID = 'B747'

EXCEPT

SELECT FlightID
FROM FLIGHT_SCHEDULES
WHERE SerialNumber <> 10 OR AircraftTypeID <> 'B747';
GO


-- Query 17
-- For each arrival airport, retrieve the number of arriving flights.
-- Sort by arrival airport ascending.

SELECT
    ArrivalAirport,
    COUNT(FlightID) AS ArrivingFlightCount
FROM FLIGHTS
GROUP BY ArrivalAirport
ORDER BY ArrivalAirport ASC;
GO


-- Query 18
-- For each departure airport, retrieve the number of departing flights.
-- Sort by departure airport ascending.

SELECT
    DepartureAirport,
    COUNT(FlightID) AS DepartingFlightCount
FROM FLIGHTS
GROUP BY DepartureAirport
ORDER BY DepartureAirport ASC;
GO


-- Query 19
-- For each departure airport, retrieve the number of departing flights
-- per day. Output departure airport, date, and flight count.

SELECT
    flt.DepartureAirport,
    fs.FlightDate,
    COUNT(flt.FlightID) AS DepartingFlightCount
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
GROUP BY
    flt.DepartureAirport,
    fs.FlightDate;
GO


-- Query 20
-- For each arrival airport, retrieve the number of arriving flights
-- per day. Output arrival airport, date, and flight count.

SELECT
    flt.ArrivalAirport,
    fs.FlightDate,
    COUNT(flt.FlightID) AS ArrivingFlightCount
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
GROUP BY
    flt.ArrivalAirport,
    fs.FlightDate;
GO


-- Query 21
-- For each flight schedule, retrieve the flight ID, flight date,
-- and the number of non-pilot employees assigned to that flight.

SELECT
    fs.FlightID,
    fs.FlightDate,
    SUM(CASE WHEN emp.EmployeeType = '0' THEN 1 ELSE 0 END) AS NonPilotCount
FROM FLIGHT_SCHEDULES fs
LEFT JOIN ASSIGNMENTS asg
    ON asg.FlightID = fs.FlightID
    AND asg.FlightDate = fs.FlightDate
LEFT JOIN EMPLOYEES emp
    ON emp.EmployeeID = asg.EmployeeID
GROUP BY
    fs.FlightID,
    fs.FlightDate;
GO


-- Query 22
-- Retrieve the number of flights departing from airport MIA
-- on 2000-01-11.

SELECT COUNT(flt.FlightID) AS DepartingFlightCount
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
WHERE flt.DepartureAirport = 'MIA'
    AND fs.FlightDate = '2000-01-11';
GO


-- Query 23
-- For each flight, retrieve the flight ID, flight date, and the number
-- of assigned employees, sorted by employee count descending.

SELECT
    flt.FlightID,
    fs.FlightDate,
    COUNT(asg.EmployeeID) AS EmployeeCount
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
INNER JOIN ASSIGNMENTS asg
    ON asg.FlightID = flt.FlightID
    AND asg.FlightDate = fs.FlightDate
GROUP BY
    flt.FlightID,
    fs.FlightDate
ORDER BY COUNT(asg.EmployeeID) DESC;
GO


-- Query 24
-- For each flight, retrieve the flight ID, flight date, and the number
-- of booked passengers, sorted by passenger count descending.

SELECT
    flt.FlightID,
    fs.FlightDate,
    COUNT(bk.CustomerID) AS PassengerCount
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
INNER JOIN BOOKINGS bk
    ON bk.FlightID = flt.FlightID
    AND bk.FlightDate = fs.FlightDate
GROUP BY
    flt.FlightID,
    fs.FlightDate
ORDER BY COUNT(bk.CustomerID) DESC;
GO


-- Query 25
-- For each flight, retrieve the flight ID, flight date,
-- and total crew salary, sorted by total salary ascending.

SELECT
    flt.FlightID,
    fs.FlightDate,
    SUM(emp.Salary) AS TotalCrewSalary
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
INNER JOIN ASSIGNMENTS asg
    ON asg.FlightID = flt.FlightID
    AND asg.FlightDate = fs.FlightDate
INNER JOIN EMPLOYEES emp
    ON emp.EmployeeID = asg.EmployeeID
GROUP BY
    flt.FlightID,
    fs.FlightDate
ORDER BY SUM(emp.Salary) ASC;
GO


-- Query 26
-- Retrieve the average salary of non-pilot employees.

SELECT AVG(Salary) AS AverageSalary
FROM EMPLOYEES
WHERE EmployeeType = '0';
GO


-- Query 27
-- Retrieve the average salary of pilots.

SELECT AVG(Salary) AS AverageSalary
FROM EMPLOYEES
WHERE EmployeeType = '1';
GO


-- Query 28
-- For each aircraft type, retrieve the number of flights operated
-- by that aircraft type landing at airport ORD.

SELECT
    fs.AircraftTypeID,
    COUNT(flt.FlightID) AS FlightCount
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
INNER JOIN AIRCRAFT ac
    ON ac.SerialNumber = fs.SerialNumber
    AND ac.AircraftTypeID = fs.AircraftTypeID
WHERE flt.ArrivalAirport = 'ORD'
GROUP BY fs.AircraftTypeID;
GO


-- Query 29
-- Retrieve the departure airport and flight count for airports
-- with more than 2 flights departing between 10:00 and 22:00.

SELECT
    flt.DepartureAirport,
    COUNT(flt.FlightID) AS FlightCount
FROM FLIGHTS flt
WHERE flt.DepartureTime BETWEEN '10:00:00' AND '22:00:00'
GROUP BY flt.DepartureAirport
HAVING COUNT(flt.FlightID) > 2;
GO


-- Query 30
-- Retrieve the names of pilots assigned to at least 2 flights
-- on the same day.

SELECT DISTINCT emp.Name
FROM EMPLOYEES emp
INNER JOIN ASSIGNMENTS asg
    ON asg.EmployeeID = emp.EmployeeID
WHERE emp.EmployeeType = '1'
GROUP BY
    emp.EmployeeID,
    emp.Name,
    asg.FlightDate
HAVING COUNT(asg.FlightID) >= 2;
GO


-- Query 31
-- Retrieve the flight ID and flight date of flights
-- with fewer than 3 booked passengers.

SELECT
    fs.FlightID,
    fs.FlightDate
FROM FLIGHT_SCHEDULES fs
LEFT JOIN BOOKINGS bk
    ON bk.FlightID = fs.FlightID
    AND bk.FlightDate = fs.FlightDate
GROUP BY
    fs.FlightID,
    fs.FlightDate
HAVING COUNT(bk.CustomerID) < 3;
GO


-- Query 32
-- Retrieve the serial number and aircraft type ID of aircraft
-- that pilot 1001 has been assigned to fly more than twice.

SELECT
    fs.SerialNumber,
    fs.AircraftTypeID
FROM FLIGHT_SCHEDULES fs
INNER JOIN ASSIGNMENTS asg
    ON asg.FlightID = fs.FlightID
    AND asg.FlightDate = fs.FlightDate
WHERE asg.EmployeeID = '1001'
GROUP BY
    fs.SerialNumber,
    fs.AircraftTypeID
HAVING COUNT(*) > 2;
GO


-- Query 33
-- For each manufacturer, retrieve the number
-- of aircraft types produced.

SELECT
    at.Manufacturer,
    COUNT(at.AircraftTypeID) AS AircraftTypeCount
FROM AIRCRAFT_TYPES at
GROUP BY at.Manufacturer;
GO


-- Query 34
-- Retrieve the manufacturer, aircraft type ID, and serial number
-- of the most frequently used aircraft.

SELECT TOP 1 WITH TIES
    at.Manufacturer,
    fs.AircraftTypeID,
    fs.SerialNumber
FROM FLIGHT_SCHEDULES fs
INNER JOIN AIRCRAFT_TYPES at
    ON at.AircraftTypeID = fs.AircraftTypeID
GROUP BY
    at.Manufacturer,
    fs.AircraftTypeID,
    fs.SerialNumber
ORDER BY COUNT(*) DESC;
GO


-- Query 35
-- Retrieve the name of the employee assigned to the most flights.

SELECT TOP 1 WITH TIES
    emp.Name
FROM EMPLOYEES emp
INNER JOIN ASSIGNMENTS asg
    ON asg.EmployeeID = emp.EmployeeID
GROUP BY
    emp.EmployeeID,
    emp.Name
ORDER BY COUNT(asg.FlightID) DESC;
GO


-- Query 36
-- Retrieve the name, address, and phone number of the pilot
-- who has flown the most flights.

SELECT TOP 1 WITH TIES
    emp.Name,
    emp.Address,
    emp.Phone
FROM EMPLOYEES emp
INNER JOIN ASSIGNMENTS asg
    ON asg.EmployeeID = emp.EmployeeID
WHERE emp.EmployeeType = '1'
GROUP BY
    emp.EmployeeID,
    emp.Name,
    emp.Address,
    emp.Phone
ORDER BY COUNT(asg.FlightID) DESC;
GO


-- Query 37
-- Retrieve the arrival airport and flight count of the airport
-- with the fewest arriving flights.

SELECT TOP 1 WITH TIES
    flt.ArrivalAirport,
    COUNT(fs.FlightID) AS ArrivingFlightCount
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
GROUP BY flt.ArrivalAirport
ORDER BY COUNT(fs.FlightID) ASC;
GO


-- Query 38
-- Retrieve the departure airport and flight count of the airport
-- with the most departing flights.

SELECT TOP 1 WITH TIES
    flt.DepartureAirport,
    COUNT(fs.FlightID) AS DepartingFlightCount
FROM FLIGHTS flt
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.FlightID = flt.FlightID
GROUP BY flt.DepartureAirport
ORDER BY COUNT(fs.FlightID) DESC;
GO


-- Query 39
-- Retrieve the name, address, and phone number of the customer
-- who has taken the most flights.

SELECT TOP 1 WITH TIES
    cust.Name,
    cust.Address,
    cust.Phone
FROM CUSTOMERS cust
INNER JOIN BOOKINGS bk
    ON bk.CustomerID = cust.CustomerID
GROUP BY
    cust.CustomerID,
    cust.Name,
    cust.Address,
    cust.Phone
ORDER BY COUNT(bk.CustomerID) DESC;
GO


-- Query 40
-- Retrieve the employee ID, name, and salary of pilots
-- qualified to fly the greatest number of aircraft types.

SELECT TOP 1 WITH TIES
    emp.EmployeeID,
    emp.Name,
    emp.Salary
FROM EMPLOYEES emp
INNER JOIN QUALIFICATIONS qual
    ON qual.EmployeeID = emp.EmployeeID
WHERE emp.EmployeeType = '1'
GROUP BY
    emp.EmployeeID,
    emp.Name,
    emp.Salary
ORDER BY COUNT(qual.AircraftTypeID) DESC;
GO


-- Query 41
-- Retrieve the employee ID, name, and salary of employees
-- earning the highest salary.

SELECT
    EmployeeID,
    Name,
    Salary
FROM EMPLOYEES
WHERE Salary =
(
    SELECT MAX(Salary)
    FROM EMPLOYEES
);
GO


-- Query 42
-- Retrieve the name and address of employees
-- who earn the highest salary among the crew assigned to
-- any flight they participate in.

SELECT DISTINCT
    emp1.Name,
    emp1.Address
FROM ASSIGNMENTS asg1
INNER JOIN EMPLOYEES emp1
    ON emp1.EmployeeID = asg1.EmployeeID
WHERE emp1.Salary =
(
    SELECT MAX(emp2.Salary)
    FROM ASSIGNMENTS asg2
    INNER JOIN EMPLOYEES emp2
        ON emp2.EmployeeID = asg2.EmployeeID
    WHERE asg2.FlightID = asg1.FlightID
        AND asg2.FlightDate = asg1.FlightDate
);
GO


-- Query 43
-- Retrieve the flight date, flight ID, departure time,
-- and arrival time of the earliest flight on each day.

SELECT
    fs1.FlightDate,
    flt1.FlightID,
    flt1.DepartureTime,
    flt1.ArrivalTime
FROM FLIGHT_SCHEDULES fs1
INNER JOIN FLIGHTS flt1
    ON flt1.FlightID = fs1.FlightID
WHERE flt1.DepartureTime =
(
    SELECT MIN(flt2.DepartureTime)
    FROM FLIGHT_SCHEDULES fs2
    INNER JOIN FLIGHTS flt2
        ON flt2.FlightID = fs2.FlightID
    WHERE fs2.FlightDate = fs1.FlightDate
);
GO


-- Query 44
-- Retrieve the flight ID and duration (in minutes)
-- of the flight with the longest flight duration.

SELECT
    FlightID,
    DATEDIFF(MINUTE, DepartureTime, ArrivalTime) AS FlightDurationMinutes
FROM FLIGHTS
WHERE DATEDIFF(MINUTE, DepartureTime, ArrivalTime) =
(
    SELECT MAX(DATEDIFF(MINUTE, DepartureTime, ArrivalTime))
    FROM FLIGHTS
);
GO


-- Query 45
-- Retrieve the flight ID and duration (in minutes)
-- of the flight with the shortest flight duration.

SELECT
    FlightID,
    DATEDIFF(MINUTE, DepartureTime, ArrivalTime) AS FlightDurationMinutes
FROM FLIGHTS
WHERE DATEDIFF(MINUTE, DepartureTime, ArrivalTime) =
(
    SELECT MIN(DATEDIFF(MINUTE, DepartureTime, ArrivalTime))
    FROM FLIGHTS
);
GO


-- Query 46
-- Retrieve the flight ID and flight date of flights
-- that have flown on B747 aircraft the most times.

SELECT
    fs.FlightID,
    fs.FlightDate
FROM FLIGHT_SCHEDULES fs
WHERE fs.AircraftTypeID = 'B747'
    AND fs.FlightID IN
    (
        SELECT TOP 1 WITH TIES
            FlightID
        FROM FLIGHT_SCHEDULES
        WHERE AircraftTypeID = 'B747'
        GROUP BY FlightID
        ORDER BY COUNT(FlightID) DESC
    );
GO


-- Query 47
-- For each flight with more than 3 passengers,
-- retrieve the flight ID and the number
-- of employees assigned to that flight.

SELECT
    fs.FlightID,
    COUNT(DISTINCT asg.EmployeeID) AS EmployeeCount
FROM FLIGHT_SCHEDULES fs
INNER JOIN ASSIGNMENTS asg
    ON asg.FlightID = fs.FlightID
    AND asg.FlightDate = fs.FlightDate
INNER JOIN BOOKINGS bk
    ON bk.FlightID = fs.FlightID
    AND bk.FlightDate = fs.FlightDate
GROUP BY fs.FlightID
HAVING COUNT(DISTINCT bk.CustomerID) > 3;
GO


-- Query 48
-- For each employee type with a total salary exceeding 600,000,
-- retrieve the employee type and the count of employees in that type.

SELECT
    EmployeeType,
    COUNT(EmployeeID) AS EmployeeCount
FROM EMPLOYEES
GROUP BY EmployeeType
HAVING SUM(Salary) > 600000;
GO


-- Query 49
-- For each flight with more than 3 employees, retrieve the flight ID
-- and the number of customers who booked a seat on that flight.

SELECT
    bk.FlightID,
    COUNT(DISTINCT bk.CustomerID) AS BookedCustomerCount
FROM BOOKINGS bk
INNER JOIN ASSIGNMENTS asg
    ON asg.FlightID = bk.FlightID
    AND asg.FlightDate = bk.FlightDate
GROUP BY bk.FlightID
HAVING COUNT(DISTINCT asg.EmployeeID) > 3;
GO


-- Query 50
-- For each aircraft type with more than one aircraft, retrieve
-- the aircraft type ID and the number of flights scheduled with it.

SELECT
    ac.AircraftTypeID,
    COUNT(DISTINCT fs.FlightID) AS ScheduledFlightCount
FROM AIRCRAFT ac
LEFT JOIN FLIGHT_SCHEDULES fs
    ON fs.AircraftTypeID = ac.AircraftTypeID
    AND fs.SerialNumber = ac.SerialNumber
GROUP BY ac.AircraftTypeID
HAVING COUNT(DISTINCT ac.SerialNumber) > 1;
GO


-- Query 51
-- Retrieve the flight IDs of flights that have been operated
-- by all Boeing aircraft.

SELECT
    fs.FlightID
FROM FLIGHT_SCHEDULES fs
INNER JOIN AIRCRAFT_TYPES at
    ON at.AircraftTypeID = fs.AircraftTypeID
WHERE at.Manufacturer = N'Boeing'
GROUP BY fs.FlightID
HAVING COUNT(DISTINCT CONCAT(fs.AircraftTypeID, '-', fs.SerialNumber)) =
(
    SELECT COUNT(*)
    FROM AIRCRAFT ac
    INNER JOIN AIRCRAFT_TYPES at2
        ON at2.AircraftTypeID = ac.AircraftTypeID
    WHERE at2.Manufacturer = 'Boeing'
);
GO


-- Query 52
-- Retrieve the employee ID and name of pilots qualified to fly
-- all aircraft types manufactured by Airbus.

SELECT
    qual.EmployeeID,
    emp.Name
FROM QUALIFICATIONS qual
INNER JOIN EMPLOYEES emp
    ON emp.EmployeeID = qual.EmployeeID
INNER JOIN AIRCRAFT_TYPES at
    ON at.AircraftTypeID = qual.AircraftTypeID
WHERE emp.EmployeeType = '1'
    AND at.Manufacturer = 'Airbus'
GROUP BY
    qual.EmployeeID,
    emp.Name
HAVING COUNT(DISTINCT qual.AircraftTypeID) =
(
    SELECT COUNT(AircraftTypeID)
    FROM AIRCRAFT_TYPES
    WHERE Manufacturer = 'Airbus'
);
GO


-- Query 53
-- Retrieve the names of non-pilot employees assigned to
-- all scheduled instances of flight 100.

SELECT emp.Name
FROM EMPLOYEES emp
INNER JOIN ASSIGNMENTS asg
    ON asg.EmployeeID = emp.EmployeeID
WHERE emp.EmployeeType = '0'
    AND asg.FlightID = '100'
GROUP BY
    emp.EmployeeID,
    emp.Name
HAVING COUNT(DISTINCT asg.FlightDate) =
(
    SELECT COUNT(DISTINCT FlightDate)
    FROM FLIGHT_SCHEDULES
    WHERE FlightID = '100'
);
GO


-- Query 54
-- Retrieve the flight dates on
-- which all Boeing aircraft types participated.

SELECT fs.FlightDate
FROM FLIGHT_SCHEDULES fs
INNER JOIN AIRCRAFT_TYPES at
    ON at.AircraftTypeID = fs.AircraftTypeID
WHERE at.Manufacturer = 'Boeing'
GROUP BY fs.FlightDate
HAVING COUNT(DISTINCT at.AircraftTypeID) =
(
    SELECT COUNT(DISTINCT AircraftTypeID)
    FROM AIRCRAFT_TYPES
    WHERE Manufacturer = 'Boeing'
);
GO


-- Query 55
-- Retrieve the Boeing aircraft types that participated on
-- all flight dates.

SELECT at.AircraftTypeID
FROM AIRCRAFT_TYPES at
INNER JOIN FLIGHT_SCHEDULES fs
    ON fs.AircraftTypeID = at.AircraftTypeID
WHERE at.Manufacturer = 'Boeing'
GROUP BY at.AircraftTypeID
HAVING COUNT(DISTINCT fs.FlightDate) =
(
    SELECT COUNT(DISTINCT FlightDate)
    FROM FLIGHT_SCHEDULES
);
GO


-- Query 56
-- Retrieve the customer ID and name of customers who made bookings
-- on all flight dates from 2000-10-31 to 2001-01-01.

SELECT
    bk.CustomerID,
    cust.Name
FROM CUSTOMERS cust
INNER JOIN BOOKINGS bk
    ON bk.CustomerID = cust.CustomerID
WHERE bk.FlightDate BETWEEN '2000-10-31' AND '2001-01-01'
GROUP BY
    bk.CustomerID,
    cust.Name
HAVING COUNT(DISTINCT bk.FlightDate) =
(
    SELECT COUNT(DISTINCT FlightDate)
    FROM FLIGHT_SCHEDULES
    WHERE FlightDate BETWEEN '2000-10-31' AND '2001-01-01'
);
GO