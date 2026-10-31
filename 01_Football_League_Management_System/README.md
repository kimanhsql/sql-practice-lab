# Football League Management System

This project is a SQL Server database project based on the `QLBongDa` exercises from the *Database Fundamentals* textbook (`TH1207_GT.pdf`, pages 96–99 and 105–108).

---

## 1. Database Overview & Structure

**Database:** `FOOTBALL_LEAGUE_DB` (based on `QLBongDa`)

The database consists of 9 core tables managing information about countries, stadiums, provinces, clubs, players, coaches, club-coaches, matches, and standings.


### Table List

```text
COUNTRIES
STADIUMS
PROVINCES
CLUBS
PLAYERS
COACHES
CLUB_COACHES
MATCHES
STANDINGS
```


### Detailed Table Specifications & Constraints Note

* **Primary Keys (PK):** Explicitly defined for all tables (including composite keys for `CLUB_COACHES` and `STANDINGS`).
* **Foreign Keys (FK):** Explicitly defined linking related entities (e.g., clubs to stadiums and provinces, players to clubs and countries).
* **Nullability:** Attributes marked as **NOT NULL** are strictly enforced. Unmarked attributes default to allowing `NULL` values unless constrained by business rules.
* **Identity:** `PLAYER_ID` (in `PLAYERS`) and `MATCH_ID` (in `MATCHES`) are auto-incrementing fields.

---

#### 1.1 COUNTRIES

* **Attributes & Data Types:** `COUNTRY_ID` (VARCHAR(5)), `COUNTRY_NAME` (NVARCHAR(60))
* **Primary Key:** `COUNTRY_ID`
* **Foreign Keys:** None
* **Constraints & Business Rules:**
* `NOT NULL`: `COUNTRY_NAME`.
* `COUNTRY_NAME` must be unique.

---

#### 1.2 STADIUMS

* **Attributes & Data Types:** `STADIUM_ID` (VARCHAR(5)), `STADIUM_NAME` (NVARCHAR(100)), `ADDRESS` (NVARCHAR(200))
* **Primary Key:** `STADIUM_ID`
* **Foreign Keys:** None
* **Constraints & Business Rules:**
* `NOT NULL`: `STADIUM_NAME`.
* `STADIUM_NAME` must be unique.

---

#### 1.3 PROVINCES

* **Attributes & Data Types:** `PROVINCE_ID` (VARCHAR(5)), `PROVINCE_NAME` (NVARCHAR(100))
* **Primary Key:** `PROVINCE_ID`
* **Foreign Keys:** None
* **Constraints & Business Rules:**
* `NOT NULL`: `PROVINCE_NAME`.
* `PROVINCE_NAME` must be unique.

---

#### 1.4 CLUBS

* **Attributes & Data Types:** `CLUB_ID` (VARCHAR(5)), `CLUB_NAME` (NVARCHAR(100)), `STADIUM_ID` (VARCHAR(5)), `PROVINCE_ID` (VARCHAR(5))
* **Primary Key:** `CLUB_ID`
* **Foreign Keys:** `STADIUM_ID` (references `STADIUMS`), `PROVINCE_ID` (references `PROVINCES`)
* **Constraints & Business Rules:**
* `NOT NULL`: `CLUB_NAME`, `STADIUM_ID`, `PROVINCE_ID`.
* Each club can register a maximum of 8 foreign players.

---

#### 1.5 PLAYERS

* **Attributes & Data Types:** `PLAYER_ID` (NUMERIC, Identity), `PLAYER_NAME` (NVARCHAR(100)), `POSITION` (NVARCHAR(20)), `DATE_OF_BIRTH` (DATETIME), `ADDRESS` (NVARCHAR(200)), `CLUB_ID` (VARCHAR(5)), `COUNTRY_ID` (VARCHAR(5)), `JERSEY_NUMBER` (INT)
* **Primary Key:** `PLAYER_ID`
* **Foreign Keys:** `CLUB_ID` (references `CLUBS`), `COUNTRY_ID` (references `COUNTRIES`)
* **Constraints & Business Rules:**
* `NOT NULL`: `PLAYER_NAME`, `POSITION`, `CLUB_ID`, `COUNTRY_ID`, `JERSEY_NUMBER`.
* `POSITION` restricted to: `'Goalkeeper'`, `'Forward'`, `'Midfielder'`, `'Center-back'`, `'Defender'`.
* Players in the same club must have unique shirt numbers (`JERSEY_NUMBER`).

---

#### 1.6 COACHES

* **Attributes & Data Types:** `COACH_ID` (VARCHAR(5)), `COACH_NAME` (NVARCHAR(100)), `DATE_OF_BIRTH` (DATETIME), `ADDRESS` (NVARCHAR(200)), `PHONE` (NVARCHAR(20)), `COUNTRY_ID` (VARCHAR(5))
* **Primary Key:** `COACH_ID`
* **Foreign Keys:** `COUNTRY_ID` (references `COUNTRIES`)
* **Constraints & Business Rules:**
* `NOT NULL`: `COACH_NAME`, `COUNTRY_ID`.

