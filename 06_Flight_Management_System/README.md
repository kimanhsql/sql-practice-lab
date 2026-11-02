# Flight Management System

This project is a SQL Server database project based on the *Flight Management* database exercises (`TH1207_GT.pdf`).


## 1. Database Overview & Structure

**Database:** `FLIGHT_DB` (based on Flight Management System)

The database consists of 9 core tables managing information about customers, employees (pilots and flight attendants), aircraft types, individual aircraft, flights, flight schedules, bookings, pilot capabilities, and crew assignments.


### Table List

```text
CUSTOMERS
EMPLOYEES
AIRCRAFT_TYPES
AIRCRAFT
FLIGHTS
FLIGHT_SCHEDULES
BOOKINGS
PILOT_CAPABILITIES
CREW_ASSIGNMENTS
```


### Detailed Table Specifications & Constraints Note

* **Primary Keys (PK):** Explicitly defined for all tables (including composite keys for `FLIGHT_SCHEDULES`, `BOOKINGS`, `PILOT_CAPABILITIES`, and `CREW_ASSIGNMENTS`).
* **Foreign Keys (FK):** Explicitly defined linking related entities (e.g., aircraft to aircraft types, flight schedules to flights and aircraft, bookings to customers and flight schedules, pilot capabilities and crew assignments to employees, aircraft types, and flight schedules).
* **Nullability & Business Rules:** Attributes marked with `NOT NULL` are strictly enforced. Special business rules govern pilot classification (`LOAINV` = 1 for pilots, 0 for flight attendants), aircraft numbering per type, flight scheduling uniqueness, and crew assignment qualifications.

---

#### 1.1 CUSTOMERS (`KHACHHANG`)

* **Attributes & Data Types:** `CustomerID`, `Name`, `Address`, `PhoneNumber`
* **Primary Key:** `CustomerID`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages unique customer identification and contact details.

---

#### 1.2 EMPLOYEES (`NHANVIEN`)

* **Attributes & Data Types:** `EmployeeID`, `Name`, `Address`, `PhoneNumber`, `Salary`, `EmployeeType`
* **Primary Key:** `EmployeeID`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages employee profiles and salaries. `EmployeeType` (`LOAINV`) distinguishes pilots (`1`) from flight attendants (`0`).

---

#### 1.3 AIRCRAFT_TYPES (`LOAIMB`)

* **Attributes & Data Types:** `AircraftTypeID`, `Manufacturer`
* **Primary Key:** `AircraftTypeID`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages aircraft categories and their respective manufacturers (e.g., Boeing, Airbus).

---

#### 1.4 AIRCRAFT (`MAYBAY`)

* **Attributes & Data Types:** `AircraftNumber`, `AircraftTypeID`
* **Primary Key:** Composite key (`AircraftNumber`, `AircraftTypeID`) or `AircraftNumber` depending on design context.
* **Foreign Keys:** `AircraftTypeID` (references `AIRCRAFT_TYPES`)
* **Constraints & Business Rules:** Each aircraft has a unique tail/serial number within its specific aircraft type.

---

#### 1.5 FLIGHTS (`CHUYENBAY`)

* **Attributes & Data Types:** `FlightCode`, `DepartureAirport`, `ArrivalAirport`, `DepartureTime`, `ArrivalTime`
* **Primary Key:** `FlightCode`
* **Foreign Keys:** None
* **Constraints & Business Rules:** Manages route details, departure/arrival airports, and scheduled times.

---

#### 1.6 FLIGHT_SCHEDULES (`LICHBAY`)

* **Attributes & Data Types:** `DepartureDate`, `FlightCode`, `AircraftNumber`, `AircraftTypeID`
* **Primary Key:** Composite key (`DepartureDate`, `FlightCode`)
* **Foreign Keys:** `FlightCode` (references `FLIGHTS`), `AircraftNumber`, `AircraftTypeID` (references `AIRCRAFT`)
* **Constraints & Business Rules:** Each flight can have multiple schedules by departure date. A specific schedule utilizes exactly one aircraft. Maximum one assignment per flight per day.

---

#### 1.7 BOOKINGS (`DATCHO`)

