USE master;
GO

-- ============================================================
-- PHẦN I: TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG
-- Câu 1
-- Tạo cơ sở dữ liệu QLGiangDay.
-- ============================================================

CREATE DATABASE QLGiangDay;
GO

USE QLGiangDay;
GO

-- Câu 2
-- Tạo các bảng và thiết lập khóa chính, khóa ngoại.

CREATE TABLE KHOA
(
    MAKHOA VARCHAR(5),
    TENKHOA VARCHAR(200) NOT NULL,

    CONSTRAINT PK_KHOA PRIMARY KEY (MAKHOA)
);
GO

CREATE TABLE GIAOVIEN
(
    MAGV VARCHAR(5),
    HOTEN VARCHAR(100) NOT NULL,
    MAKHOA VARCHAR(5) NOT NULL,

    CONSTRAINT PK_GIAOVIEN PRIMARY KEY (MAGV),

    CONSTRAINT FK_KHOA_GV FOREIGN KEY (MAKHOA)
        REFERENCES KHOA(MAKHOA)
);
GO

CREATE TABLE MONHOC
(
    MAMH VARCHAR(20),
    TENMH VARCHAR(200) NOT NULL,

    CONSTRAINT PK_MONHOC PRIMARY KEY (MAMH)
);
GO

CREATE TABLE PHONGHOC
(
    PHONG VARCHAR(5),
    CHUCNANG VARCHAR(200),

    CONSTRAINT PK_PHONGHOC PRIMARY KEY (PHONG)
);
GO

CREATE TABLE LOP
(
    MALOP VARCHAR(5),
    TENLOP VARCHAR(200) NOT NULL,
    MAKHOA VARCHAR(5) NOT NULL,

    CONSTRAINT PK_LOP PRIMARY KEY (MALOP),
    
    CONSTRAINT FK_KHOA_L FOREIGN KEY (MAKHOA)
        REFERENCES KHOA(MAKHOA)
);
GO

CREATE TABLE LICHDAY
(
    MAGV VARCHAR(5),
    MAMH VARCHAR(20),
    PHONG VARCHAR(5),
    MALOP VARCHAR(5),
    NGAYDAY DATETIME,
    TUTIET INT,
    DENTIET INT,
    BAIDAY VARCHAR(200),
    LYTHUYET VARCHAR(200),
    GHICHU VARCHAR(200),

    CONSTRAINT PK_LICHDAY PRIMARY KEY (MAGV, MAMH, PHONG, MALOP),

    CONSTRAINT FK_GIAOVIEN_LD FOREIGN KEY (MAGV)
        REFERENCES GIAOVIEN(MAGV),

    CONSTRAINT FK_MONHOC_LD FOREIGN KEY (MAMH)
        REFERENCES MONHOC(MAMH),

    CONSTRAINT FK_PHONGHOC_LD FOREIGN KEY (PHONG)
        REFERENCES PHONGHOC(PHONG),

    CONSTRAINT FK_LOP_LD FOREIGN KEY (MALOP)
        REFERENCES LOP(MALOP)
);
GO

-- Câu 4
-- Thêm các cột ngày sinh, giới tính và tuổi vào GIAOVIEN.

ALTER TABLE GIAOVIEN
    ADD NGSINH DATE;
GO

ALTER TABLE GIAOVIEN
    ADD GIOITINH VARCHAR(3);
GO

ALTER TABLE GIAOVIEN
    ADD TUOI INT;
GO

-- Ràng buộc: Tuổi giáo viên phải nằm trong khoảng từ 22 đến 67.

ALTER TABLE GIAOVIEN
    ADD CONSTRAINT CHK_GIAOVIEN
        CHECK (TUOI BETWEEN 22 AND 67);
GO

-- Câu 5
-- Thêm cột SUCCHUA vào PHONGHOC.

ALTER TABLE PHONGHOC
    ADD SUCCHUA INT;
GO

-- Ràng buộc: Sức chứa phòng học phải lớn hơn 0.

ALTER TABLE PHONGHOC
    ADD CONSTRAINT CHK_PHONGHOC
        CHECK (SUCCHUA > 0);
GO

-- Câu 6
-- Thêm các cột SOTC, TCLT và TCTH vào MONHOC.

ALTER TABLE MONHOC
    ADD SOTC INT;
GO

ALTER TABLE MONHOC
    ADD TCLT INT;
GO

ALTER TABLE MONHOC
    ADD TCTH INT;
GO

-- Ràng buộc: Số tín chỉ của môn học nằm trong khoảng từ 1 đến 4.

ALTER TABLE MONHOC
    ADD CONSTRAINT CHK_SOTC
        CHECK (SOTC BETWEEN 1 AND 4);
GO

-- Ràng buộc: Số tín chỉ lý thuyết nằm trong khoảng từ 0 đến 4.

ALTER TABLE MONHOC
    ADD CONSTRAINT CHK_TCLT
        CHECK (TCLT BETWEEN 0 AND 4);
GO

-- Ràng buộc: Số tín chỉ thực hành nằm trong khoảng từ 0 đến 4.

ALTER TABLE MONHOC
    ADD CONSTRAINT CHK_TCTH
        CHECK (TCTH BETWEEN 0 AND 4);
GO

-- Ràng buộc
-- Tổng số tín chỉ bằng số tín chỉ lý thuyết
-- cộng với số tín chỉ thực hành.

ALTER TABLE MONHOC
    ADD CONSTRAINT CHK_TONGTC
        CHECK (SOTC = TCLT + TCTH);
GO

-- Câu 7
-- Thêm cột SISO vào LOP.

ALTER TABLE LOP
    ADD SISO INT;
GO

-- Ràng buộc: Sĩ số lớp phải lớn hơn 0.

ALTER TABLE LOP
    ADD CONSTRAINT CHK_LOP
        CHECK (SISO > 0);
GO

-- ============================================================
-- Câu 8
-- Thêm các ràng buộc toàn vẹn cho các cột:
-- SISO, SOTC, TCLT, TCTH, SUCCHUA và TUOI.
--
-- Các ràng buộc đã được thiết lập ở Câu 4, Câu 5, Câu 6
-- và Câu 7 thông qua các CHECK CONSTRAINT.
-- ============================================================