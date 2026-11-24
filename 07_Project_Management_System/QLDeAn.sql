USE master;
GO

CREATE DATABASE QLDEAN;
GO

USE QLDEAN;
GO

-- ============================================================
-- PHẦN I: TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG
-- ============================================================

CREATE TABLE PHONGBAN
(
    MAPHG VARCHAR(5),
    TENPHG NVARCHAR(100),
    TRGPHG VARCHAR(5),
    NGNC DATE,

    CONSTRAINT PK_PHONGBAN PRIMARY KEY(MAPHG)
);
GO

CREATE TABLE NHANVIEN
(
    MANV VARCHAR(5),
    HONV NVARCHAR(20),
    TENLOT NVARCHAR(20),
    TENNV NVARCHAR(30),
    NGSINH DATE,
    DCHI NVARCHAR(100),
    PHAI NVARCHAR(3),
    MLUONG DECIMAL(10, 2),
    MA_NQL VARCHAR(5),
    PHONG VARCHAR(5),

    CONSTRAINT PK_NHANVIEN PRIMARY KEY(MANV),

    CONSTRAINT FK_NV_PHONG
        FOREIGN KEY(PHONG)
        REFERENCES PHONGBAN(MAPHG),

    CONSTRAINT FK_NV_NQL
        FOREIGN KEY(MA_NQL)
        REFERENCES NHANVIEN(MANV),

    CONSTRAINT CHK_NV_PHAI CHECK(PHAI IN (N'Nam', N'Nữ'))
);
GO

CREATE TABLE DIADIEMPHG
(
    MAPHG VARCHAR(5),
    DIADIEM NVARCHAR(100),

    CONSTRAINT PK_DIADIEM PRIMARY KEY(MAPHG, DIADIEM)
);
GO

ALTER TABLE PHONGBAN
ADD CONSTRAINT FK_PB_TRGPHG
    FOREIGN KEY(TRGPHG)
    REFERENCES NHANVIEN(MANV);
GO

CREATE TABLE DIADIEMPHG
(
    MAPHG VARCHAR(5),
    DIADIEM NVARCHAR(100),

    CONSTRAINT PK_DIADIEM PRIMARY KEY(MAPHG, DIADIEM),

    CONSTRAINT FK_DDP_PB
        FOREIGN KEY(MAPHG)
        REFERENCES PHONGBAN(MAPHG)
);
GO

CREATE TABLE DEAN
(
    MADA VARCHAR(5),
    TENDA NVARCHAR(100),
    DDIEM_DA NVARCHAR(100),
    PHONG VARCHAR(5),
    NGBD_DA DATE,
    NGKT_DA DATE,

    CONSTRAINT PK_DEAN PRIMARY KEY(MADA),

    CONSTRAINT FK_DA_PHONG
        FOREIGN KEY(PHONG)
        REFERENCES PHONGBAN(MAPHG),

    CONSTRAINT CHK_DA_NGAY CHECK(NGKT_DA >= NGBD_DA)
);
GO

CREATE TABLE PHANCONG
(
    MANV VARCHAR(5),
    MADA VARCHAR(5),
    THOIGIAN INT,

    CONSTRAINT PK_PHANCONG PRIMARY KEY(MANV, MADA),

    CONSTRAINT FK_PC_NV
        FOREIGN KEY(MANV)
        REFERENCES NHANVIEN(MANV),

    CONSTRAINT FK_PC_DA
        FOREIGN KEY(MADA)
        REFERENCES DEAN(MADA),

    CONSTRAINT CHK_PC_THOIGIAN CHECK(THOIGIAN > 0)
);
GO

CREATE TABLE THANNHAN
(
    MANV VARCHAR(5),
    MATN VARCHAR(5),
    HOTN NVARCHAR(20),
    TENTN NVARCHAR(40),
    PHAI NVARCHAR(3),
    NGAYSINH DATE,
    QUANHE NVARCHAR(20),

    CONSTRAINT PK_THANNHAN PRIMARY KEY(MANV, MATN),

    CONSTRAINT FK_TN_NV
        FOREIGN KEY(MANV)
        REFERENCES NHANVIEN(MANV),

    CONSTRAINT CHK_TN_PHAI CHECK(PHAI IN (N'Nam', N'Nữ'))
);
GO

