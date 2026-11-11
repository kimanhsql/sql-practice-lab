USE master;
GO

CREATE DATABASE QLCHUYENBAY;
GO

USE QLCHUYENBAY;
GO

-- ============================================================
-- PHẦN I: TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG
-- ============================================================

CREATE TABLE KHACHHANG
(
    MAKH CHAR(15),
    TEN NVARCHAR(15),
    DCHI NVARCHAR(50),
    DTHOAI CHAR(12),

    CONSTRAINT PK_KHACHHANG PRIMARY KEY (MAKH)
);
GO

CREATE TABLE NHANVIEN
(
    MANV CHAR(15),
    TEN NVARCHAR(15),
    DCHI NVARCHAR(50),
    DTHOAI CHAR(12),
    LUONG DECIMAL(10, 2),
    LOAINV CHAR(10),

    CONSTRAINT PK_NHANVIEN PRIMARY KEY (MANV),
    CONSTRAINT CHK_NHANVIEN CHECK (LOAINV IN (0, 1))
);
GO

CREATE TABLE LOAIMB
(
    MALOAI CHAR(15),
    HANGSX NVARCHAR(15),

    CONSTRAINT PK_LOAIMB PRIMARY KEY (MALOAI)
);
GO

CREATE TABLE MAYBAY
(
    SOHIEU INT,
    MALOAI CHAR(15),

    CONSTRAINT PK_MAYBAY PRIMARY KEY (SOHIEU, MALOAI),

    CONSTRAINT FK_MAYBAY_LOAIMB
        FOREIGN KEY (MALOAI)
        REFERENCES LOAIMB (MALOAI)
);
GO

CREATE TABLE CHUYENBAY
(
    MACB CHAR(4),
    SBDI CHAR(3),
    SBDEN CHAR(3),
    GIODI TIME,
    GIODEN TIME,

    CONSTRAINT PK_CHUYENBAY PRIMARY KEY (MACB)
);
GO

CREATE TABLE LICHBAY
(
    NGAYDI DATE,
    MACB CHAR(4),
    SOHIEU INT,
    MALOAI CHAR(15),

    CONSTRAINT PK_LICHBAY PRIMARY KEY (NGAYDI, MACB),

    CONSTRAINT FK_LICHBAY_CHUYENBAY
        FOREIGN KEY (MACB)
        REFERENCES CHUYENBAY (MACB),

    CONSTRAINT FK_LICHBAY_MAYBAY
        FOREIGN KEY (SOHIEU, MALOAI)
        REFERENCES MAYBAY (SOHIEU, MALOAI)
);
GO

CREATE TABLE DATCHO
(
    MAKH CHAR(15),
    NGAYDI DATE,
    MACB CHAR(4),

    CONSTRAINT PK_DATCHO PRIMARY KEY (MAKH, NGAYDI, MACB),

    CONSTRAINT FK_DATCHO_KHACHHANG
        FOREIGN KEY (MAKH)
        REFERENCES KHACHHANG (MAKH),

    CONSTRAINT FK_DATCHO_LICHBAY
        FOREIGN KEY (NGAYDI, MACB)
        REFERENCES LICHBAY (NGAYDI, MACB)
);
GO

CREATE TABLE KHANANG
(
    MANV CHAR(15),
    MALOAI CHAR(15),

    CONSTRAINT PK_KHANANG PRIMARY KEY (MANV, MALOAI),

    CONSTRAINT FK_KHANANG_NHANVIEN
        FOREIGN KEY (MANV)
        REFERENCES NHANVIEN (MANV),

    CONSTRAINT FK_KHANANG_LOAIMB
        FOREIGN KEY (MALOAI)
        REFERENCES LOAIMB (MALOAI)
);
GO

CREATE TABLE PHANCONG
(
    MANV CHAR(15),
    NGAYDI DATE,
    MACB CHAR(4),

    CONSTRAINT PK_PHANCONG PRIMARY KEY (MANV, NGAYDI, MACB),

    CONSTRAINT FK_PHANCONG_NHANVIEN
        FOREIGN KEY (MANV)
        REFERENCES NHANVIEN (MANV),

    CONSTRAINT FK_PHANCONG_LICHBAY
        FOREIGN KEY (NGAYDI, MACB)
        REFERENCES LICHBAY (NGAYDI, MACB)
);
GO


-- ============================================================
-- PHẦN 2: NHẬP DỮ LIỆU
-- ============================================================

INSERT INTO KHACHHANG (MAKH, TEN, DCHI, DTHOAI)
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

