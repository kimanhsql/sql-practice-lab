-- ============================================================
-- FLIGHT MANAGEMENT SYSTEM
-- DATA MANIPULATION LANGUAGE (DML)
-- ============================================================

USE FLIGHT_DB;
GO


INSERT INTO CUSTOMERS (CustomerID, Name, Address, Phone)
VALUES
    ('KH01', N'Nguyen Van A', N'123 Le Loi, TP.HCM', '0901112233'),
    ('KH02', N'Tran Thi B', N'456 Nguyen Hue, Da Nang', '0912223344'),
    ('KH03', N'Le Van C', N'789 Tran Hung Dao, Hanoi', '0983334455'),
    ('KH04', N'Pham Thi D', N'321 Pasteur, TP.HCM', '0904445566'),
    ('KH05', N'Hoang Van E', N'654 Hung Vuong, Can Tho', '0975556677'),
    ('KH06', N'Vu Thi F', N'111 Phan Xich Long, TP.HCM', '0966667788'),
    ('KH07', N'Bui Van G', N'222 Tran Phu, Nha Trang', '0957778899'),
    ('KH08', N'Dang Thi H', N'333 Le Duan, Da Nang', '0948889900'),
    ('KH09', N'Ngo Van I', N'444 Bach Dang, Hai Phong', '0939990011'),
    ('KH10', N'Bui Thi K', N'555 Hung Vuong, Hue', '0920001122'),
    ('KH11', N'Duong Van L', N'666 Nguyen Trai, Hanoi', '0911112233'),
    ('KH12', N'Ly Thi M', N'777 Vo Van Tan, TP.HCM', '0902223344'),
    ('KH13', N'Mai Van N', N'888 Dien Bien Phu, Da Nang', '0983334455'),
    ('KH14', N'Truong Thi O', N'999 Hoang Hoa Tham, TP.HCM', '0974445566'),
    ('KH15', N'Phan Van P', N'123 Tran Nhan Tong, Hanoi', '0965556677');
GO


INSERT INTO EMPLOYEES (EmployeeID, Name, Address, Phone, Salary, EmployeeType)
VALUES
    ('NV01', N'Nguyen Van Quang', N'11 Pham Ngoc Thach, TP.HCM', '0918889900', 35000000.00, '1'),
    ('NV02', N'Tran Minh', N'22 Cach Mang Thang 8, Hanoi', '0917778899', 28000000.00, '1'),
    ('NV03', N'Le Hoang', N'33 Nguyen Van Cu, Da Nang', '0916667788', 25000000.00, '1'),
    ('NV04', N'Pham Thanh', N'44 Le Duan, TP.HCM', '0905556677', 14000000.00, '0'),
    ('NV05', N'Hoang Hoa', N'55 Tran Phu, Nha Trang', '0904445566', 13500000.00, '0'),
    ('NV06', N'Vu Linh', N'66 Hai Ba Trung, Hanoi', '0963332211', 12500000.00, '0'),
    ('NV07', N'Bui Tuan', N'77 Nguyen Hue, TP.HCM', '0954443322', 30000000.00, '1'),
    ('NV08', N'Dang Mai', N'88 Hung Vuong, Da Nang', '0945554433', 15000000.00, '0'),
    ('NV09', N'Ngo Long', N'99 Tran Hung Dao, Can Tho', '0936665544', 27000000.00, '1'),
    ('NV10', N'Duong Ha', N'12 Le Loi, Hai Phong', '0927776655', 11000000.00, '0'),
    ('NV11', N'Truong Son', N'34 Pasteur, TP.HCM', '0918887766', 26000000.00, '1'),
    ('NV12', N'Phan Ngoc', N'56 Dien Bien Phu, Hanoi', '0909998877', 12000000.00, '0'),
    ('NV13', N'Ly Hai', N'78 Le Duan, Da Nang', '0980009988', 29000000.00, '1'),
    ('NV14', N'Mai Lan', N'90 Vo Van Tan, TP.HCM', '0971110099', 14500000.00, '0'),
    ('NV15', N'Do Hung', N'123 Bach Dang, Da Nang', '0962221100', 31000000.00, '1');
GO


INSERT INTO AIRCRAFT_TYPES (AircraftTypeID, Manufacturer)
VALUES
    ('B747', 'Boeing'),
    ('B777', 'Boeing'),
    ('B737', 'Boeing'),
    ('B767', 'Boeing'),
    ('B757', 'Boeing'),
    ('A320', 'Airbus'),
    ('A350', 'Airbus'),
    ('A380', 'Airbus'),
    ('A321', 'Airbus'),
    ('A330', 'Airbus'),
    ('MD11', 'McDonnell Douglas'),
    ('DC10', 'McDonnell Douglas'),
    ('E190', 'Embraer'),
    ('CRJ9', 'Bombardier'),
    ('ATR72', 'ATR');
GO