-- ============================================================
-- PHẦN 2: NHẬP DỮ LIỆU
-- ============================================================

-- 1. PHONGBAN

INSERT INTO PHONGBAN (MAPHG, TENPHG, TRGPHG, NGNC)
VALUES
    ('NC', N'Nghiên cứu', NULL, '2000-01-15'),
    ('DH', N'Điều hành', NULL, '2001-03-01'),
    ('KD', N'Kinh doanh', NULL, '2002-05-10'),
    ('NS', N'Nhân sự', NULL, '2001-07-20'),
    ('TC', N'Tài chính', NULL, '2000-09-05'),
    ('KT', N'Kỹ thuật', NULL, '2002-01-12'),
    ('MK', N'Marketing', NULL, '2003-02-18'),
    ('HC', N'Hành chính', NULL, '2000-04-01'),
    ('IT', N'Công nghệ thông tin', NULL, '2002-08-25'),
    ('QA', N'Đảm bảo chất lượng', NULL, '2003-06-11'),
    ('PR', N'Truyền thông', NULL, '2004-01-09'),
    ('LG', N'Hậu cần', NULL, '2001-11-30'),
    ('DV', N'Dịch vụ khách hàng', NULL, '2003-09-14'),
    ('PT', N'Phát triển sản phẩm', NULL, '2002-04-22'),
    ('DT', N'Đào tạo', NULL, '2004-03-05'),
    ('PL', N'Pháp chế', NULL, '2001-06-19'),
    ('KH', N'Kế hoạch', NULL, '2002-10-08'),
    ('VH', N'Vận hành', NULL, '2003-12-01'),
    ('DA', N'Quản lý dự án', NULL, '2004-05-17'),
    ('AT', N'An toàn thông tin', NULL, '2005-02-28');
GO

-- 2. NHANVIEN

INSERT INTO NHANVIEN (MANV, HONV, TENLOT, TENNV, NGSINH, DCHI, PHAI, MLUONG, MA_NQL, PHONG)
VALUES
    ('001', N'Đinh', N'Bá', N'Tiến', '1963-01-09', N'731 Trần Hưng Đạo, Tp HCM', N'Nam', 3500000.00, NULL, 'NC'),
    ('002', N'Nguyễn', N'Thanh', N'Tùng', '1962-08-20', N'291 Hồ Văn Huê, Tp HCM', N'Nam', 4000000.00, '001', 'NC'),
    ('003', N'Lê', N'Thị', N'Nhàn', '1961-07-12', N'22 Nguyễn Văn Cừ, Hà Nội', N'Nữ', 3200000.00, '002', 'DH'),
    ('004', N'Đinh', N'Quang', N'Huy', '1964-04-15', N'45 Lê Lợi, Tp HCM', N'Nam', 2800000.00, '001', 'NC'),
    ('005', N'Trần', N'Minh', N'Khôi', '1988-11-03', N'18 Hai Bà Trưng, Hà Nội', N'Nam', 2400000.00, '003', 'DH'),
    ('006', N'Phạm', N'Thu', N'Hà', '1965-02-25', N'88 Võ Văn Tần, Tp HCM', N'Nữ', 3600000.00, '002', 'KD'),
    ('007', N'Ngô', N'Văn', N'An', '1975-06-14', N'102 Nguyễn Huệ, Đà Nẵng', N'Nam', 2100000.00, '006', 'KD'),
    ('008', N'Vũ', N'Hồng', N'Ngọc', '1960-12-10', N'56 Trần Phú, Tp HCM', N'Nữ', 2900000.00, '003', 'NS'),
    ('009', N'Hoàng', N'Đức', N'Mạnh', '1982-09-19', N'77 Lý Thường Kiệt, Hà Nội', N'Nam', 1900000.00, '008', 'NS'),
    ('010', N'Đặng', N'Kim', N'Chi', '1963-05-28', N'12 Phan Đình Phùng, Tp HCM', N'Nữ', 3800000.00, '002', 'TC'),
    ('011', N'Bùi', N'Gia', N'Bảo', '1990-03-17', N'30 Pasteur, Tp HCM', N'Nam', 2200000.00, '010', 'TC'),
    ('012', N'Đỗ', N'Thị', N'Mai', '1964-10-04', N'91 Cách Mạng Tháng 8, Hà Nội', N'Nữ', 3300000.00, '003', 'KT'),
    ('013', N'Lý', N'Hoàng', N'Nam', '1979-07-22', N'64 Điện Biên Phủ, Đà Nẵng', N'Nam', 2600000.00, '012', 'KT'),
    ('014', N'Mai', N'Thanh', N'Lan', '1962-01-30', N'15 Nguyễn Thị Minh Khai, Tp HCM', N'Nữ', 3100000.00, '006', 'MK'),
    ('015', N'Trương', N'Quốc', N'Việt', '1985-12-05', N'120 Hùng Vương, Cần Thơ', N'Nam', 1800000.00, '014', 'MK'),
    ('016', N'Phan', N'Ánh', N'Nguyệt', '1965-08-11', N'204 Ba Tháng Hai, Tp HCM', N'Nữ', 2700000.00, '008', 'HC'),
    ('017', N'Lưu', N'Tuấn', N'Kiệt', '1992-04-29', N'39 Phạm Ngũ Lão, Hà Nội', N'Nam', 2300000.00, '012', 'IT'),
    ('018', N'Hồ', N'Ngọc', N'Diệp', '1961-11-16', N'83 Bùi Viện, Tp HCM', N'Nữ', 3400000.00, '010', 'QA'),
    ('019', N'Dương', N'Minh', N'Tuấn', '1977-06-02', N'51 Trần Hưng Đạo, Huế', N'Nam', 2500000.00, '018', 'PR'),
    ('020', N'Tạ', N'Thị', N'Hương', '1964-09-08', N'140 Lê Duẩn, Đà Nẵng', N'Nữ', 3700000.00, '001', 'PT');
