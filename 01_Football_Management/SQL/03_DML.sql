/*
    Football Management System
    DML Practice

    This file contains:
    - Sample data insertion
    - DELETE statements
    - UPDATE statements
    - Verification queries

    Source:
    QLBongDa exercises from the Database Fundamentals textbook.
*/


USE FOOTBALL_MANAGEMENT_SYSTEM;
GO


/* ============================================================
   1. INSERT SAMPLE DATA
   ============================================================ */


/*
    Insert data into COUNTRIES.
*/

INSERT INTO COUNTRIES (COUNTRY_ID, COUNTRY_NAME)
VALUES
    ('VN', N'Vietnam'),
    ('ENG', N'England'),
    ('ESP', N'Spain'),
    ('POR', N'Portugal'),
    ('BRA', N'Brazil'),
    ('ITA', N'Italy'),
    ('THA', N'Thailand');
GO


/*
    Insert data into STADIUMS.
*/

INSERT INTO STADIUMS (STADIUM_ID, STADIUM_NAME, ADDRESS)
VALUES
    ('GD', N'Go Dau', N'123 QL1, Thu Dau Mot, Binh Duong'),
    ('PL', N'Pleiku', N'22 Ho Tung Mau, Pleiku, Gia Lai'),
    ('CL', N'Chi Lang', N'127 Vo Van Tan, Da Nang'),
    ('NT', N'Nha Trang', N'128 Phan Chu Trinh, Nha Trang'),
    ('TH', N'Tuy Hoa', N'57 Truong Chinh, Tuy Hoa, Phu Yen'),
    ('LA', N'Long An', N'102 Hung Vuong, Tan An, Long An');
GO


/*
    Insert data into PROVINCES.
*/

INSERT INTO PROVINCES (PROVINCE_ID, PROVINCE_NAME)
VALUES
    ('BD', N'Binh Duong'),
    ('GL', N'Gia Lai'),
    ('DN', N'Da Nang'),
    ('KH', N'Khanh Hoa'),
    ('PY', N'Phu Yen'),
    ('LA', N'Long An');
GO


/*
    Insert data into CLUBS.
*/

INSERT INTO CLUBS (CLUB_ID, CLUB_NAME, STADIUM_ID, PROVINCE_ID)
VALUES
    ('BBD', N'BECAMEX BINH DUONG', 'GD', 'BD'),
    ('HAGL', N'HOANG ANH GIA LAI', 'PL', 'GL'),
    ('SDN', N'SHB DA NANG', 'CL', 'DN'),
    ('KKH', N'KHATOCO KHANH HOA', 'NT', 'KH'),
    ('TPY', N'THEP HUNG YEN', 'TH', 'PY'),
    ('GDT', N'GACH DONG TAM LONG AN', 'LA', 'LA');
GO


/*
    Insert data into PLAYERS.

    PLAYER_ID is an IDENTITY column.
    Explicit values are inserted temporarily for the
    records whose original IDs are specified by the exercise.
*/

SET IDENTITY_INSERT PLAYERS ON;
GO

INSERT INTO PLAYERS
(
    PLAYER_ID,
    PLAYER_NAME,
    POSITION,
    DATE_OF_BIRTH,
    ADDRESS,
    CLUB_ID,
    COUNTRY_ID,
    JERSEY_NUMBER
)
VALUES
    (1, N'Nguyen Vu Phong', N'Midfielder', '1990-02-20', NULL, 'BBD', 'VN', 17),
    (2, N'Nguyen Cong Vinh', N'Forward', '1992-03-10', NULL, 'HAGL', 'VN', 9),
    (4, N'Tran Tan Tai', N'Midfielder', '1989-11-12', NULL, 'BBD', 'VN', 8);
GO

SET IDENTITY_INSERT PLAYERS OFF;
GO


/*
    Insert additional players.
*/

INSERT INTO PLAYERS
(
    PLAYER_NAME,
    POSITION,
    DATE_OF_BIRTH,
    ADDRESS,
    CLUB_ID,
    COUNTRY_ID,
    JERSEY_NUMBER
)
VALUES
    (N'Phan Hong Son', N'Goalkeeper', '1991-06-10', NULL, 'HAGL', 'VN', 1),
    (N'Ronaldo', N'Midfielder', '1989-12-12', NULL, 'SDN', 'BRA', 7),
    (N'Robinho', N'Midfielder', '1989-10-12', NULL, 'SDN', 'BRA', 8),
    (N'Vidic', N'Defender', '1989-10-15', NULL, 'HAGL', 'ENG', 3),
    (N'Tran Van Satos', N'Goalkeeper', '1990-10-21', NULL, 'BBD', 'BRA', 1),
    (N'Nguyen Truong Son', N'Defender', '1993-08-26', NULL, 'BBD', 'VN', 4);