INSERT INTO NHANVIEN (MANV, TEN, DCHI, DTHOAI, LUONG, LOAINV)
VALUES
    ('NV01', N'Nguyen Van Quang', N'11 Pham Ngoc Thach, TP.HCM', '0918889900', 35000000.00, 1),
    ('NV02', N'Tran Minh', N'22 Cach Mang Thang 8, Hanoi', '0917778899', 28000000.00, 1),
    ('NV03', N'Le Hoang', N'33 Nguyen Van Cu, Da Nang', '0916667788', 25000000.00, 1),
    ('NV04', N'Pham Thanh', N'44 Le Duan, TP.HCM', '0905556677', 14000000.00, 0),
    ('NV05', N'Hoang Hoa', N'55 Tran Phu, Nha Trang', '0904445566', 13500000.00, 0),
    ('NV06', N'Vu Linh', N'66 Hai Ba Trung, Hanoi', '0963332211', 12500000.00, 0),
    ('NV07', N'Bui Tuan', N'77 Nguyen Hue, TP.HCM', '0954443322', 30000000.00, 1),
    ('NV08', N'Dang Mai', N'88 Hung Vuong, Da Nang', '0945554433', 15000000.00, 0),
    ('NV09', N'Ngo Long', N'99 Tran Hung Dao, Can Tho', '0936665544', 27000000.00, 1),
    ('NV10', N'Duong Ha', N'12 Le Loi, Hai Phong', '0927776655', 11000000.00, 0),
    ('NV11', N'Truong Son', N'34 Pasteur, TP.HCM', '0918887766', 26000000.00, 1),
    ('NV12', 'Phan Ngoc', N'56 Dien Bien Phu, Hanoi', '0909998877', 12000000.00, 0),
    ('NV13', N'Ly Hai', N'78 Le Duan, Da Nang', '0980009988', 29000000.00, 1),
    ('NV14', N'Mai Lan', N'90 Vo Van Tan, TP.HCM', '0971110099', 14500000.00, 0),
    ('NV15', N'Do Hung', N'123 Bach Dang, Da Nang', '0962221100', 31000000.00, 1);
GO

INSERT INTO LOAIMB (MALOAI, HANGSX)
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

INSERT INTO MAYBAY (SOHIEU, MALOAI)
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

INSERT INTO CHUYENBAY (MACB, SBDI, SBDEN, GIODI, GIODEN)
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

INSERT INTO LICHBAY (NGAYDI, MACB, SOHIEU, MALOAI)
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

INSERT INTO DATCHO (MAKH, NGAYDI, MACB)
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

INSERT INTO KHANANG (MANV, MALOAI)
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

INSERT INTO PHANCONG (MANV, NGAYDI, MACB)
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


-- ============================================================
-- PHẦN 3: BÀI TẬP DML

-- Câu 1
-- Cho biết mã số, tên phi công, địa chỉ, điện thoại
-- của các phi công đã từng lái máy bay loại B747.
-- ============================================================

SELECT DISTINCT
    nv.MANV,
    TEN,
    DCHI,
    DTHOAI
FROM NHANVIEN nv
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
INNER JOIN LICHBAY l
    ON l.NGAYDI = pc.NGAYDI
        AND l.MACB = pc.MACB
WHERE LOAINV = 1 AND MALOAI = 'B747';
GO

-- Câu 2
-- Cho biết mã số và ngày đi của các chuyến bay xuất phát
-- từ sân bay DCA trong khoảng thời gian từ 14 giờ đến 18 giờ.

SELECT
    l.MACB,
    l.NGAYDI
FROM LICHBAY l
INNER JOIN CHUYENBAY c
    ON c.MACB = l.MACB
WHERE c.SBDI = 'DCA' AND
    (c.GIODI BETWEEN '14:00:00' AND '18:00:00');
GO

-- Câu 3
-- Cho biết tên những nhân viên được phân công trên chuyến bay
-- có mã số 100 xuất phát tại sân bay SLC.
-- Các dòng dữ liệu xuất ra không được phép trùng lắp.

SELECT DISTINCT
    nv.MANV,
    nv.TEN,
    p.MACB
FROM PHANCONG p
INNER JOIN NHANVIEN nv
    ON nv.MANV = p.MANV
INNER JOIN CHUYENBAY c
    ON c.MACB = p.MACB
WHERE c.MACB = '100'
    AND c.SBDI = 'SLC';
GO

-- Câu 4
-- Cho biết mã loại và số hiệu máy bay đã từng xuất phát tại sân bay MIA.
-- Các dòng dữ liệu xuất ra không được phép trùng lắp.

SELECT DISTINCT
    mb.MALOAI,
    mb.SOHIEU
FROM MAYBAY mb
INNER JOIN LICHBAY l
    ON l.MALOAI = mb.MALOAI
        AND l.SOHIEU = mb.SOHIEU