GO

-- Cập nhật trưởng phòng cho PHONGBAN

UPDATE PHONGBAN SET TRGPHG = '001' WHERE MAPHG = 'NC';
UPDATE PHONGBAN SET TRGPHG = '003' WHERE MAPHG = 'DH';
UPDATE PHONGBAN SET TRGPHG = '006' WHERE MAPHG = 'KD';
UPDATE PHONGBAN SET TRGPHG = '008' WHERE MAPHG = 'NS';
UPDATE PHONGBAN SET TRGPHG = '010' WHERE MAPHG = 'TC';
UPDATE PHONGBAN SET TRGPHG = '012' WHERE MAPHG = 'KT';
UPDATE PHONGBAN SET TRGPHG = '014' WHERE MAPHG = 'MK';
UPDATE PHONGBAN SET TRGPHG = '016' WHERE MAPHG = 'HC';
UPDATE PHONGBAN SET TRGPHG = '017' WHERE MAPHG = 'IT';
UPDATE PHONGBAN SET TRGPHG = '018' WHERE MAPHG = 'QA';
UPDATE PHONGBAN SET TRGPHG = '019' WHERE MAPHG = 'PR';
UPDATE PHONGBAN SET TRGPHG = '007' WHERE MAPHG = 'LG';
UPDATE PHONGBAN SET TRGPHG = '009' WHERE MAPHG = 'DV';
UPDATE PHONGBAN SET TRGPHG = '020' WHERE MAPHG = 'PT';
UPDATE PHONGBAN SET TRGPHG = '005' WHERE MAPHG = 'DT';
UPDATE PHONGBAN SET TRGPHG = '011' WHERE MAPHG = 'PL';
UPDATE PHONGBAN SET TRGPHG = '013' WHERE MAPHG = 'KH';
UPDATE PHONGBAN SET TRGPHG = '015' WHERE MAPHG = 'VH';
UPDATE PHONGBAN SET TRGPHG = '004' WHERE MAPHG = 'DA';
UPDATE PHONGBAN SET TRGPHG = '002' WHERE MAPHG = 'AT';
GO

-- 3. DIADIEMPHG

INSERT INTO DIADIEMPHG (MAPHG, DIADIEM)
VALUES
    ('NC', N'Hà Nội'),
    ('NC', N'Đà Nẵng'),
    ('DH', N'Tp HCM'),
    ('KD', N'Hà Nội'),
    ('NS', N'Đà Nẵng'),
    ('TC', N'Hà Nội'),
    ('KT', N'Tp HCM'),
    ('MK', N'Đà Nẵng'),
    ('HC', N'Hà Nội'),
    ('IT', N'Tp HCM'),
    ('QA', N'Đà Nẵng'),
    ('PR', N'Tp HCM'),
    ('LG', N'Cần Thơ'),
    ('DV', N'Tp HCM'),
    ('PT', N'Hà Nội'),
    ('PL', N'Hà Nội'),
    ('KH', N'Tp HCM'),
    ('VH', N'Đà Nẵng'),
    ('DA', N'Hà Nội'),
    ('AT', N'Huế');
