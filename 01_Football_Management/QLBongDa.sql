CREATE DATABASE QLBongDa
GO

USE QLBongDa
GO

-- ============================================================
-- PHẦN I - TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG
-- ============================================================

CREATE TABLE QUOCGIA
(
    MAQG VARCHAR(5),
    TENQG NVARCHAR(60) NOT NULL,
    CONSTRAINT PK_QG PRIMARY KEY(MAQG)
)
GO

CREATE TABLE SANVD
(
    MASAN VARCHAR(5),
    TENSAN NVARCHAR(100) NOT NULL,
    DIACHI NVARCHAR(200),
    CONSTRAINT PK_SANVD PRIMARY KEY(MASAN)
)
GO

CREATE TABLE TINH
(
    MATINH VARCHAR(5),
    TENTINH NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_TINH PRIMARY KEY(MATINH)
)
GO

CREATE TABLE CAULACBO
(
    MACLB VARCHAR(5),
    TENCLB NVARCHAR(100) NOT NULL,
    MASAN VARCHAR(5) NOT NULL,
    MATINH VARCHAR(5) NOT NULL,
    CONSTRAINT PK_CLB PRIMARY KEY(MACLB),
    CONSTRAINT FK_SANVD_CLB FOREIGN KEY(MASAN)
                            REFERENCES SANVD(MASAN),
    CONSTRAINT FK_TINH_CLB FOREIGN KEY(MATINH)
                            REFERENCES TINH(MATINH)
)
GO

CREATE TABLE CAUTHU
(
    MACT NUMERIC IDENTITY(1,1),
    HOTEN NVARCHAR(100) NOT NULL,
    VITRI NVARCHAR(20) NOT NULL,
    NGAYSINH DATETIME,
    DIACHI NVARCHAR(200),
    MACLB VARCHAR(5) NOT NULL,
    MAQG VARCHAR(5) NOT NULL,
    SO INT NOT NULL,
    CONSTRAINT PK_CAUTHU PRIMARY KEY(MACT),
    CONSTRAINT FK_CLB_CAUTHU FOREIGN KEY(MACLB)
                            REFERENCES CAULACBO(MACLB),
    CONSTRAINT FK_QG_CAUTHU FOREIGN KEY(MAQG)
                            REFERENCES QUOCGIA(MAQG)
)
GO

CREATE TABLE HUANLV
(
    MAHLV VARCHAR(5),
    TENHLV NVARCHAR(100) NOT NULL,
    NGAYSINH DATETIME,
    DIACHI NVARCHAR(200),
    DIENTHOAI NVARCHAR(20),
    MAQG VARCHAR(5) NOT NULL,
    CONSTRAINT PK_HUANLV PRIMARY KEY(MAHLV),
    CONSTRAINT FK_QG_HLV FOREIGN KEY(MAQG)
                            REFERENCES QUOCGIA(MAQG)
)
GO

CREATE TABLE HLV_CLB
(
    MAHLV VARCHAR(5),
    MACLB VARCHAR(5),
    VAITRO NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_HLV_CLB PRIMARY KEY(MAHLV,MACLB),
    CONSTRAINT FK_HUANLV_HB FOREIGN KEY(MAHLV)
                                REFERENCES HUANLV(MAHLV),
    CONSTRAINT FK_CAULACBO_HB FOREIGN KEY(MACLB)
                                REFERENCES CAULACBO(MACLB)
)
GO

CREATE TABLE TRANDAU
(
    MATRAN NUMERIC IDENTITY(1,1),
    NAM INT NOT NULL,
    VONG INT NOT NULL,
    NGAYTD DATETIME NOT NULL,
    MACLB1 VARCHAR(5) NOT NULL,
    MACLB2 VARCHAR(5) NOT NULL,
    MASAN VARCHAR(5) NOT NULL,
    KETQUA VARCHAR(5) NOT NULL,
    CONSTRAINT PK_TRANDAU PRIMARY KEY(MATRAN),
    CONSTRAINT FK_CLB1_TD FOREIGN KEY(MACLB1)
                            REFERENCES CAULACBO(MACLB),
    CONSTRAINT FK_CLB2_TD FOREIGN KEY(MACLB2)
                            REFERENCES CAULACBO(MACLB),
    CONSTRAINT FK_SANVD_TD FOREIGN KEY(MASAN)
                            REFERENCES SANVD(MASAN)
)
GO

CREATE TABLE BANGXH
(
    MACLB VARCHAR(5),
    NAM INT,
    VONG INT,
    SOTRAN INT NOT NULL,
    THANG INT NOT NULL,
    HOA INT NOT NULL,
    THUA INT NOT NULL,
    HIEUSO VARCHAR(5) NOT NULL,
    DIEM INT NOT NULL,
    HANG INT NOT NULL,
    CONSTRAINT PK_BANGXH PRIMARY KEY(MACLB,NAM,VONG),
    CONSTRAINT FK_BANGXH_CLB FOREIGN KEY(MACLB)
                                REFERENCES CAULACBO(MACLB)
)
GO

