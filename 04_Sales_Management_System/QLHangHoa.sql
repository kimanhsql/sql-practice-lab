USE master;
GO

-- ============================================================
-- PHẦN I: TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG
-- ============================================================

CREATE DATABASE QLHANGHOA;
GO

USE QLHANGHOA;
GO

-- Câu 1
-- Tạo các bảng và thiết lập khóa chính, khóa ngoại.

CREATE TABLE KHACHHANG
(
    MAKH VARCHAR(4),
    HOTEN NVARCHAR(40),
    DCHI NVARCHAR(50),
    SODT VARCHAR(20),
    NGSINH SMALLDATETIME,
    NGDK SMALLDATETIME,
    DOANHSO MONEY,

    CONSTRAINT PK_KHACHHANG PRIMARY KEY (MAKH)
);
GO

CREATE TABLE NHANVIEN
(
    MANV VARCHAR(4),
    HOTEN NVARCHAR(40),
    SODT VARCHAR(20),
    NGVL SMALLDATETIME,

    CONSTRAINT PK_NHANVIEN PRIMARY KEY (MANV)
);
GO

CREATE TABLE SANPHAM
(
    MASP VARCHAR(4),
    TENSP NVARCHAR(40),
    DVT NVARCHAR(20),
    NUOCSX NVARCHAR(40),
    GIA MONEY,

    CONSTRAINT PK_SANPHAM PRIMARY KEY (MASP)
);
GO

CREATE TABLE HOADON
(
    SOHD INT,
    NGHD SMALLDATETIME,
    MAKH VARCHAR(4),
    MANV VARCHAR(4),
    TRIGIA MONEY,

    CONSTRAINT PK_HOADON PRIMARY KEY (SOHD),

    CONSTRAINT FK_KHACHHANG_HD FOREIGN KEY (MAKH)
        REFERENCES KHACHHANG (MAKH),

    CONSTRAINT FK_NHANVIEN_HD FOREIGN KEY (MANV)
        REFERENCES NHANVIEN (MANV)
);
GO

CREATE TABLE CTHD
(
    SOHD INT,
    MASP VARCHAR(4),
    SL INT,

    CONSTRAINT PK_CTHD PRIMARY KEY (SOHD, MASP),

    CONSTRAINT FK_HOADON_CTHD FOREIGN KEY (SOHD)
        REFERENCES HOADON (SOHD),

    CONSTRAINT FK_SANPHAM_CTHD FOREIGN KEY (MASP)
        REFERENCES SANPHAM (MASP)
);
GO

-- Câu 2
-- Thêm thuộc tính GHICHU kiểu VARCHAR(20) vào bảng SANPHAM.

ALTER TABLE SANPHAM
    ADD GHICHU VARCHAR(20);
GO

-- Câu 3
-- Thêm thuộc tính LOAIKH kiểu TINYINT vào bảng KHACHHANG.

ALTER TABLE KHACHHANG
    ADD LOAIKH TINYINT;
GO

-- Câu 4
-- Thay đổi kiểu dữ liệu của GHICHU thành VARCHAR(100).

ALTER TABLE SANPHAM
    ALTER COLUMN GHICHU VARCHAR(100);
GO

-- Câu 5
-- Xóa thuộc tính GHICHU khỏi bảng SANPHAM.

ALTER TABLE SANPHAM
    DROP COLUMN GHICHU;
GO

-- Câu 6
-- Giới hạn loại khách hàng thuộc các giá trị quy định.

ALTER TABLE KHACHHANG
    ADD CONSTRAINT CHK_LOAIKH
        CHECK (LOAIKH IN ('Vang lai', 'Thuong xuyen', 'Vip'));
GO

-- Câu 7
-- Giới hạn đơn vị tính của sản phẩm.

ALTER TABLE SANPHAM
    ADD CONSTRAINT CHK_DVT
        CHECK (DVT IN (N'Cây', 'hop', 'cai', 'quyen', 'chuc'));
GO

-- Câu 8
-- Quy định giá bán sản phẩm phải từ 500 đồng trở lên.

ALTER TABLE SANPHAM
    ADD CONSTRAINT CHK_GIA
        CHECK (GIA >= 500);
GO

-- Câu 9
-- Đảm bảo mỗi hóa đơn có ít nhất một sản phẩm.

CREATE TRIGGER TRG_KHONGXOASPCUOI
ON CTHD
AFTER DELETE
AS
BEGIN
    DECLARE @MASP_VUAXOA VARCHAR(4);
    DECLARE @SLCONLAI INT;

    SELECT @MASP_VUAXOA = MASP
    FROM deleted;

    SELECT @SLCONLAI = COUNT(*)
    FROM CTHD
    WHERE MASP = @MASP_VUAXOA;

    IF (@SLCONLAI = 0)
    BEGIN
        PRINT N'Lỗi: Hóa đơn phải có ít nhất 1 sản phẩm. Không được xóa!';
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Câu 10
-- Ngày đăng ký thành viên phải sau ngày sinh khách hàng.