INNER JOIN CHUYENBAY c
    ON c.MACB = l.MACB
WHERE c.SBDI = 'MIA';
GO

-- Câu 5
-- Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại
-- của tất cả các hành khách đi trên chuyến bay đó.
-- Sắp xếp theo thứ tự tăng dần của mã chuyến bay
-- và theo ngày đi giảm dần.

-- Câu 6
-- Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại
-- của tất cả những nhân viên được phân công trong chuyến bay đó.
-- Sắp xếp theo thứ tự tăng dần của mã chuyến bay
-- và theo ngày đi giảm dần.

-- Câu 7
-- Cho biết mã chuyến bay, ngày đi, mã số và tên của những phi công
-- được phân công vào chuyến bay hạ cánh xuống sân bay ORD.

-- Câu 8
-- Cho biết các chuyến bay (mã số chuyến bay, ngày đi và tên của phi công)
-- trong đó phi công có mã 1001 được phân công lái.

-- Câu 9
-- Cho biết thông tin (mã chuyến bay, sân bay đi, giờ đi, giờ đến, ngày đi)
-- của những chuyến bay hạ cánh xuống DEN. Các chuyến bay được liệt kê theo
-- ngày đi giảm dần và sân bay xuất phát (SBDI) tăng dần.

-- Câu 10
-- Với mỗi phi công, cho biết hãng sản xuất và mã loại máy bay
-- mà phi công này có khả năng bay được. Xuất ra tên phi công,
-- hãng sản xuất và mã loại máy bay.

-- Câu 11
-- Cho biết mã phi công, tên phi công đã lái máy bay trong chuyến bay
-- mã số 100 vào ngày 11/01/2000.

-- Câu 12
-- Cho biết mã chuyến bay, mã nhân viên, tên nhân viên
-- được phân công vào chuyến bay xuất phát ngày 10/31/2000
-- tại sân bay MIA vào lúc 20:30.

-- Câu 13
-- Cho biết thông tin về chuyến bay (mã chuyến bay, số hiệu, mã loại,
-- hãng sản xuất) mà phi công ‘Quang’ đã lái.

-- Câu 14
-- Cho biết tên của những phi công chưa được phân công lái chuyến bay nào.

-- Câu 15
-- Cho biết tên khách hàng đã đi chuyến bay trên máy bay của hãng ‘Boeing’.

-- Câu 16
-- Cho biết mã các chuyến bay chỉ bay với máy bay
-- số hiệu 10 và mã loại B747.

-- Câu 17
-- Với mỗi sân bay (SBDEN), cho biết số lượng chuyến bay hạ cánh
-- xuống sân bay đó. Kết quả được sắp xếp theo thứ tự tăng dần
-- của sân bay đến.

-- Câu 18
-- Với mỗi sân bay (SBDI), cho biết số lượng chuyến bay xuất phát
-- từ sân bay đó, sắp xếp theo thứ tự tăng dần của sân bay xuất phát.

-- Câu 19
-- Với mỗi sân bay (SBDI), cho biết số lượng chuyến bay xuất phát
-- theo từng ngày. Xuất ra mã sân bay đi, ngày và số lượng.

-- Câu 20
-- Với mỗi sân bay (SBDEN), cho biết số lượng chuyến bay hạ cánh
-- theo từng ngày. Xuất ra mã sân bay đến, ngày và số lượng.

-- Câu 21
-- Với mỗi lịch bay, cho biết mã chuyến bay, ngày đi cùng với
-- số lượng nhân viên không phải là phi công của chuyến bay đó.

-- Câu 22
-- Số lượng chuyến bay xuất phát từ sân bay MIA vào ngày 11/01/2000.

-- Câu 23
-- Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, số lượng nhân viên
-- được phân công trên chuyến bay đó, sắp theo thứ tự giảm dần của số lượng.

-- Câu 24
-- Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, cùng với
-- số lượng hành khách đã đặt chỗ của chuyến bay đó, sắp theo
-- thứ tự giảm dần của số lượng.

-- Câu 25
-- Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, tổng lương
-- của phi hành đoàn (các nhân viên được phân công trong chuyến bay),
-- sắp xếp theo thứ tự tăng dần của tổng lương.

-- Câu 26
-- Cho biết lương trung bình của các nhân viên không phải là phi công.

-- Câu 27
-- Cho biết mức lương trung bình của các phi công.

-- Câu 28
-- Với mỗi loại máy bay, cho biết số lượng chuyến bay đã bay
-- trên loại máy bay đó hạ cánh xuống sân bay ORD. Xuất ra mã loại máy bay,
-- số lượng chuyến bay.