GO

-- 4. DEAN

INSERT INTO DEAN (MADA, TENDA, DDIEM_DA, PHONG, NGBD_DA, NGKT_DA)
VALUES
    ('DA1', N'Tin Học Hóa', N'Hà Nội', 'NC', '2024-01-01', '2024-12-31'),
    ('DA2', N'Sản phẩm X', N'Tp HCM', 'NC', '2024-02-01', '2024-11-30'),
    ('DA3', N'Đào Tạo', N'Hà Nội', 'DH', '2024-03-01', '2024-10-31'),
    ('DA4', N'Chuyển đổi số', N'Tp HCM', 'NC', '2024-01-15', '2024-12-15'),
    ('DA5', N'Tự động hóa kho', N'Đà Nẵng', 'KT', '2024-04-01', '2025-01-31'),
    ('DA6', N'Mở rộng thị trường', N'Tp HCM', 'KD', '2024-02-10', '2024-09-30'),
    ('DA7', N'Chuẩn hóa nhân sự', N'Hà Nội', 'NS', '2024-05-01', '2024-11-15'),
    ('DA8', N'Quản trị ngân sách', N'Tp HCM', 'TC', '2024-01-20', '2024-12-20'),
    ('DA9', N'Thương hiệu số', N'Đà Nẵng', 'MK', '2024-03-15', '2024-10-20'),
    ('DA0', N'Số hóa hồ sơ', N'Hà Nội', 'HC', '2024-06-01', '2024-12-31'),
    ('D11', N'Nâng cấp mạng lõi', N'Tp HCM', 'IT', '2024-02-20', '2024-08-31'),
    ('D12', N'Kiểm thử tự động', N'Đà Nẵng', 'QA', '2024-04-10', '2024-11-30'),
    ('D13', N'Truyền thông nội bộ', N'Tp HCM', 'PR', '2024-05-05', '2024-10-15'),
    ('D14', N'Tối ưu chuỗi cung ứng', N'Cần Thơ', 'LG', '2024-01-10', '2024-12-10'),
    ('D15', N'Tổng đài thông minh', N'Tp HCM', 'DV', '2024-03-25', '2024-09-25'),
    ('D16', N'Nghiên cứu AI ứng dụng', N'Hà Nội', 'PT', '2024-06-15', '2025-06-15'),
    ('D17', N'Tuân thủ pháp lý', N'Hà Nội', 'PL', '2024-02-05', '2024-07-31'),
    ('D18', N'Lập kế hoạch 2025', N'Tp HCM', 'KH', '2024-07-01', '2024-12-31'),
    ('D19', N'Giám sát vận hành', N'Đà Nẵng', 'VH', '2024-04-18', '2024-11-18'),
    ('D20', N'Bảo mật dữ liệu', N'Huế', 'AT', '2024-05-12', '2024-12-25');
GO

-- 5. PHANCONG

INSERT INTO PHANCONG (MANV, MADA, THOIGIAN)
VALUES
    ('001', 'DA1', 20),
    ('001', 'DA2', 15),
    ('001', 'DA4', 10),
    ('002', 'DA1', 20),
    ('002', 'DA2', 18),
    ('002', 'DA4', 12),
    ('003', 'DA3', 20),
    ('004', 'DA1', 20),
    ('004', 'DA2', 16),
    ('004', 'DA4', 14),
    ('005', 'DA3', 15),
    ('006', 'DA6', 20),
    ('007', 'DA6', 12),
    ('008', 'DA7', 18),
    ('009', 'DA7', 10),
    ('010', 'DA8', 22),
    ('011', 'DA8', 8),
    ('012', 'DA5', 25),
    ('013', 'DA5', 15),
    ('014', 'DA9', 16);
GO

-- 6. THANNHAN