ALTER TABLE KHACHHANG
    ADD CONSTRAINT CHK_NGDK_NGSINH
        CHECK (NGDK > NGSINH);
GO

-- Câu 11
-- Ngày lập hóa đơn phải lớn hơn hoặc bằng
-- ngày đăng ký thành viên của khách hàng.

CREATE TRIGGER TRG_KTNGAYMUAHANG
ON HOADON
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted AS i
        JOIN KHACHHANG AS kh
            ON i.MAKH = kh.MAKH
        WHERE i.NGHD < kh.NGDK
    )
    BEGIN
        PRINT N'Lỗi: Ngày lập hóa đơn không nhỏ hơn ngày đăng ký thành viên!';
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Câu 12
-- Ngày lập hóa đơn phải lớn hơn hoặc bằng
-- ngày nhân viên bắt đầu làm việc.

CREATE TRIGGER TRG_KTNGAYBANHANG
ON HOADON
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted AS i
        JOIN NHANVIEN AS nv
            ON i.MANV = nv.MANV
        WHERE i.NGHD < nv.NGVL
    )
    BEGIN
        PRINT N'Lỗi: Ngày bán hàng không nhỏ hơn ngày vào làm!';
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Câu 13
-- Đảm bảo mỗi hóa đơn có ít nhất một chi tiết hóa đơn.

CREATE TRIGGER TRG_TOITHIEUMOTCHITIET
ON CTHD
AFTER DELETE, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT d.SOHD
        FROM deleted AS d
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM CTHD AS c
            WHERE c.SOHD = d.SOHD
        )
    )
    BEGIN
        PRINT N'Lỗi: Mỗi hóa đơn phải có ít nhất 1 chi tiết hóa đơn. Không được phép xóa chi tiết cuối cùng!';
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Câu 14
-- Tự động cập nhật trị giá hóa đơn bằng
-- tổng thành tiền của các chi tiết hóa đơn (số lượng * đơn giá).

CREATE TRIGGER TRG_CAPNHATTRIGIA_HOADON
ON CTHD
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE hd
    SET hd.TRIGIA = ISNULL(BangTinhTien.TongTien, 0)
    FROM HOADON AS hd
    LEFT JOIN
    (
        SELECT ct.SOHD, SUM(ct.SL * sp.GIA) AS TongTien
        FROM CTHD AS ct
        JOIN SANPHAM AS sp
            ON ct.MASP = sp.MASP
        GROUP BY ct.SOHD
    ) AS BangTinhTien ON hd.SOHD = BangTinhTien.SOHD
    WHERE hd.SOHD IN
    (
        SELECT SOHD FROM inserted
        UNION
        SELECT SOHD FROM deleted
    );
END;
GO

-- Câu 15
-- Tự động cập nhật doanh số khách hàng bằng
-- tổng trị giá các hóa đơn của khách hàng đó.

CREATE TRIGGER TRG_CAPNHATDOANHSO_KH
ON HOADON
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE kh
    SET kh.DOANHSO = ISNULL(BangTinhDS.TongDoanhSo, 0)
    FROM KHACHHANG AS kh
    LEFT JOIN
    (
        SELECT MAKH, SUM(TRIGIA) AS TongDoanhSo
        FROM HOADON
        GROUP BY MAKH
    ) AS BangTinhDS ON kh.MAKH = BangTinhDS.MAKH
    WHERE kh.MAKH IN
    (
        SELECT MAKH FROM inserted
        UNION
        SELECT MAKH FROM deleted
    );
END;
GO

-- Điều chỉnh kiểu dữ liệu LOAIKH để lưu tên loại khách hàng.

ALTER TABLE KHACHHANG
    DROP CONSTRAINT CHK_LOAIKH;
GO

ALTER TABLE KHACHHANG
    ALTER COLUMN LOAIKH VARCHAR(20);
GO

ALTER TABLE KHACHHANG
    ADD CONSTRAINT CHK_LOAIKH
        CHECK (LOAIKH IN ('Vang lai', 'Thuong xuyen', 'Vip'));
GO

-- Xóa dữ liệu khách hàng hiện có trước khi nhập lại dữ liệu mẫu.

DELETE FROM KHACHHANG;
GO

-- ============================================================
-- PHẦN II: NHẬP DỮ LIỆU
--
-- Câu 1
-- Nhập dữ liệu vào các bảng của cơ sở dữ liệu QLHANGHOA.
-- ============================================================

INSERT INTO KHACHHANG
    (MAKH, HOTEN, DCHI, SODT, NGSINH, NGDK, DOANHSO, LOAIKH)