INSERT INTO AIRCRAFT (SerialNumber, AircraftTypeID)
VALUES
    (10, 'B747'),
    (11, 'B747'),
    (12, 'B747'),
    (20, 'B777'),
    (21, 'B777'),
    (30, 'A320'),
    (31, 'A320'),
    (40, 'A350'),
    (50, 'A380'),
    (60, 'B737'),
    (70, 'A321'),
    (80, 'B767'),
    (90, 'A330'),
    (100, 'MD11'),
    (110, 'E190');
GO


INSERT INTO FLIGHTS (FlightID, DepartureAirport, ArrivalAirport, DepartureTime, ArrivalTime)
VALUES
    ('100', 'SLC', 'MIA', '08:30:00', '11:45:00'),
    ('101', 'DCA', 'ORD', '15:00:00', '17:30:00'),
    ('102', 'MIA', 'DEN', '20:30:00', '23:15:00'),
    ('103', 'SGN', 'HAN', '06:00:00', '08:10:00'),
    ('104', 'DCA', 'MIA', '11:30:00', '14:00:00'),
    ('105', 'MIA', 'SLC', '09:00:00', '12:00:00'),
    ('106', 'ORD', 'DEN', '13:00:00', '15:30:00'),
    ('107', 'HAN', 'SGN', '14:00:00', '16:10:00'),
    ('108', 'DCA', 'DEN', '16:00:00', '19:30:00'),
    ('109', 'SLC', 'ORD', '10:00:00', '13:00:00'),
    ('110', 'MIA', 'ORD', '22:00:00', '01:00:00'),
    ('111', 'DEN', 'MIA', '07:00:00', '10:30:00'),
    ('112', 'SGN', 'DAD', '08:00:00', '09:20:00'),
    ('113', 'HAN', 'DAD', '12:00:00', '13:20:00'),
    ('114', 'DCA', 'SLC', '17:00:00', '20:00:00');
GO


INSERT INTO FLIGHT_SCHEDULES (FlightDate, FlightID, SerialNumber, AircraftTypeID)
VALUES
    ('2000-01-11', '100', 10, 'B747'),
    ('2000-10-31', '102', 30, 'A320'),
    ('2000-11-01', '101', 20, 'B777'),
    ('2000-11-02', '103', 40, 'A350'),
    ('2000-11-03', '104', 11, 'B747'),
    ('2000-11-04', '105', 31, 'A320'),
    ('2000-11-05', '106', 50, 'A380'),
    ('2000-11-06', '107', 60, 'B737'),
    ('2000-11-07', '108', 70, 'A321'),
    ('2000-11-08', '109', 80, 'B767'),
    ('2000-11-09', '110', 90, 'A330'),
    ('2000-11-10', '111', 100, 'MD11'),
    ('2000-11-11', '112', 110, 'E190'),
    ('2000-11-12', '113', 10, 'B747'),
    ('2000-11-13', '114', 20, 'B777');
GO


INSERT INTO BOOKINGS (CustomerID, FlightDate, FlightID)
VALUES
    ('KH01', '2000-01-11', '100'),
    ('KH02', '2000-01-11', '100'),
    ('KH03', '2000-10-31', '102'),
    ('KH04', '2000-11-01', '101'),
    ('KH05', '2000-11-02', '103'),
    ('KH06', '2000-11-03', '104'),
    ('KH07', '2000-11-04', '105'),
    ('KH08', '2000-11-05', '106'),
    ('KH09', '2000-11-06', '107'),
    ('KH10', '2000-11-07', '108'),
    ('KH11', '2000-11-08', '109'),
    ('KH12', '2000-11-09', '110'),
    ('KH13', '2000-11-10', '111'),
    ('KH14', '2000-11-11', '112'),
    ('KH15', '2000-11-12', '113');
GO


INSERT INTO QUALIFICATIONS (EmployeeID, AircraftTypeID)
VALUES
    ('1001', 'B747'),
    ('1001', 'B777'),
    ('NV02', 'A320'),
    ('NV02', 'A350'),
    ('NV03', 'A380'),
    ('NV03', 'B747'),
    ('NV07', 'B737'),
    ('NV07', 'A321'),
    ('NV09', 'B767'),
    ('NV09', 'A330'),
    ('NV11', 'MD11'),
    ('NV11', 'E190'),
    ('NV13', 'B747'),
    ('NV13', 'A350'),
    ('NV15', 'A380');
GO


INSERT INTO ASSIGNMENTS (EmployeeID, FlightDate, FlightID)
VALUES
    ('1001', '2000-01-11', '100'),
    ('NV04', '2000-01-11', '100'),
    ('NV02', '2000-10-31', '102'),
    ('NV05', '2000-10-31', '102'),
    ('NV03', '2000-11-01', '101'),
    ('NV06', '2000-11-01', '101'),
    ('NV07', '2000-11-02', '103'),
    ('NV08', '2000-11-02', '103'),
    ('NV09', '2000-11-03', '104'),
    ('NV10', '2000-11-03', '104'),
    ('NV11', '2000-11-04', '105'),
    ('NV12', '2000-11-04', '105'),
    ('NV13', '2000-11-05', '106'),
    ('NV14', '2000-11-05', '106'),
    ('NV15', '2000-11-06', '107');
GO