GO


/*
    Insert data into COACHES.
*/

INSERT INTO COACHES
(
    COACH_ID,
    COACH_NAME,
    DATE_OF_BIRTH,
    ADDRESS,
    PHONE,
    COUNTRY_ID
)
VALUES
    ('COACH01', N'Vital', '1955-10-15', NULL, '0918011075', 'POR'),
    ('COACH02', N'Le Huynh Duc', '1972-05-20', NULL, '01223456789', 'VN'),
    ('COACH03', N'Kiatisuk', '1970-12-11', NULL, '01990123456', 'THA'),
    ('COACH04', N'Hoang Anh Tuan', '1970-06-10', NULL, '0989112233', 'VN'),
    ('COACH05', N'Tran Cong Minh', '1973-07-07', NULL, '0909099990', 'VN'),
    ('COACH06', N'Tran Van Phuc', '1965-03-02', NULL, '01650101234', 'VN');
GO


/*
    Insert coach-club assignments.
*/

INSERT INTO COACH_CLUB
(
    COACH_ID,
    CLUB_ID,
    ROLE
)
VALUES
    ('COACH01', 'BBD', N'Head Coach'),
    ('COACH02', 'SDN', N'Head Coach'),
    ('COACH03', 'HAGL', N'Head Coach'),
    ('COACH04', 'KKH', N'Head Coach'),
    ('COACH05', 'GDT', N'Head Coach'),
    ('COACH06', 'BBD', N'Goalkeeper Coach');
GO


/*
    Insert match data.
*/

INSERT INTO MATCHES
(
    SEASON_YEAR,
    ROUND,
    MATCH_DATE,
    HOME_CLUB_ID,
    AWAY_CLUB_ID,
    STADIUM_ID,
    RESULT
)
VALUES
    (2009, 1, '2009-02-07', 'BBD', 'SDN', 'GD', '3-0'),
    (2009, 1, '2009-02-07', 'KKH', 'GDT', 'NT', '1-1'),
    (2009, 2, '2009-02-16', 'SDN', 'KKH', 'CL', '2-2'),
    (2009, 2, '2009-02-16', 'TPY', 'BBD', 'TH', '5-0'),
    (2009, 3, '2009-03-01', 'TPY', 'GDT', 'TH', '0-2'),
    (2009, 3, '2009-03-01', 'KKH', 'BBD', 'NT', '0-1'),
    (2009, 4, '2009-03-07', 'KKH', 'TPY', 'NT', '1-0'),
    (2009, 4, '2009-03-07', 'BBD', 'GDT', 'GD', '2-2');
GO


/*
    Insert league standings.
*/

INSERT INTO LEAGUE_STANDINGS
(
    CLUB_ID,
    SEASON_YEAR,
    ROUND,
    MATCHES_PLAYED,
    WINS,
    DRAWS,
    LOSSES,
    GOAL_DIFFERENCE,
    POINTS,
    RANKING
)
VALUES
    ('BBD', 2009, 1, 1, 1, 0, 0, '3-0', 3, 1),
    ('KKH', 2009, 1, 1, 0, 1, 0, '1-1', 1, 2),
    ('GDT', 2009, 1, 1, 0, 1, 0, '1-1', 1, 3),
    ('TPY', 2009, 1, 0, 0, 0, 0, '0-0', 0, 4),
    ('SDN', 2009, 1, 1, 0, 0, 1, '0-3', 0, 5),

    ('TPY', 2009, 2, 1, 1, 0, 0, '5-0', 3, 1),
    ('BBD', 2009, 2, 2, 1, 0, 1, '3-5', 3, 2),
    ('KKH', 2009, 2, 2, 0, 2, 0, '3-3', 2, 3),
    ('GDT', 2009, 2, 1, 0, 1, 0, '1-1', 1, 4),
    ('SDN', 2009, 2, 2, 1, 1, 0, '2-5', 1, 5),

    ('BBD', 2009, 3, 3, 2, 0, 1, '4-5', 6, 1),
    ('GDT', 2009, 3, 2, 1, 1, 0, '3-1', 4, 2),
    ('TPY', 2009, 3, 2, 1, 0, 1, '5-2', 3, 3),
    ('KKH', 2009, 3, 3, 0, 2, 1, '3-4', 2, 4),
    ('SDN', 2009, 3, 2, 1, 1, 0, '2-5', 1, 5),

    ('BBD', 2009, 4, 4, 2, 1, 1, '6-7', 7, 1),
    ('GDT', 2009, 4, 3, 1, 2, 0, '5-1', 5, 2),
    ('KKH', 2009, 4, 4, 1, 2, 1, '4-4', 5, 3),
    ('TPY', 2009, 4, 3, 1, 0, 2, '5-3', 3, 4),
    ('SDN', 2009, 4, 2, 1, 1, 0, '2-5', 1, 5);