VALUES
    ('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', '08823451', '1960-01-22', '2006-02-07', 1060000, 'Vang lai'),
    ('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TpHCM', '0908256478', '1974-04-03', '2006-03-07', 280000, 'Vang lai'),
    ('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM', '0938776266', '1980-06-12', '2006-05-08', 3860000, 'Vang lai'),
    ('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TpHCM', '0917325476', '1965-03-09', '2006-02-10', 250000, 'Vang lai'),
    ('KH05', 'Le Nhat Minh', '34 Truong Dinh, Q3, TpHCM', '08246108', '1950-03-10', '2006-08-10', 21000, 'Vang lai'),
    ('KH06', 'Le Hoai Thuong', '227 Nguyen Van Cu, Q5, TpHCM', '08631738', '1981-01-31', '2006-04-11', 915000, 'Vang lai'),
    ('KH07', 'Nguyen Van Tam', '32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', '1971-04-06', '2006-01-12', 12500, 'Vang lai'),
    ('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TpHCM', '0938435756', '1971-01-10', '2006-03-12', 12500, 'Vang lai'),
    ('KH09', 'Le Ha Vinh', '873 Le Hong Phong, Q5, TpHCM', '08654763', '1979-09-03', '2007-04-01', 70000, 'Vang lai'),
    ('KH10', 'Ha Duy Lap', '34/34B Nguyen Trai, Q1, TphHCM', '08768904', '1983-05-02', '2007-06-01', 67500, 'Vang lai');
GO

INSERT INTO NHANVIEN (MANV, HOTEN, SODT, NGVL)
VALUES
    ('NV01', 'Nguyen Nhu Nhut', '0927345678', '2006-04-13'),
    ('NV02', 'Le Thi Phi Yen', '0987567390', '2006-04-21'),
    ('NV03', 'Nguyen Van B', '0997047382', '2006-04-27'),
    ('NV04', 'Ngo Thanh Tuan', '0913758498', '2006-06-24'),
    ('NV05', 'Nguyen Thi Truc Thanh', '0918590387', '2006-07-20');
GO

INSERT INTO SANPHAM (MASP, TENSP, DVT, NUOCSX, GIA)
VALUES
    ('BC01', 'But chi', N'Cây', 'Singapore', 3000),
    ('BC02', 'But chi', N'Cây', 'Singapore', 5000),
    ('BC03', 'But chi', N'Cây', 'Viet Nam', 3500),
    ('BC04', 'But chi', 'hop', 'Viet Nam', 30000),
    ('BB01', 'But bi', N'Cây', 'Viet Nam', 5000),
    ('BB02', 'But bi', N'Cây', N'Trung Quốc', 7000),
    ('BB03', 'But bi', 'hop', 'Thai Lan', 100000),
    ('TV01', 'Tap 100 giay mong', 'quyen', N'Trung Quốc', 2500),
    ('TV02', 'Tap 200 giay mong', 'quyen', N'Trung Quốc', 4500),
    ('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', 3000),
    ('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', 5500),
    ('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', 23000),
    ('TV06', 'Tap 200 trang', 'chuc', 'Viet Nam', 53000),
    ('TV07', 'Tap 100 trang', 'chuc', N'Trung Quốc', 34000),
    ('ST01', 'So tay 500 trang', 'quyen', N'Trung Quốc', 40000),
    ('ST02', 'So tay loai 1', 'quyen', 'Viet Nam', 55000),
    ('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', 51000),
    ('ST04', 'So tay', 'quyen', 'Thai Lan', 55000),
    ('ST05', 'So tay mong', 'quyen', 'Thai Lan', 20000),
    ('ST06', 'Phan viet bang', 'hop', 'Viet Nam', 5000),
    ('ST07', 'Phan khong bui', 'hop', 'Viet Nam', 7000),
    ('ST08', 'Bong bang', 'cai', 'Viet Nam', 1000),
    ('ST09', 'But long', N'Cây', 'Viet Nam', 5000),
    ('ST10', 'But long', N'Cây', N'Trung Quốc', 7000);
GO

-- Cập nhật ngày đăng ký thành viên của hai khách hàng KH09 và KH10.

UPDATE KHACHHANG
SET NGDK = '2007-01-04'
WHERE MAKH IN ('KH09', 'KH10');
GO