INSERT INTO THANNHAN (MANV, MATN, HOTN, TENTN, PHAI, NGAYSINH, QUANHE)
VALUES
    ('001', 'TN1', N'Đinh', N'Minh Anh', N'Nữ', '2015-05-10', N'Con'),
    ('001', 'TN2', N'Đinh', N'Gia Huy', N'Nam', '2018-09-21', N'Con'),
    ('001', 'TN3', N'Lê', N'Thị Hoa', N'Nữ', '1965-03-14', N'Vợ'),
    ('002', 'TN1', N'Nguyễn', N'Bảo Vy', N'Nữ', '2012-07-04', N'Con'),
    ('002', 'TN2', N'Nguyễn', N'Anh Khoa', N'Nam', '2016-11-19', N'Con'),
    ('002', 'TN3', N'Trần', N'Thị Mai', N'Nữ', '1964-08-22', N'Vợ'),
    ('003', 'TN1', N'Lê', N'Quang Dũng', N'Nam', '2010-02-11', N'Con'),
    ('004', 'TN1', N'Đinh', N'Thảo Vy', N'Nữ', '2019-06-30', N'Con'),
    ('005', 'TN1', N'Trần', N'Văn Hùng', N'Nam', '1958-12-01', N'Cha'),
    ('006', 'TN1', N'Phạm', N'Ngọc Hân', N'Nữ', '2014-04-17', N'Con'),
    ('007', 'TN1', N'Ngô', N'Khánh Linh', N'Nữ', '2017-01-25', N'Con'),
    ('008', 'TN1', N'Vũ', N'Minh Khang', N'Nam', '2011-08-08', N'Con'),
    ('008', 'TN2', N'Vũ', N'Thị Lan', N'Nữ', '1955-10-03', N'Mẹ'),
    ('008', 'TN3', N'Nguyễn', N'Văn Đức', N'Nam', '1959-07-12', N'Chồng'),
    ('010', 'TN1', N'Đặng', N'Gia Linh', N'Nữ', '2013-09-15', N'Con'),
    ('012', 'TN1', N'Đỗ', N'Tuấn Anh', N'Nam', '2016-05-02', N'Con'),
    ('014', 'TN1', N'Mai', N'Phương Thảo', N'Nữ', '2015-12-20', N'Con'),
    ('016', 'TN1', N'Phan', N'Hoàng Phúc', N'Nam', '2018-03-18', N'Con'),
    ('018', 'TN1', N'Hồ', N'Gia Hân', N'Nữ', '2014-07-27', N'Con'),
    ('020', 'TN1', N'Tạ', N'Minh Quân', N'Nam', '2017-10-12', N'Con');
GO

-- ============================================================
-- PHẦN 3: BÀI TẬP DML

-- Câu 1
-- Tìm những nhân viên (MANV, HONV, TENLOT, TENNV)
-- làm việc ở phòng 'NC'.
-- ============================================================

SELECT
    MANV,
    HONV,
    TENLOT,
    TENNV
FROM NHANVIEN
WHERE PHONG = 'NC';
GO

-- Câu 2
-- Tìm những nhân viên (MANV, HONV, TENLOT, TENNV, PHAI)
-- có mức lương trên 2.000.000.

SELECT
    MANV,
    HONV,
    TENLOT,
    TENNV,
    PHAI
FROM NHANVIEN
WHERE MLUONG > 2000000;
GO

-- Câu 3
-- Tìm họ tên nhân viên và tên phòng ban nhân viên đó
-- trực thuộc có mức lương từ 2.000.000 đến 3.000.000.

SELECT
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    pb.TENPHG
FROM NHANVIEN nv
INNER JOIN PHONGBAN pb
    ON pb.MAPHG = nv.PHONG
WHERE nv.MLUONG BETWEEN 2000000 AND 3000000;
GO

-- Câu 4
-- Tìm các nhân viên có mức lương trên 2.500.000 ở phòng NC
-- hoặc các nhân viên có mức lương trên 3.000.000 ở phòng DH.

SELECT
    MANV,
    CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_NV
FROM NHANVIEN
WHERE (MLUONG > 2500000 AND PHONG = 'NC')
    OR (MLUONG > 3000000 AND PHONG = 'DH');
GO

-- Câu 5
-- Cho biết họ tên đầy đủ của các nhân viên ở 'Tp HCM'.