* **Attributes & Data Types:** `CustomerID`, `DepartureDate`, `FlightCode`
* **Primary Key:** Composite key (`CustomerID`, `DepartureDate`, `FlightCode`)
* **Foreign Keys:** `CustomerID` (references `CUSTOMERS`), `DepartureDate`, `FlightCode` (references `FLIGHT_SCHEDULES`)
* **Constraints & Business Rules:** Customers can book specific flight schedules. Each customer is limited to a maximum of one seat per flight on a specific day.

---

#### 1.8 PILOT_CAPABILITIES (`KHANANG`)

* **Attributes & Data Types:** `EmployeeID`, `AircraftTypeID`
* **Primary Key:** Composite key (`EmployeeID`, `AircraftTypeID`)
* **Foreign Keys:** `EmployeeID` (references `EMPLOYEES`), `AircraftTypeID` (references `AIRCRAFT_TYPES`)
* **Constraints & Business Rules:** Tracks which aircraft types each pilot is qualified to fly (many-to-many relationship).

---

#### 1.9 CREW_ASSIGNMENTS (`PHANCONG`)

* **Attributes & Data Types:** `EmployeeID`, `DepartureDate`, `FlightCode`
* **Primary Key:** Composite key (`EmployeeID`, `DepartureDate`, `FlightCode`)
* **Foreign Keys:** `EmployeeID` (references `EMPLOYEES`), `DepartureDate`, `FlightCode` (references `FLIGHT_SCHEDULES`)
* **Constraints & Business Rules:** Assigns employees to specific flight schedules. Pilots must be qualified to fly the aircraft type assigned to that schedule.

---

## 2. Textbook Exercises & Requirements

### PART I: DATA DEFINITION LANGUAGE (DDL) & INTEGRITY CONSTRAINTS

* Create all 9 relations (`CUSTOMERS`, `EMPLOYEES`, `AIRCRAFT_TYPES`, `AIRCRAFT`, `FLIGHTS`, `FLIGHT_SCHEDULES`, `BOOKINGS`, `PILOT_CAPABILITIES`, `CREW_ASSIGNMENTS`) with appropriate primary and foreign keys.
* Enforce domain constraints on employee types, aircraft serial numbers, flight schedules, customer bookings, and pilot qualifications.

---

### PART II: DATA QUERYING LANGUAGE (DQL) - 56 EXERCISES