INSERT INTO HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA)
VALUES
    (1001, '2006-07-23', 'KH01', 'NV01', 320000),
    (1002, '2006-08-12', 'KH01', 'NV02', 840000),
    (1003, '2006-08-23', 'KH02', 'NV01', 100000),
    (1004, '2006-09-01', 'KH02', 'NV01', 180000),
    (1005, '2006-10-20', 'KH01', 'NV02', 3800000),
    (1006, '2006-10-16', 'KH01', 'NV03', 2430000),
    (1007, '2006-10-28', 'KH03', 'NV03', 510000),
    (1008, '2006-10-28', 'KH01', 'NV03', 440000),
    (1009, '2006-10-28', 'KH03', 'NV04', 200000),
    (1010, '2006-11-01', 'KH01', 'NV01', 5200000),
    (1011, '2006-11-04', 'KH04', 'NV03', 250000),
    (1012, '2006-11-30', 'KH05', 'NV03', 21000),
    (1013, '2006-12-12', 'KH06', 'NV01', 5000),
    (1014, '2006-12-31', 'KH03', 'NV02', 3150000),
    (1015, '2007-01-01', 'KH06', 'NV01', 910000),
    (1016, '2007-01-01', 'KH07', 'NV02', 12500),
    (1017, '2007-01-02', 'KH08', 'NV03', 35000),
    (1018, '2007-01-13', 'KH08', 'NV03', 330000),
    (1019, '2007-01-13', 'KH01', 'NV03', 30000),
    (1020, '2007-01-14', 'KH09', 'NV04', 70000),
    (1021, '2007-01-16', 'KH10', 'NV03', 67500),
    (1022, '2007-01-16', NULL, 'NV03', 7000),
    (1023, '2007-01-17', NULL, 'NV01', 330000);
GO

INSERT INTO CTHD (SOHD, MASP, SL)
VALUES
    (1001, 'TV02', 10),
    (1001, 'ST01', 5),
    (1001, 'BC01', 5),
    (1001, 'BC02', 10),
    (1001, 'ST08', 10),
    (1002, 'BC04', 20),
    (1002, 'BB01', 20),
    (1002, 'BB02', 20),
    (1003, 'BB03', 10),
    (1004, 'TV01', 20),
    (1004, 'TV02', 10),
    (1004, 'TV03', 10),
    (1004, 'TV04', 10),
    (1005, 'TV05', 50),
    (1005, 'TV06', 50),
    (1006, 'TV07', 20),
    (1006, 'ST01', 30),
    (1006, 'ST02', 10),
    (1007, 'ST03', 10),
    (1008, 'ST04', 8),
    (1009, 'ST05', 10),
    (1010, 'TV07', 50),
    (1010, 'ST07', 50),
    (1010, 'ST08', 100),
    (1010, 'ST04', 50),
    (1010, 'TV03', 100),
    (1011, 'ST06', 50),
    (1012, 'ST07', 3),
    (1013, 'ST08', 5),
    (1014, 'BC02', 80),
    (1014, 'BB02', 100),
    (1014, 'BC04', 60),
    (1014, 'BB01', 50),
    (1015, 'BB02', 30),
    (1015, 'BB03', 7),
    (1016, 'TV01', 5),
    (1017, 'TV02', 1),
    (1017, 'TV03', 1),
    (1017, 'TV04', 5),
    (1018, 'ST04', 6),
    (1019, 'ST05', 1),
    (1019, 'ST06', 2),
    (1020, 'ST07', 10),
    (1021, 'ST08', 5),
    (1021, 'TV01', 7),
    (1021, 'TV02', 10),
    (1022, 'ST07', 1),
    (1023, 'ST04', 6);
GO

-- Kiểm tra dữ liệu sau khi nhập.

SELECT * FROM KHACHHANG;
GO

SELECT * FROM NHANVIEN;
GO

SELECT * FROM SANPHAM;
GO

SELECT * FROM HOADON;
GO

SELECT * FROM CTHD;
GO

-- Câu 2
-- Tạo SANPHAM1 và KHACHHANG1, sao chép toàn bộ dữ liệu
-- từ SANPHAM và KHACHHANG tương ứng.

SELECT * INTO SANPHAM1
FROM SANPHAM;
GO

ALTER TABLE SANPHAM1
    ADD CONSTRAINT CHK_DVT1
        CHECK (DVT IN (N'Cây', 'hop', 'cai', 'quyen', 'chuc'));
GO

ALTER TABLE SANPHAM1
    ADD CONSTRAINT CHK_GIA1
        CHECK (GIA >= 500);
GO

SELECT * INTO KHACHHANG1
FROM KHACHHANG;
GO

ALTER TABLE KHACHHANG1
    ADD CONSTRAINT CHK_LOAIKH1
        CHECK (LOAIKH IN ('Vang lai', 'Thuong xuyen', 'Vip'));
GO

ALTER TABLE KHACHHANG1
    ADD CONSTRAINT CHK_NGDK_NGSINH1
        CHECK (NGDK > NGSINH);
GO

-- Kiểm tra dữ liệu của hai bảng mới.

SELECT * FROM SANPHAM1;
GO

SELECT * FROM KHACHHANG1;
GO

-- Câu 3
-- Tăng giá 5% cho sản phẩm do Thái Lan sản xuất trong SANPHAM1.

UPDATE SANPHAM1
SET GIA = GIA + (GIA * 0.05)
WHERE NUOCSX = 'Thai Lan';
GO

SELECT NUOCSX, GIA
FROM SANPHAM
WHERE NUOCSX = 'Thai Lan';
GO