SELECT CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_NV
FROM NHANVIEN
WHERE DCHI LIKE N'%Tp HCM%';
GO

-- Câu 6
-- Cho biết họ tên đầy đủ của các nhân viên
-- có họ bắt đầu bằng ký tự 'N'.

SELECT CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_NV
FROM NHANVIEN
WHERE HONV LIKE N'N%';
GO

-- Câu 7
-- Cho biết ngày sinh và địa chỉ của nhân viên 'Đinh Bá Tiến'.

SELECT
    NGSINH,
    DCHI
FROM NHANVIEN
WHERE CONCAT_WS(' ',HONV,TENLOT,TENNV) = N'Đinh Bá Tiến';
GO

-- Câu 8
-- Cho biết các nhân viên có năm sinh
-- trong khoảng 1960 đến 1965.

SELECT CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_NV
FROM NHANVIEN
WHERE YEAR(NGSINH) BETWEEN 1960 AND 1965;
GO

-- Câu 9
-- Cho biết các nhân viên và tuổi của nhân viên.

SELECT
    CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_NV,
    DATEDIFF(YEAR,NGSINH,GETDATE()) AS TUOI_NV
FROM NHANVIEN;
GO

-- Câu 10
-- Lập danh sách các thân nhân dưới 18 tuổi
-- của các nhân viên có mã là '001'.

SELECT
    CONCAT_WS(' ',HOTN,TENTN) AS HOTEN_THANNHAN,
    MANV
FROM THANNHAN
WHERE DATEDIFF(YEAR,NGAYSINH,GETDATE()) < 18
    AND MANV = '001';
GO

-- Câu 11
-- Danh sách tất cả các nhân viên nữ trên 30 tuổi.

SELECT CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_NV
FROM NHANVIEN
WHERE PHAI = N'Nữ'
    AND DATEDIFF(YEAR,NGSINH,GETDATE()) > 30;
GO

-- Câu 12
-- Với mỗi phòng ban, cho biết tên phòng ban
-- và địa điểm phòng.

SELECT
    pb.TENPHG,
    ddp.DIADIEM
FROM PHONGBAN pb
INNER JOIN DIADIEMPHG ddp
    ON ddp.MAPHG = pb.MAPHG;
GO

-- Câu 13
-- Tìm tên những người trưởng phòng của từng phòng ban.

SELECT DISTINCT
    pb.TENPHG,
    CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_TRUONGPHONG
FROM PHONGBAN pb
INNER JOIN NHANVIEN nv
    ON nv.MANV = pb.TRGPHG;
GO

-- Câu 14
-- Tìm TENDA, MADA, DDIEM_DA, TENPHG, MAPHG, TRPHG, NGNC.

SELECT
    d.TENDA,
    d.MADA,
    d.DDIEM_DA,
    pb.TENPHG,
    pb.MAPHG,
    pb.TRGPHG,
    pb.NGNC
FROM DEAN d
INNER JOIN PHONGBAN pb
    ON pb.MAPHG = d.PHONG;
GO

-- Câu 15
-- Tìm tên và địa chỉ của tất cả các nhân viên
-- của phòng 'Nghiên cứu'.

SELECT
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    nv.DCHI
FROM NHANVIEN nv
INNER JOIN PHONGBAN pb
    ON pb.MAPHG = nv.PHONG
WHERE pb.TENPHG = N'Nghiên cứu';
GO

-- Câu 16
-- Tìm tên những nữ nhân viên và tên người thân của họ.

SELECT
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    CONCAT_WS(' ',tn.HOTN,tn.TENTN) AS HOTEN_THANNHAN
FROM NHANVIEN nv
INNER JOIN THANNHAN tn
    ON tn.MANV = nv.MANV
WHERE nv.PHAI = N'Nữ';
GO

-- Câu 17
-- Tìm mã số và tên những nhân viên thuộc phòng 'Nghiên Cứu'
-- tham gia đề án 'Tin Học Hóa' với thời gian làm việc
-- 20 giờ/tuần.

SELECT
    nv.MANV,
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV
FROM NHANVIEN nv
INNER JOIN PHONGBAN pb
    ON pb.MAPHG = nv.PHONG
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
INNER JOIN DEAN d
    ON d.MADA = pc.MADA