GO


/* ============================================================
   2. DELETE AND UPDATE EXERCISES
   ============================================================ */


/*
    Exercise 2
    Delete the player named 'Nguyen Vu Phong'.
*/

DELETE FROM PLAYERS
WHERE PLAYER_NAME = N'Nguyen Vu Phong';
GO

SELECT *
FROM PLAYERS;
GO


/*
    Exercise 3
    Delete players who are older than 40 years.
*/

DELETE FROM PLAYERS
WHERE DATE_OF_BIRTH < DATEADD(YEAR, -40, GETDATE());
GO

SELECT *
FROM PLAYERS;
GO


/*
    Exercise 4
    Delete players who are older than 35 years
    and belong to club BBD.
*/

DELETE FROM PLAYERS
WHERE DATE_OF_BIRTH < DATEADD(YEAR, -35, GETDATE())
  AND CLUB_ID = 'BBD';
GO

SELECT *
FROM PLAYERS;
GO


/*
    Exercise 5
    Delete players who are older than 35 years
    and belong to 'BECAMEX BINH DUONG'.
*/

DELETE FROM PLAYERS
WHERE DATE_OF_BIRTH < DATEADD(YEAR, -35, GETDATE())
  AND CLUB_ID IN
  (
      SELECT CLUB_ID
      FROM CLUBS
      WHERE CLUB_NAME = N'BECAMEX BINH DUONG'
  );
GO

SELECT *
FROM PLAYERS;
GO


/*
    Exercise 6
    Change the playing position of
    'Nguyen Truong Son' to 'Forward'.
*/

UPDATE PLAYERS
SET POSITION = N'Forward'
WHERE PLAYER_NAME = N'Nguyen Truong Son';
GO

SELECT *
FROM PLAYERS;
GO


/*
    Exercise 7
    Set the address of coach 'Le Huynh Duc'
    to 'Ho Chi Minh City'.
*/

UPDATE COACHES
SET ADDRESS = N'Ho Chi Minh City'
WHERE COACH_NAME = N'Le Huynh Duc';
GO

SELECT *
FROM COACHES;
GO


/*
    Exercise 8
    Swap the playing positions of
    'Nguyen Cong Vinh' and 'Tran Tan Tai'.
*/

SELECT PLAYER_NAME, POSITION
FROM PLAYERS
WHERE PLAYER_NAME IN
(
    N'Nguyen Cong Vinh',
    N'Tran Tan Tai'
);
GO


/*
    Temporary value is used to safely swap
    the two positions.
*/

DECLARE @TemporaryPosition NVARCHAR(20);

SELECT @TemporaryPosition = POSITION
FROM PLAYERS
WHERE PLAYER_NAME = N'Nguyen Cong Vinh';

UPDATE PLAYERS
SET POSITION =
(
    SELECT POSITION
    FROM PLAYERS
    WHERE PLAYER_NAME = N'Tran Tan Tai'
)
WHERE PLAYER_NAME = N'Nguyen Cong Vinh';

UPDATE PLAYERS
SET POSITION = @TemporaryPosition
WHERE PLAYER_NAME = N'Tran Tan Tai';
GO

SELECT PLAYER_NAME, POSITION
FROM PLAYERS
WHERE PLAYER_NAME IN
(
    N'Nguyen Cong Vinh',
    N'Tran Tan Tai'
);
GO


/*
    Exercise 9
    Replace the current head coach of
    'GACH DONG TAM LONG AN'
    with 'Nguyen Duc Thang'.
*/

INSERT INTO COACHES
(
    COACH_ID,
    COACH_NAME,
    DATE_OF_BIRTH,
    ADDRESS,
    PHONE,
    COUNTRY_ID
)
VALUES
(
    'COACH07',
    N'Nguyen Duc Thang',
    '1955-11-01',
    NULL,
    '0989123456',
    'VN'
);
GO

UPDATE COACH_CLUB
SET COACH_ID = 'COACH07'
WHERE CLUB_ID =
(
    SELECT CLUB_ID
    FROM CLUBS
    WHERE CLUB_NAME = N'GACH DONG TAM LONG AN'
)
AND ROLE = N'Head Coach';
GO

SELECT *
FROM COACH_CLUB;
GO


/*
    Exercise 10
    Rename the club
    'BECAMEX BINH DUONG'
    to 'BINH DUONG'.
*/

UPDATE CLUBS
SET CLUB_NAME = N'BINH DUONG'
WHERE CLUB_NAME = N'BECAMEX BINH DUONG';
GO

SELECT *
FROM CLUBS;
GO