SELECT NUOCSX, GIA
FROM SANPHAM1
WHERE NUOCSX = 'Thai Lan';
GO

-- Câu 4
-- Giảm giá 5% cho sản phẩm do Trung Quốc sản xuất,
-- có giá không quá 10.000 đồng trong SANPHAM1.

UPDATE SANPHAM1
SET GIA = GIA - (GIA * 0.05)
WHERE NUOCSX = N'Trung Quốc'
    AND GIA <= 10000;
GO

SELECT NUOCSX, GIA
FROM SANPHAM
WHERE NUOCSX = N'Trung Quốc';
GO

SELECT NUOCSX, GIA
FROM SANPHAM1
WHERE NUOCSX = N'Trung Quốc';
GO

-- Câu 5
-- Cập nhật LOAIKH thành 'Vip' cho khách hàng thỏa mãn:
-- - Đăng ký trước năm 2007 và có doanh số từ 10.000.000 trở lên;
-- - Hoặc đăng ký từ năm 2007 và có doanh số từ 2.000.000 trở lên.
-- Thực hiện trên bảng KHACHHANG1.

UPDATE KHACHHANG1
SET LOAIKH = 'Vip'
WHERE (NGDK < '2007-01-01' AND DOANHSO >= 10000000)
    OR (NGDK >= '2007-01-01' AND DOANHSO >= 2000000);
GO

SELECT MAKH, DOANHSO, NGDK, LOAIKH
FROM KHACHHANG;
GO

SELECT MAKH, DOANHSO, NGDK, LOAIKH
FROM KHACHHANG1;
GO

-- ============================================================
-- PHẦN III: BÀI TẬP DML
--
-- Câu 1
-- Liệt kê mã và tên sản phẩm do Trung Quốc sản xuất.
-- ============================================================

SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = N'Trung Quốc';
GO

-- Câu 2
-- Liệt kê mã, tên sản phẩm có đơn vị tính là Cây hoặc quyển.

SELECT MASP, TENSP, DVT
FROM SANPHAM
WHERE DVT IN (N'Cây', 'quyen');
GO

-- Câu 3
-- Liệt kê sản phẩm có mã bắt đầu bằng B và kết thúc bằng 01.

SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP LIKE 'B%01';
GO

-- Câu 4
-- Liệt kê sản phẩm do Trung Quốc sản xuất
-- có giá từ 30.000 đến 40.000 đồng.

SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = N'Trung Quốc'
    AND GIA BETWEEN 30000 AND 40000;
GO

-- Câu 5
-- Liệt kê sản phẩm do Trung Quốc hoặc Thái Lan sản xuất,
-- có giá từ 30.000 đến 40.000 đồng.

SELECT MASP, TENSP, NUOCSX, GIA
FROM SANPHAM
WHERE (NUOCSX = N'Trung Quốc' OR NUOCSX = 'Thai Lan')
    AND GIA BETWEEN 30000 AND 40000;
GO

-- Câu 6
-- Liệt kê số hóa đơn và trị giá hóa đơn
-- lập ngày 01/01/2007 hoặc ngày 02/01/2007.

SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD IN ('2007-01-01', '2007-01-02');
GO

-- Câu 7
-- Liệt kê số hóa đơn và trị giá hóa đơn trong tháng 01/2007,
-- sắp xếp ngày tăng dần và trị giá giảm dần.

SELECT SOHD, TRIGIA
FROM HOADON
WHERE MONTH(NGHD) = 1
    AND YEAR(NGHD) = 2007
ORDER BY NGHD ASC, TRIGIA DESC;
GO

-- Câu 8
-- Liệt kê khách hàng đã mua hàng ngày 01/01/2007.

SELECT kh.MAKH, kh.HOTEN
FROM KHACHHANG AS kh
JOIN HOADON AS hd
    ON kh.MAKH = hd.MAKH
WHERE NGHD = '2007-01-01';
GO

-- Câu 9
-- Liệt kê số hóa đơn và trị giá hóa đơn do nhân viên
-- Nguyen Van B lập ngày 28/10/2006.

SELECT SOHD, TRIGIA
FROM HOADON AS hd
JOIN NHANVIEN AS nv
    ON hd.MANV = nv.MANV
WHERE HOTEN = 'Nguyen Van B'
    AND NGHD = '2006-10-28';
GO

-- Câu 10
-- Liệt kê sản phẩm được
-- khách hàng Nguyen Van A mua trong tháng 10/2006.

SELECT sp.MASP, sp.TENSP
FROM KHACHHANG AS kh
JOIN HOADON AS hd
    ON kh.MAKH = hd.MAKH
JOIN CTHD AS ct
    ON hd.SOHD = ct.SOHD
JOIN SANPHAM AS sp
    ON ct.MASP = sp.MASP
WHERE kh.HOTEN = 'Nguyen Van A'
    AND MONTH(hd.NGHD) = 10
    AND YEAR(hd.NGHD) = 2006;