-- ============================================================
-- PHẦN II - NHẬP DỮ LIỆU
-- CÂU 1
-- Nhập dữ liệu vào các bảng của CSDL QLBongDa.
-- ============================================================

INSERT INTO QUOCGIA(MAQG,TENQG)
    VALUES
        ('VN',N'Việt Nam'),
        ('ANH','Anh Quốc'),
        ('TBN','Tây Ban Nha'),
        ('BDN','Bồ Đào Nha'),
        ('BRA','Bra-xin'),
        ('ITA','Ý'),
        ('THA','Thái Lan')
GO

UPDATE QUOCGIA
    SET TENQG=N'Anh Quốc'
    WHERE TENQG='Anh Quốc'
GO

UPDATE QUOCGIA
    SET TENQG=N'Tây Ban Nha'
    WHERE TENQG='Tây Ban Nha'
GO

UPDATE QUOCGIA
    SET TENQG=N'Bồ Đào Nha'
    WHERE TENQG='Bồ Đào Nha'
GO

UPDATE QUOCGIA
    SET TENQG=N'Ý'
    WHERE TENQG='Ý'
GO

UPDATE QUOCGIA
    SET TENQG=N'Thái Lan'
    WHERE TENQG='Thái Lan'
GO

INSERT INTO SANVD(MASAN,TENSAN,DIACHI)
    VALUES
        ('GD',N'Gò Đậu',N'123 QL1, TX Thủ Dầu Một, Bình Dương'),
        ('PL','Pleiku',N'22 Hồ Tùng Mậu, Thống Nhất, Thị xã Pleiku, Gia Lai'),
        ('CL',N'Chi Lăng',N'127 Võ Văn Tần, Đà Nẵng'),
        ('NT',N'Nha Trang',N'128 Phan Chu Trinh, Nha Trang, Khánh Hòa'),
        ('TH',N'Tuy Hòa',N'57 Trường Chinh, Tuy Hòa, Phú Yên'),
        ('LA','Long An',N'102 Hùng Vương, Tp Tân An, Long An')
GO

INSERT INTO TINH(MATINH,TENTINH)
    VALUES
        ('BD',N'Bình Dương'),
        ('GL',N'Gia Lai'),
        ('DN',N'Đà Nẵng'),
        ('KH',N'Khánh Hòa'),
        ('PY',N'Phú Yên'),
        ('LA',N'Long An')
GO

INSERT INTO CAULACBO(MACLB,TENCLB,MASAN,MATINH)
    VALUES
        ('BGD',N'BECAMEX BÌNH DƯƠNG','GD','BD'),
        ('HAGL',N'HOÀNG ANH GIA LAI','PL','GL'),
        ('SDN',N'SHB ĐÀ NẴNG','CL','DN'),
        ('KKH',N'KHATOCO KHÁNH HÒA','NT','KH'),
        ('TPY',N'THÉP HƯNG YÊN','TH','PY'),
        ('GDT',N'GẠCH ĐỒNG TÂM LONG AN','LA','LA')
GO

UPDATE CAULACBO
    SET MACLB='BBD'
    WHERE MACLB='BGD'
GO

SET IDENTITY_INSERT CAUTHU ON
GO

INSERT INTO CAUTHU(MACT,HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO)
    VALUES
        (1,N'Nguyễn Vũ Phong',N'Tiền vệ','1990-02-20',NULL,'BBD','VN',17),
        (2,N'Nguyễn Công Vinh',N'Tiền đạo','1992-3-10',NULL,'HAGL','VN',9),
        (4,N'Trần Tấn Tài',N'Tiền vệ','1989-11-12',NULL,'BBD','VN',8)
GO

SET IDENTITY_INSERT CAUTHU OFF
GO

INSERT INTO CAUTHU(HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO)
    VALUES
        (N'Phan Hồng Sơn',N'Thủ môn','1991-6-10',NULL,'HAGL','VN',1),
        ('Ronaldo',N'Tiền vệ','1989-12-12',NULL,'SDN','BRA',7),
        ('Robinho',N'Tiền vệ','1989-10-12',NULL,'SDN','BRA',8),
        ('Vidic',N'Hậu vệ','1989-10-15',NULL,'HAGL','ANH',3),
        (N'Trần Văn Satos',N'Thủ môn','1990-10-21',NULL,'BBD','BRA',1),
        (N'Nguyễn Trường Sơn',N'Hậu vệ','1993-8-26',NULL,'BBD','VN',4)