WHERE pb.TENPHG = N'Nghiên Cứu'
    AND d.TENDA = N'Tin Học Hóa'
    AND pc.THOIGIAN = 20;
GO

-- Câu 18
-- Với mọi đề án ở 'Hà Nội', liệt kê các mã số đề án (MADA),
-- tên phòng ban chủ trì đề án.

SELECT
    d.MADA,
    pb.TENPHG
FROM DEAN d
INNER JOIN PHONGBAN pb
    ON pb.MAPHG = d.PHONG
WHERE d.DDIEM_DA = N'Hà Nội';
GO

-- Câu 19
-- Với mỗi đề án ở 'Hà Nội', cho biết tên đề án,
-- tên phòng ban, họ tên và ngày nhậm chức của trưởng phòng
-- của phòng ban chủ trì đề án đó.

SELECT
    d.TENDA,
    pb.TENPHG,
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_TRGPHONG,
    pb.NGNC
FROM DEAN d
INNER JOIN PHONGBAN pb
    ON pb.MAPHG = d.PHONG
INNER JOIN NHANVIEN nv
    ON nv.MANV = pb.TRGPHG
WHERE d.DDIEM_DA = N'Hà Nội';
GO

-- Câu 20
-- Với mỗi đề án ở 'Hà Nội', cho biết tên phòng (PHONG),
-- họ tên trưởng phòng (HONV, TENLOT, TENNV)
-- cũng như địa chỉ (DCHI) và ngày sinh (NGSINH) của người ấy.

SELECT
    pb.TENPHG,
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    nv.DCHI,
    nv.NGSINH
FROM PHONGBAN pb
INNER JOIN DEAN d
    ON d.PHONG = pb.MAPHG
INNER JOIN NHANVIEN nv
    ON nv.MANV = pb.TRGPHG
WHERE d.DDIEM_DA = N'Hà Nội';
GO

-- Câu 21
-- Với mỗi nhân viên, cho biết họ tên nhân viên
-- và họ tên người quản lý trực tiếp của nhân viên đó.

SELECT
    CONCAT_WS(' ',nv1.HONV,nv1.TENLOT,nv1.TENNV) AS HOTEN_NV,
    CONCAT_WS(' ',nv2.HONV,nv2.TENLOT,nv2.TENNV) AS HOTEN_NQUANLY
FROM NHANVIEN nv1
LEFT JOIN NHANVIEN nv2
    ON nv2.MANV = nv1.MA_NQL;
GO

-- Câu 22
-- Với mỗi nhân viên, cho biết họ tên nhân viên và họ tên
-- trưởng phòng của phòng ban mà nhân viên đó làm việc.

SELECT
    CONCAT_WS(' ',nv1.HONV,nv1.TENLOT,nv1.TENNV) AS HOTEN_NV,
    CONCAT_WS(' ',nv2.HONV,nv2.TENLOT,nv2.TENNV) AS HOTEN_TRGPHG
FROM NHANVIEN nv1
LEFT JOIN PHONGBAN pb
    ON pb.MAPHG = nv1.PHONG
LEFT JOIN NHANVIEN nv2
    ON nv2.MANV = pb.TRGPHG;
GO

-- Câu 23
-- Cho biết họ tên nhân viên (HONV, TENLOT, TENNV)
-- và tên các đề án mà nhân viên ấy tham gia nếu có.

SELECT
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    d.TENDA
FROM NHANVIEN nv
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
INNER JOIN DEAN d
    ON d.MADA = pc.MADA;
GO

-- Câu 24
-- Cho biết tên các đề án mà nhân viên 'Đinh Bá Tiến'
-- đã tham gia.

SELECT
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    d.TENDA
FROM NHANVIEN nv
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
INNER JOIN DEAN d
    ON d.MADA = pc.MADA
WHERE CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) = N'Đinh Bá Tiến';
GO

-- Câu 25
-- Cho biết số lượng đề án của công ty.



-- Câu 26
-- Cho biết số lượng đề án do phòng 'Nghiên Cứu' chủ trì.

-- Câu 27
-- Cho biết lương trung bình của tất cả các nữ nhân viên.

-- Câu 28
-- Cho biết số thân nhân của nhân viên 'Đinh Bá Tiến'.