GO

-- Câu 11
-- Tìm số hóa đơn mua sản phẩm BB01 hoặc BB02.

SELECT SOHD, ct.MASP
FROM CTHD AS ct
JOIN SANPHAM AS sp
    ON ct.MASP = sp.MASP
WHERE ct.MASP IN ('BB01', 'BB02');
GO

-- Câu 12
-- Tìm số hóa đơn mua BB01 hoặc BB02,
-- mỗi sản phẩm có số lượng từ 10 đến 20.

SELECT SOHD, ct.MASP
FROM CTHD AS ct
JOIN SANPHAM AS sp
    ON ct.MASP = sp.MASP
WHERE ct.MASP IN ('BB01', 'BB02')
    AND SL BETWEEN 10 AND 20;
GO

-- Câu 13
-- Tìm hóa đơn mua đồng thời BB01 và BB02,
-- mỗi sản phẩm có số lượng từ 10 đến 20.

SELECT SOHD
FROM CTHD
WHERE MASP = 'BB01'
    AND SL BETWEEN 10 AND 20

INTERSECT

SELECT SOHD
FROM CTHD
WHERE MASP = 'BB02'
    AND SL BETWEEN 10 AND 20;
GO

-- Câu 14
-- Liệt kê sản phẩm do Trung Quốc sản xuất hoặc
-- được bán ra ngày 01/01/2007.

SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = N'Trung Quốc'

UNION

SELECT sp.MASP, sp.TENSP
FROM HOADON AS hd
JOIN CTHD AS ct
    ON hd.SOHD = ct.SOHD
JOIN SANPHAM AS sp
    ON ct.MASP = sp.MASP
WHERE NGHD = '2007-01-01';
GO

-- Câu 15
-- Liệt kê sản phẩm chưa từng được bán.

SELECT sp.MASP, sp.TENSP
FROM SANPHAM AS sp
WHERE NOT EXISTS
(
    SELECT 1
    FROM CTHD AS ct
    WHERE sp.MASP = ct.MASP
);
GO

-- Câu 16
-- Liệt kê sản phẩm không bán được trong năm 2006.

SELECT sp.MASP, sp.TENSP
FROM SANPHAM AS sp
WHERE NOT EXISTS
(
    SELECT 1
    FROM CTHD AS ct
    JOIN HOADON AS hd
        ON ct.SOHD = hd.SOHD
    WHERE sp.MASP = ct.MASP
        AND YEAR(hd.NGHD) = 2006
);
GO

-- Câu 17
-- Liệt kê sản phẩm do Trung Quốc sản xuất
-- không bán được trong năm 2006.

SELECT sp.MASP, sp.TENSP
FROM SANPHAM AS sp
WHERE NOT EXISTS
(
    SELECT 1
    FROM CTHD AS ct
    JOIN HOADON AS hd
        ON ct.SOHD = hd.SOHD
    WHERE sp.MASP = ct.MASP
        AND YEAR(hd.NGHD) = 2006
)
AND NUOCSX = N'Trung Quốc';
GO

-- Câu 18
-- Tìm hóa đơn đã mua tất cả sản phẩm do Singapore sản xuất.

SELECT SOHD
FROM CTHD AS ct
JOIN SANPHAM AS sp
    ON ct.MASP = sp.MASP
WHERE NUOCSX = 'Singapore'
GROUP BY SOHD
HAVING COUNT(DISTINCT sp.MASP) =
(
    SELECT COUNT(*)
    FROM SANPHAM
    WHERE NUOCSX = 'Singapore'
);
GO

-- Câu 19
-- Tìm hóa đơn trong năm 2006 đã mua
-- tất cả sản phẩm do Singapore sản xuất.

SELECT ct.SOHD
FROM CTHD AS ct
JOIN HOADON AS hd
    ON ct.SOHD = hd.SOHD
JOIN SANPHAM AS sp
    ON ct.MASP = sp.MASP
WHERE YEAR(hd.NGHD) = 2006
    AND NUOCSX = 'Singapore'
GROUP BY ct.SOHD
HAVING COUNT(DISTINCT sp.MASP) = (
    SELECT COUNT(*)
    FROM SANPHAM
    WHERE NUOCSX = 'Singapore'
);
GO

-- Câu 20
-- Đếm số hóa đơn không thuộc khách hàng đăng ký thành viên.

SELECT COUNT(*) AS HOADON_KP_TV
FROM HOADON
WHERE MAKH IS NULL;
GO

-- Câu 21
-- Đếm số sản phẩm khác nhau được bán trong năm 2006.

SELECT COUNT(DISTINCT MASP) AS SP_DUOCBAN_2006
FROM CTHD AS ct
JOIN HOADON AS hd
    ON ct.SOHD = hd.SOHD
WHERE YEAR(hd.NGHD) = 2006;
GO