1. List ID, name, address, and phone number of pilots qualified to fly the 'B747' aircraft.
2. List ID and departure date of flights departing from airport 'DCA' between 14:00 and 18:00.
3. List the names of employees assigned to flight code '100' departing from airport 'SLC' (distinct values only).
4. List aircraft type ID and aircraft number that have departed from airport 'MIA' (distinct values only).
5. List flight code, departure date, customer name, address, and phone number for all passengers on that flight, sorted by flight code ascending and departure date descending.
6. List flight code, departure date, employee name, address, and phone number for all crew members assigned to that flight, sorted by flight code ascending and departure date descending.
7. List flight code, departure date, pilot ID, and pilot name for pilots assigned to flights landing at airport 'ORD'.
8. List flights (flight code, departure date, and pilot name) assigned to pilot ID '1001'.
9. List flight details (flight code, departure airport, departure time, arrival time, departure date) for flights landing at 'DEN', ordered by departure date descending and departure airport ascending.
10. For each pilot, list the manufacturer and aircraft type ID they are qualified to fly (output pilot name, manufacturer, aircraft type ID).
11. List pilot ID and pilot name who flew on flight code '100' on January 11, 2000.
12. List flight code, employee ID, and employee name assigned to flights departing on October 31, 2000, at airport 'MIA' at 20:30.
13. List flight information (flight code, aircraft number, aircraft type ID, manufacturer) flown by pilot 'Quang'.
14. List the names of pilots who have not been assigned to any flights.
15. List the names of customers who booked a flight using a 'Boeing' aircraft.
16. List the flight codes of flights operated exclusively with aircraft number 10 and aircraft type 'B747'.
17. For each arrival airport (`SBDEN`), count the number of landing flights, ordered by arrival airport ascending.
18. For each departure airport (`SBDI`), count the number of departing flights, ordered by departure airport ascending.
19. For each departure airport (`SBDI`), count departing flights per date (output airport code, date, and count).
20. For each arrival airport (`SBDEN`), count landing flights per date (output airport code, date, and count).
21. For each flight schedule, list flight code, departure date, and the count of non-pilot employees on that flight.
22. Count the number of flights departing from airport 'MIA' on January 11, 2000.
23. For each flight, list flight code, departure date, and total number of assigned crew members, sorted by quantity descending.
24. For each flight, list flight code, departure date, and total number of booked passengers, sorted by quantity descending.
25. For each flight, list flight code, departure date, and total salary of the crew members, sorted by total salary ascending.
26. Calculate the average salary of non-pilot employees.
27. Calculate the average salary of pilots.
28. For each aircraft type, count the number of flights using that aircraft type landing at 'ORD' (output aircraft type ID and count).
29. List departure airports (`SBDI`) and count flights for airports with more than 2 departing flights between 10:00 and 22:00.
30. List pilot names assigned to at least 2 flights on the same day.
31. List flight codes and departure dates for flights with fewer than 3 customer bookings.
32. List aircraft number and aircraft type flown by pilot ID '1001' more than 2 times.
33. For each manufacturer, count the number of aircraft types produced (output manufacturer and count).
34. List manufacturer, aircraft type ID, and aircraft number of the most heavily utilized aircraft.
35. List the name of the employee assigned to the highest number of flights.
36. List pilot information (name, address, phone number) who flew the highest number of flights.
37. List arrival airport (`SBDEN`) and flight count for the airport with the fewest landing flights.
38. List departure airport (`SBDI`) and flight count for the airport with the most departing flights.
39. List name, address, and phone number of the customer who booked the highest number of flights.
40. List ID, name, and salary of pilots qualified to fly the highest number of aircraft types.
41. List information (employee ID, name, salary) of the employee(s) with the highest salary.
42. List name and address of employees earning the highest salary within the crew of any flight they participate in.
43. List flight code, departure time, and arrival time of the earliest flight of the day.
44. List flight code and flight duration (in minutes) for the flight with the longest duration.
45. List flight code and flight duration for the flight with the shortest duration.
46. List flight code and departure date for flights operating on the 'B747' aircraft most frequently.
47. For each flight with more than 3 passengers, list flight code and the total number of crew members.
48. For each employee type with a total salary over 600,000, count the number of employees in that category (output employee type and count).
49. For each flight with more than 3 crew members, list flight code and total number of booked passengers.
50. For each aircraft type with more than one aircraft, count the number of flights allocated to that aircraft type (output aircraft type ID and count).
51. List flight codes of flights that have utilized all aircraft manufactured by 'Boeing'.
52. List ID and name of pilots qualified to fly all aircraft manufactured by 'Airbus'.
53. List names of non-pilot employees assigned to all flights with code '100'.
54. List departure dates that feature all aircraft types manufactured by 'Boeing'.
55. List aircraft types manufactured by 'Boeing' that have participated on all departure dates.
56. List IDs and names of customers who have bookings on all dates from October 31, 2000, to January 1, 2000.

---

## 3. Project Structure & Workflow

```text
06_Flight_Management_System/
├── Images/
├── SQL/
├── QLChuyenBay.sql
└── README.md
```

* **Workflow:**
1. Analyze database requirements from the textbook.
2. Create database, tables, primary keys, and foreign keys in English.
3. Implement schema modifications and integrity constraints (`ALTER TABLE`, `CHECK`, `TRIGGERS`).
4. Perform data insertion and DML updates.
5. Execute and verify all 56 data querying tasks.
6. Organize SQL scripts and finalize project documentation.

---

## 4. Current Progress

* [x] Database analysis
* [x] Database creation (English schema)
* [x] Table creation, primary keys, and foreign keys
* [x] Sample data setup
* [x] DML exercises execution & updates
* [ ] 56 SQL queries implementation and verification
* [x] Integrity constraints & Triggers implementation
* [x] SQL script organization
* [x] Project documentation (`README.md`)