GO

DELETE CAUTHU WHERE MACT=15
GO
DELETE CAUTHU WHERE MACT=16
GO
DELETE CAUTHU WHERE MACT=17
GO
DELETE CAUTHU WHERE MACT=18
GO
DELETE CAUTHU WHERE MACT=19
GO
DELETE CAUTHU WHERE MACT=20
GO

DBCC CHECKIDENT('CAUTHU',RESEED,4)
GO

INSERT INTO HUANLV(MAHLV,TENHLV,NGAYSINH,DIACHI,DIENTHOAI,MAQG)
    VALUES
        ('HLV01','Vital','1955-10-15',NULL,'0918011075','BDN'),
        ('HLV02',N'Lê Huỳnh Đức','1972-5-20',NULL,'01223456789','VN'),
        ('HLV03','Kiatisuk','1970-12-11',NULL,'01990123456','THA'),
        ('HLV04',N'Hoàng Anh Tuấn','1970-6-10',NULL,'0989112233','VN'),
        ('HLV05',N'Trần Công Minh','1973-7-07',NULL,'0909099990','VN'),
        ('HLV06',N'Trần Văn Phúc','1965-3-02',NULL,'01650101234','VN')
GO

INSERT INTO HLV_CLB(MAHLV,MACLB,VAITRO)
    VALUES
        ('HLV01','BBD',N'HLV Chính'),
        ('HLV02','SDN',N'HLV Chính'),
        ('HLV03','HAGL',N'HLV Chính'),
        ('HLV04','KKH',N'HLV Chính'),
        ('HLV05','GDT',N'HLV Chính'),
        ('HLV06','BBD',N'HLV thủ môn')
GO

INSERT INTO TRANDAU(NAM,VONG,NGAYTD,MACLB1,MACLB2,MASAN,KETQUA)
    VALUES
        (2009,1,'2009-02-07','BBD','SDN','GD','3-0'),
        (2009,1,'2009-02-07','KKH','GDT','NT','1-1'),
        (2009,2,'2009-02-16','SDN','KKH','CL','2-2'),
        (2009,2,'2009-02-16','TPY','BBD','TH','5-0'),
        (2009,3,'2009-3-01','TPY','GDT','TH','0-2'),
        (2009,3,'2009-3-01','KKH','BBD','NT','0-1'),
        (2009,4,'2009-3-07','KKH','TPY','NT','1-0'),
        (2009,4,'2009-3-07','BBD','GDT','GD','2-2')
GO

INSERT INTO BANGXH(MACLB,NAM,VONG,SOTRAN,THANG,HOA,THUA,HIEUSO,DIEM,HANG)
    VALUES
        ('BBD',2009,1,1,1,0,0,'3-0',3,1),
        ('KKH',2009,1,1,0,1,0,'1-1',1,2),
        ('GDT',2009,1,1,0,1,0,'1-1',1,3),
        ('TPY',2009,1,0,0,0,0,'0-0',0,4),
        ('SDN',2009,1,1,0,0,1,'0-3',0,5),
        ('TPY',2009,2,1,1,0,0,'5-0',3,1),
        ('BBD',2009,2,2,1,0,1,'3-5',3,2),
        ('KKH',2009,2,2,0,2,0,'3-3',2,3),
        ('GDT',2009,2,1,0,1,0,'1-1',1,4),
        ('SDN',2009,2,2,1,1,0,'2-5',1,5),
        ('BBD',2009,3,3,2,0,1,'4-5',6,1),
        ('GDT',2009,3,2,1,1,0,'3-1',4,2),
        ('TPY',2009,3,2,1,0,1,'5-2',3,3),
        ('KKH',2009,3,3,0,2,1,'3-4',2,4),
        ('SDN',2009,3,2,1,1,0,'2-5',1,5),
        ('BBD',2009,4,4,2,1,1,'6-7',7,1),
        ('GDT',2009,4,3,1,2,0,'5-1',5,2),
        ('KKH',2009,4,4,1,2,1,'4-4',5,3),
        ('TPY',2009,4,3,1,0,2,'5-3',3,4),
        ('SDN',2009,4,2,1,1,0,'2-5',1,5)
GO

-- ============================================================
-- KIỂM TRA DỮ LIỆU
-- ============================================================

SELECT * FROM QUOCGIA
GO
SELECT * FROM SANVD
GO
SELECT * FROM TINH
GO
SELECT * FROM CAULACBO
GO
SELECT * FROM CAUTHU
GO
SELECT * FROM HUANLV
GO
SELECT * FROM HLV_CLB
GO
SELECT * FROM TRANDAU
GO
SELECT * FROM BANGXH
GO

-- ============================================================
-- PHẦN III - BÀI TẬP DML
-- ============================================================