-- Câu 22
-- Tìm trị giá hóa đơn cao nhất và thấp nhất.

SELECT
    MAX(TRIGIA) AS GIA_CAO_NHAT,
    MIN(TRIGIA) AS GIA_THAP_NHAT
FROM HOADON;
GO

-- Câu 23
-- Tính trị giá trung bình của các hóa đơn trong năm 2006.

SELECT AVG(TRIGIA) AS GIA_TB
FROM HOADON
WHERE YEAR(NGHD) = 2006;
GO

-- Câu 24
-- Tính doanh thu bán hàng trong năm 2006.

SELECT SUM(TRIGIA) AS DOANHTHU_2006
FROM HOADON
WHERE YEAR(NGHD) = 2006;
GO

-- Câu 25
-- Tìm số hóa đơn có trị giá cao nhất trong năm 2006.

SELECT SOHD
FROM HOADON
WHERE YEAR(NGHD) = 2006
    AND TRIGIA =
    (
        SELECT MAX(TRIGIA)
        FROM HOADON
        WHERE YEAR(NGHD) = 2006
    );
GO

-- Câu 26
-- Tìm khách hàng đã mua hóa đơn có trị giá cao nhất
-- trong năm 2006.

SELECT kh.MAKH, kh.HOTEN
FROM KHACHHANG AS kh
JOIN HOADON AS hd
    ON kh.MAKH = hd.MAKH
WHERE YEAR(hd.NGHD) = 2006
    AND hd.TRIGIA =
    (
        SELECT MAX(TRIGIA)
        FROM HOADON
        WHERE YEAR(NGHD) = 2006
    );
GO

-- Câu 27
-- Liệt kê 3 khách hàng có doanh số cao nhất.

SELECT TOP 3 MAKH, HOTEN, DOANHSO
FROM KHACHHANG
ORDER BY DOANHSO DESC;
GO

-- Câu 28
-- Liệt kê sản phẩm có giá thuộc 3 mức giá cao nhất.

SELECT MASP, TENSP, GIA
FROM SANPHAM
WHERE GIA IN
(
    SELECT DISTINCT TOP 3 GIA
    FROM SANPHAM
    ORDER BY GIA DESC
);
GO

-- Câu 29
-- Liệt kê sản phẩm do Thái Lan sản xuất
-- có giá thuộc 3 mức giá cao nhất trong tất cả sản phẩm.

SELECT MASP, TENSP, GIA
FROM SANPHAM
WHERE NUOCSX = 'Thai Lan'
    AND GIA IN
    (
        SELECT DISTINCT TOP 3 GIA
        FROM SANPHAM
        ORDER BY GIA DESC
    );
GO

-- Câu 30
-- Liệt kê sản phẩm do Trung Quốc sản xuất
-- có giá thuộc 3 mức giá cao nhất của các sản phẩm Trung Quốc.

SELECT MASP, TENSP, GIA
FROM SANPHAM
WHERE NUOCSX = N'Trung Quốc'
    AND GIA IN
    (
        SELECT DISTINCT TOP 3 GIA
        FROM SANPHAM
        WHERE NUOCSX = N'Trung Quốc'
        ORDER BY GIA DESC
    );
GO

-- Câu 31
-- Xếp hạng khách hàng theo doanh số và lấy các hạng 1 đến 3.

WITH XepHang_KH AS
(
    SELECT
        MAKH,
        HOTEN,
        DOANHSO,
        DENSE_RANK() OVER (ORDER BY DOANHSO DESC) AS RankDoanhSo
    FROM KHACHHANG
)
SELECT *
FROM XepHang_KH
WHERE RankDoanhSo <= 3;
GO

-- Câu 32
-- Đếm tổng số sản phẩm do Trung Quốc sản xuất.

SELECT COUNT(*) AS TONGSP_TQ
FROM SANPHAM
WHERE NUOCSX = N'Trung Quốc';
GO

-- Câu 33
-- Đếm số sản phẩm của từng nước sản xuất.

SELECT NUOCSX, COUNT(*) AS TONGSP
FROM SANPHAM
GROUP BY NUOCSX;
GO

-- Câu 34
-- Với từng nước sản xuất, tìm giá cao nhất,
-- thấp nhất và trung bình của các sản phẩm.

SELECT
    NUOCSX,
    MAX(GIA) AS GIA_CAONHAT,
    MIN(GIA) AS GIA_THAPNHAT,
    AVG(GIA) AS GIA_TB
FROM SANPHAM
GROUP BY NUOCSX;
GO

-- Câu 35
-- Tính doanh thu bán hàng theo từng ngày.

SELECT NGHD, SUM(TRIGIA) AS DOANHTHUNGAY
FROM HOADON
GROUP BY NGHD;
GO

-- Câu 36
-- Tính tổng số lượng bán ra
-- của từng sản phẩm trong tháng 10/2006.

SELECT
    ct.MASP,
    sp.TENSP,
    SUM(SL) AS TONG_SL_BAN