-- Câu 29
-- Với mỗi đề án, liệt kê tên đề án (TENDA)
-- và tổng số giờ làm việc một tuần
-- của tất cả các nhân viên tham dự đề án đó.

-- Câu 30
-- Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia
-- đề án đó.

-- Câu 31
-- Với mỗi đề án, cho biết tên đề án và số lượng công việc
-- của đề án này.

-- Câu 32
-- Với mỗi công việc trong đề án có mã đề án là 'Đào Tạo',
-- cho biết số lượng nhân viên được phân công.

-- Câu 33
-- Với mỗi nhân viên, cho biết họ và tên nhân viên
-- và nhân viên đó có bao nhiêu thân nhân.

-- Câu 34
-- Với mỗi nhân viên, cho biết số lượng nhân viên
-- mà nhân viên đó quản lý trực tiếp.

-- Câu 35
-- Với mỗi phòng ban, liệt kê tên phòng ban (TENPHG)
-- và lương trung bình của những nhân viên làm việc
-- cho phòng ban đó.

-- Câu 36
-- Với các phòng ban có mức lương trung bình trên 30,000,
-- liệt kê tên phòng ban và số lượng nhân viên
-- của phòng ban đó.

-- Câu 37
-- Với mỗi phòng ban, cho biết tên phòng ban
-- và số lượng đề án mà phòng ban đó chủ trì.

-- Câu 38
-- Với mỗi phòng ban, cho biết tên phòng ban,
-- họ tên người trưởng phòng
-- và số lượng đề án mà phòng ban đó chủ trì.

-- Câu 39
-- Cho biết số đề án diễn ra tại từng địa điểm.

-- Câu 40
-- Cho biết danh sách các đề án (MADA) có: nhân công với họ
-- (HONV) là 'Dinh' hoặc có người trưởng phòng chủ trì đề án
-- với họ (HONV) là 'Dinh'.

-- Câu 41
-- Danh sách những nhân viên (HONV, TENLOT, TENNV)
-- có trên 2 thân nhân.

-- Câu 42
-- Danh sách những nhân viên (HONV, TENLOT, TENNV)
-- không có thân nhân nào.

-- Câu 43
-- Danh sách những trưởng phòng (HONV, TENLOT, TENNV)
-- có tối thiểu một thân nhân.

-- Câu 44
-- Tìm họ (HONV) của những trưởng phòng chưa có gia đình.

-- Câu 45
-- Cho biết họ tên nhân viên (HONV, TENLOT, TENNV)
-- có mức lương trên mức lương trung bình
-- của phòng 'Nghiên cứu'.

-- Câu 46
-- Cho biết tên phòng ban và họ tên trưởng phòng
-- của phòng ban có đông nhân viên nhất.

-- Câu 47
-- Tìm họ tên (HONV, TENLOT, TENNV) và địa chỉ (DCHI)
-- của những nhân viên làm việc cho một đề án ở 'TP HCM'
-- nhưng phòng ban mà họ trực thuộc lại không tọa lạc ở 
-- thành phố 'TP HCM'.

-- Câu 48
-- Tổng quát câu 47, tìm họ tên và địa chỉ của các nhân viên
-- làm việc cho một đề án ở một thành phố nhưng phòng ban
-- mà họ trực thuộc lại không toạ lạc ở thành phố đó.

-- Câu 49
-- Danh sách những nhân viên (HONV, TENLOT, TENNV)
-- làm việc trong mọi  đề án của công ty.

-- Câu 50
-- Danh sách những nhân viên (HONV, TENLOT, TENNV)
-- được phân công tất cả đề án do phòng số 'Nghien cuu'
-- chủ trì.

-- Câu 51
-- Tìm họ tên nhân viên tham gia tất cả các đề án
-- do phòng ban của nhân viên đó trực thuộc chủ trì.

-- Câu 52
-- Tìm những nhân viên (HONV, TENLOT, TENNV)
-- được phân công tất cả đề án mà nhân viên 'Đinh Bá Tiến'
-- làm việc.

-- Câu 53
-- Cho biết những nhân được phân công cho tất cả
-- các công việc trong đề án 'Sản phẩm X'.

-- Câu 54
-- Cho biết danh sách nhân viên tham gia vào
-- tất cả các đề án ở TP HCM.

-- Câu 55
-- Cho biết phòng ban chủ trì tất cả các đề án ở TP HCM.