---

#### 1.7 CLUB_COACHES

* **Attributes & Data Types:** `COACH_ID` (VARCHAR(5)), `CLUB_ID` (VARCHAR(5)), `ROLE` (NVARCHAR(100))
* **Primary Key:** Composite key (`COACH_ID`, `CLUB_ID`)
* **Foreign Keys:** `COACH_ID` (references `COACHES`), `CLUB_ID` (references `CLUBS`)
* **Constraints & Business Rules:**
* `NOT NULL`: `ROLE`.
* `ROLE` restricted to: `'Head Coach'`, `'Assistant Coach'`, `'Fitness Coach'`, `'Goalkeeper Coach'`.
* Each club can have a maximum of 2 head coaches (`'Head Coach'`).

---

#### 1.8 MATCHES

* **Attributes & Data Types:** `MATCH_ID` (NUMERIC, Identity), `SEASON` (INT), `ROUND` (INT), `MATCH_DATE` (DATETIME), `HOME_CLUB_ID` (VARCHAR(5)), `AWAY_CLUB_ID` (VARCHAR(5)), `STADIUM_ID` (VARCHAR(5)), `RESULT` (VARCHAR(5))
* **Primary Key:** `MATCH_ID`
* **Foreign Keys:** `HOME_CLUB_ID`, `AWAY_CLUB_ID` (reference `CLUBS`), `STADIUM_ID` (references `STADIUMS`)
* **Constraints & Business Rules:**
* `NOT NULL`: `SEASON`, `ROUND`, `MATCH_DATE`, `HOME_CLUB_ID`, `AWAY_CLUB_ID`, `STADIUM_ID`, `RESULT`.

---

#### 1.9 STANDINGS

* **Attributes & Data Types:** `CLUB_ID` (VARCHAR(5)), `SEASON` (INT), `ROUND` (INT), `MATCHES_PLAYED` (INT), `WINS` (INT), `DRAWS` (INT), `LOSSES` (INT), `GOAL_DIFFERENCE` (VARCHAR(5)), `POINTS` (INT), `RANK` (INT)
* **Primary Key:** Composite key (`CLUB_ID`, `SEASON`, `ROUND`)
* **Foreign Keys:** `CLUB_ID` (references `CLUBS`)
* **Constraints & Business Rules:**
* `NOT NULL`: All performance metrics (`MATCHES_PLAYED`, `WINS`, `DRAWS`, `LOSSES`, `GOAL_DIFFERENCE`, `POINTS`, `RANK`).

---

## 2. Textbook Exercises & Requirements

### PART I: DATA DEFINITION LANGUAGE (DDL)

*(Pages 96–99)*

* **Project Name:** Football League Management Database (`FOOTBALL_LEAGUE_DB`)
* **Requirements:**
1. Create the database named `FOOTBALL_LEAGUE_DB`.
2. Create all 9 tables: `COUNTRIES`, `STADIUMS`, `PROVINCES`, `CLUBS`, `PLAYERS`, `COACHES`, `CLUB_COACHES`, `MATCHES`, `STANDINGS`.
3. Establish relational links (Foreign Keys) among the tables.

---

### PART II: DATA MANIPULATION LANGUAGE (DML)

*(Pages 105–108)*

* **Requirements:**
1. Insert sample data into all tables.
2. Delete the player named 'Nguyen Vu Phong'.
3. Delete all players older than 40 years.
4. Delete players older than 35 in the club 'BBD'.
5. Delete players older than 35 in the club 'BECAMEX BÌNH DƯƠNG'.
6. Update the playing position of player 'Nguyen Truong Son' to 'Forward'.
7. Update the address of coach 'Le Huynh Duc' to 'TP.HCM'.
8. Swap the playing positions between player 'Nguyen Cong Vinh' and player 'Tran Tan Tai'.
9. Assign a new coach 'Nguyen Duc Thang' to the club 'GACH DONG TAM LONG AN'.
10. Rename the club 'BECAMEX BÌNH DƯƠNG' to 'BINH DUONG'.

---

## 3. Project Structure & Workflow

```text
01_Football League Management System/
├── Images/
├── SQL/
├── QLBongDa.sql
└── README.md
```

* **Workflow:**
1. Analyze database requirements from the textbook.
2. Create the database and tables with appropriate constraints in English.
3. Insert and verify sample data.
4. Execute and document DML exercises.
5. Organize SQL scripts and finalize documentation.

---

## 4. Current Progress

* [x] Database creation
* [x] Table creation (English schema)
* [x] Primary keys, foreign keys, and constraints
* [x] Sample data setup
* [x] DML exercises execution
* [x] SQL script organization
* [x] Project documentation (`README.md`)