FROM CTHD AS ct
JOIN HOADON AS hd
    ON ct.SOHD = hd.SOHD
JOIN SANPHAM AS sp
    ON ct.MASP = sp.MASP
WHERE MONTH(hd.NGHD) = 10
    AND YEAR(hd.NGHD) = 2006
GROUP BY ct.MASP, sp.TENSP;
GO

-- Câu 37
-- Tính doanh thu bán hàng theo từng tháng trong năm 2006.

SELECT
    MONTH(NGHD) AS THANG,
    SUM(TRIGIA) AS DOANHTHU_THANG
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD);
GO

-- Câu 38
-- Tìm hóa đơn mua ít nhất 4 sản phẩm khác nhau.

SELECT SOHD
FROM CTHD
GROUP BY SOHD
HAVING COUNT(DISTINCT MASP) >= 4;
GO

-- Câu 39
-- Tìm hóa đơn mua đúng 3 sản phẩm khác nhau
-- do Việt Nam sản xuất.

SELECT SOHD
FROM CTHD AS ct
JOIN SANPHAM AS sp
    ON ct.MASP = sp.MASP
WHERE NUOCSX = 'Viet Nam'
GROUP BY SOHD
HAVING COUNT(DISTINCT ct.MASP) = 3;
GO

-- Câu 40
-- Tìm khách hàng có số lần mua hàng nhiều nhất.

WITH SoLanMua AS
(
    SELECT MAKH, COUNT(SOHD) AS SoLan
    FROM HOADON
    WHERE MAKH IS NOT NULL
    GROUP BY MAKH
)
SELECT kh.MAKH, kh.HOTEN, sl.SoLan
FROM KHACHHANG AS kh
JOIN SoLanMua AS sl
    ON kh.MAKH = sl.MAKH
WHERE sl.SoLan =
(
    SELECT MAX(SoLan)
    FROM SoLanMua
);
GO

-- Câu 41
-- Tìm tháng có doanh thu bán hàng cao nhất trong năm 2006.

WITH DoanhThuTheoThang AS
(
    SELECT
        MONTH(NGHD) AS Thang,
        SUM(TRIGIA) AS TongDoanhThu
    FROM HOADON
    WHERE YEAR(NGHD) = 2006
    GROUP BY MONTH(NGHD)
)
SELECT Thang, TongDoanhThu
FROM DoanhThuTheoThang
WHERE TongDoanhThu =
(
    SELECT MAX(TongDoanhThu)
    FROM DoanhThuTheoThang
);
GO

-- Câu 42
-- Tìm sản phẩm có tổng số lượng bán ra
-- thấp nhất trong năm 2006.

WITH TongBan26 AS
(
    SELECT ct.MASP, SUM(SL) AS TongSL
    FROM CTHD AS ct
    JOIN HOADON AS hd
        ON ct.SOHD = hd.SOHD
    WHERE YEAR(hd.NGHD) = 2006
    GROUP BY ct.MASP
)
SELECT sp.MASP, sp.TENSP, t.TongSL
FROM SANPHAM AS sp
JOIN TongBan26 AS t
    ON sp.MASP = t.MASP
WHERE t.TongSL =
(
    SELECT MIN(TongSL)
    FROM TongBan26
);
GO

-- Câu 43
-- Tìm sản phẩm có giá cao nhất của từng nước sản xuất.

WITH XepGiaTheoNuoc AS
(
    SELECT
        MASP,
        TENSP,
        NUOCSX,
        GIA,
        ROW_NUMBER() OVER
        (
            PARTITION BY NUOCSX
            ORDER BY GIA DESC
        ) AS rn
    FROM SANPHAM
)
SELECT MASP, TENSP, NUOCSX, GIA
FROM XepGiaTheoNuoc
WHERE rn = 1;
GO

-- Câu 44
-- Tìm nước sản xuất có ít nhất 3 mức giá bán khác nhau.

SELECT NUOCSX
FROM SANPHAM
GROUP BY NUOCSX
HAVING COUNT(DISTINCT GIA) >= 3;
GO

-- Câu 45
-- Trong 10 khách hàng có doanh số cao nhất,
-- tìm khách hàng có số lần mua hàng nhiều nhất.

WITH Top10DS AS
(
    SELECT TOP 10 MAKH, HOTEN
    FROM KHACHHANG
    ORDER BY DOANHSO DESC
),
DemLuotMua AS
(
    SELECT
        t.MAKH,
        t.HOTEN,
        COUNT(hd.SOHD) AS SoLanMua
    FROM Top10DS AS t
    JOIN HOADON AS hd
        ON t.MAKH = hd.MAKH
    GROUP BY t.MAKH, t.HOTEN
)
SELECT TOP 1 MAKH, HOTEN, SoLanMua
FROM DemLuotMua
ORDER BY SoLanMua DESC;
GO