-- ============================================================
-- CÂU 2
-- Xóa cầu thủ 'Nguyễn Vũ Phong'.
-- ============================================================

DELETE
    FROM CAUTHU
    WHERE HOTEN=N'Nguyễn Vũ Phong'
GO

SELECT * FROM CAUTHU
GO

-- ============================================================
-- CÂU 3
-- Xóa các cầu thủ có tuổi trên 40.
-- ============================================================

DELETE
    FROM CAUTHU
    WHERE NGAYSINH < DATEADD(YEAR,-40,GETDATE())
GO

SELECT * FROM CAUTHU
GO

-- ============================================================
-- CÂU 4
-- Xóa các cầu thủ có tuổi trên 35 ở câu lạc bộ 'BBD'.
-- ============================================================

DELETE
    FROM CAUTHU
    WHERE NGAYSINH < DATEADD(YEAR,-35,GETDATE())
      AND MACLB='BBD'
GO

SELECT * FROM CAUTHU
GO

-- ============================================================
-- CÂU 5
-- Xóa các cầu thủ có tuổi trên 35 ở câu lạc bộ
-- 'BECAMEX BÌNH DƯƠNG'.
-- ============================================================

DELETE
    FROM CAUTHU
    WHERE NGAYSINH < DATEADD(YEAR,-35,GETDATE())
      AND MACLB IN
      (
          SELECT MACLB
          FROM CAULACBO
          WHERE TENCLB=N'BECAMEX BÌNH DƯƠNG'
      )
GO

SELECT * FROM CAUTHU
GO

-- ============================================================
-- CÂU 6
-- Đổi vị trí thi đấu của cầu thủ
-- 'Nguyễn Trường Sơn' thành 'Tiền đạo'.
-- ============================================================

UPDATE CAUTHU
    SET VITRI=N'Tiền đạo'
    WHERE HOTEN=N'Nguyễn Trường Sơn'
GO

SELECT * FROM CAUTHU
GO

-- ============================================================
-- CÂU 7
-- Ghi nhận địa chỉ của huấn luyện viên
-- 'Lê Huỳnh Đức' là 'TP.HCM'.
-- ============================================================

UPDATE HUANLV
    SET DIACHI='TP.HCM'
    WHERE TENHLV=N'Lê Huỳnh Đức'
GO

SELECT * FROM HUANLV
GO

-- ============================================================
-- CÂU 8
-- Đổi vị trí của cầu thủ 'Nguyễn Công Vinh'
-- với cầu thủ 'Trần Tấn Tài'.
-- ============================================================

SELECT HOTEN,VITRI
    FROM CAUTHU
    WHERE HOTEN IN(N'Nguyễn Công Vinh',N'Trần Tấn Tài')
GO

INSERT INTO CAUTHU(HOTEN,VITRI,NGAYSINH,DIACHI,MACLB,MAQG,SO)
    VALUES(N'Trần Tấn Tài',N'Tiền vệ','1989-11-12',NULL,'BBD','VN',8)
GO

UPDATE CAUTHU
    SET VITRI=N'Tiền vệ'
    WHERE HOTEN=N'Nguyễn Công Vinh'
GO

UPDATE CAUTHU
    SET VITRI=N'Tiền đạo'
    WHERE HOTEN=N'Trần Tấn Tài'
GO

SELECT * FROM CAUTHU
GO

-- ============================================================
-- CÂU 9
-- Thay huấn luyện viên mới của 'GẠCH ĐỒNG TÂM LONG AN'
-- là 'Nguyễn Đức Thắng'.
-- ============================================================

SELECT MAHLV,TENHLV
    FROM HUANLV
    WHERE TENHLV=N'Nguyễn Đức Thắng'
GO

SELECT MACLB,TENCLB
    FROM CAULACBO
    WHERE TENCLB=N'GẠCH ĐỒNG TÂM LONG AN'
GO

SELECT * FROM HUANLV
GO

INSERT INTO HUANLV(MAHLV,TENHLV,NGAYSINH,DIACHI,DIENTHOAI,MAQG)
    VALUES('HLV07',N'Nguyễn Đức Thắng','1955-11-01',NULL,'0989123456','VN')
GO

UPDATE HLV_CLB
    SET MAHLV='HLV07'
    WHERE MACLB='GDT'
      AND VAITRO=N'HLV Chính'
GO

SELECT * FROM HLV_CLB
GO

-- ============================================================
-- CÂU 10
-- Đổi tên câu lạc bộ 'BECAMEX BÌNH DƯƠNG'
-- thành 'BÌNH DƯƠNG'.
-- ============================================================

UPDATE CAULACBO
    SET TENCLB=N'BÌNH DƯƠNG'
    WHERE TENCLB=N'BECAMEX BÌNH DƯƠNG'
GO