-- Câu 29
-- Cho biết sân bay (SBDI) và số lượng chuyến bay có nhiều hơn 2 chuyến bay
-- xuất phát trong khoảng 10 giờ đến 22 giờ.

-- Câu 30
-- Cho biết tên phi công được phân công vào ít nhất 2 chuyến bay
-- trong cùng một ngày.

-- Câu 31
-- Cho biết mã chuyến bay và ngày đi của những chuyến bay
-- có ít hơn 3 hành khách đặt chỗ.

-- Câu 32
-- Cho biết số hiệu máy bay và loại máy bay mà phi công có mã 1001
-- được phân công lái trên 2 lần.

-- Câu 33
-- Với mỗi hãng sản xuất, cho biết số lượng loại máy bay mà hãng đó
-- đã sản xuất. Xuất ra hãng sản xuất và số lượng.

-- Câu 34
-- Cho biết hãng sản xuất, mã loại và số hiệu của máy bay
-- đã được sử dụng nhiều nhất.

-- Câu 35
-- Cho biết tên nhân viên được phân công đi nhiều chuyến bay nhất.

-- Câu 36
-- Cho biết thông tin của phi công (tên, địa chỉ, điện thoại) lái
-- nhiều chuyến bay nhất.

-- Câu 37
-- Cho biết sân bay (SBDEN) và số lượng chuyến bay của sân bay
-- có ít chuyến bay đáp xuống nhất.

-- Câu 38
-- Cho biết sân bay (SBDI) và số lượng chuyến bay của sân bay
-- có nhiều chuyến bay xuất phát nhất.

-- Câu 39
-- Cho biết tên, địa chỉ, và điện thoại
-- của khách hàng đã đi trên nhiều chuyến bay nhất.

-- Câu 40
-- Cho biết mã số, tên và lương của các phi công
-- có khả năng lái nhiều loại máy bay nhất.

-- Câu 41
-- Cho biết thông tin (mã nhân viên, tên, lương)
-- của nhân viên có mức lương cao nhất.

-- Câu 42
-- Cho biết tên, địa chỉ của các nhân viên có lương cao nhất
-- trong phi hành đoàn (các nhân viên được phân công trong một chuyến bay)
-- mà người đó tham gia.

-- Câu 43
-- Cho biết mã chuyến bay, giờ đi và giờ đến
-- của chuyến bay bay sớm nhất trong ngày.

-- Câu 44
-- Cho biết mã chuyến bay có thời gian bay dài nhất. Xuất ra mã chuyến bay
-- và thời gian bay (tính bằng phút).

-- Câu 45
-- Cho biết mã chuyến bay có thời gian bay ít nhất. Xuất ra mã chuyến bay
-- và thời gian bay.

-- Câu 46
-- Cho biết mã chuyến bay và ngày đi của những chuyến bay
-- bay trên loại máy bay B747 nhiều nhất.

-- Câu 47
-- Với mỗi chuyến bay có trên 3 hành khách, cho biết mã chuyến bay
-- và số lượng nhân viên trên chuyến bay đó. Xuất ra mã chuyến bay
-- và số lượng nhân viên.

-- Câu 48
-- Với mỗi loại nhân viên có tổng lương trên 600000,
-- cho biết số lượng nhân viên trong từng loại nhân viên đó.
-- Xuất ra loại nhân viên, và số lượng nhân viên tương ứng.

-- Câu 49
-- Với mỗi chuyến bay có trên 3 nhân viên, cho biết mã chuyến bay
-- và số lượng khách hàng đã đặt chỗ trên chuyến bay đó.

-- Câu 50
-- Với mỗi loại máy bay có nhiều hơn một chiếc, cho biết
-- số lượng chuyến bay đã được bố trí bay bằng loại máy bay đó.
-- Xuất ra mã loại và số lượng.

-- Câu 51
-- Cho biết mã những chuyến bay đã bay tất cả các máy bay của hãng ‘Boeing’.

-- Câu 52
-- Cho biết mã và tên phi công có khả năng lái tất cả các máy bay
-- của hãng ‘Airbus’.

-- Câu 53
-- Cho biết tên nhân viên (không phải là phi công) được phân công bay
-- vào tất cả các chuyến bay có mã 100.

-- Câu 54
-- Cho biết ngày đi nào mà có tất cả các loại máy bay
-- của hãng ‘Boeing’ tham gia.

-- Câu 55
-- Cho biết loại máy bay của hãng ‘Boeing’ nào có tham gia
-- vào tất cả các ngày đi.

-- Câu 56
-- Cho biết mã và tên các khách hàng có đặt chỗ
-- trong tất cả các ngày từ 31/10/2000 đến 1/1/2000.