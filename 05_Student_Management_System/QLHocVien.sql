USE master;
GO

CREATE DATABASE QLHOCVIEN;
GO

USE QLHOCVIEN;
GO

-- ============================================================
-- PHẦN I: TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG
-- ============================================================

CREATE TABLE KHOA
(
    MAKHOA VARCHAR(4),
    TENKHOA NVARCHAR(40) NOT NULL,
    NGTLAP SMALLDATETIME,
    TRGKHOA VARCHAR(4) NOT NULL,

    CONSTRAINT PK_KHOA PRIMARY KEY(MAKHOA)
);
GO

CREATE TABLE MONHOC
(
    MAMH VARCHAR(10),
    TENMH NVARCHAR(40) NOT NULL,
    TCLT TINYINT,
    TCTH TINYINT,
    MAKHOA VARCHAR(4) NOT NULL,

    CONSTRAINT PK_MONHOC PRIMARY KEY(MAMH),

    CONSTRAINT FK_KHOA_MH FOREIGN KEY(MAKHOA)
        REFERENCES KHOA(MAKHOA)
);
GO

CREATE TABLE DIEUKIEN
(
    MAMH VARCHAR(10),
    MAMH_TRUOC VARCHAR(10),

    CONSTRAINT PK_DIEUKIEN PRIMARY KEY(MAMH, MAMH_TRUOC),

    CONSTRAINT FK_MONHOC_MH FOREIGN KEY(MAMH)
        REFERENCES MONHOC(MAMH),

    CONSTRAINT FK_MONHOC_MHT FOREIGN KEY(MAMH_TRUOC)
        REFERENCES MONHOC(MAMH)
);
GO

CREATE TABLE GIAOVIEN
(
    MAGV VARCHAR(4),
    HOTEN NVARCHAR(40) NOT NULL,
    HOCVI NVARCHAR(10),
    HOCHAM NVARCHAR(10),
    GIOITINH NVARCHAR(3),
    NGSINH SMALLDATETIME,
    NGVL SMALLDATETIME,
    HESO NUMERIC(4,2),
    MUCLUONG MONEY,
    MAKHOA VARCHAR(4) NOT NULL,

    CONSTRAINT PK_GIAOVIEN PRIMARY KEY(MAGV),

    CONSTRAINT FK_KHOA_GV FOREIGN KEY(MAKHOA)
        REFERENCES KHOA(MAKHOA)
);
GO

CREATE TABLE LOP
(
    MALOP VARCHAR(3),
    TENLOP NVARCHAR(40) NOT NULL,
    TRGLOP VARCHAR(5) NOT NULL,
    SISO TINYINT,
    MAGVCN VARCHAR(4) NOT NULL,

    CONSTRAINT PK_LOP PRIMARY KEY(MALOP),

    CONSTRAINT FK_GIAOVIEN_L FOREIGN KEY(MAGVCN)
        REFERENCES GIAOVIEN(MAGV)
);
GO

CREATE TABLE HOCVIEN
(
    MAHV VARCHAR(5),
    HO NVARCHAR(40),
    TEN NVARCHAR(10),
    NGSINH SMALLDATETIME,
    GIOITINH NVARCHAR(3),
    NOISINH NVARCHAR(40),
    MALOP VARCHAR(3) NOT NULL,

    CONSTRAINT PK_HOCVIEN PRIMARY KEY(MAHV),

    CONSTRAINT FK_LOP_HV FOREIGN KEY(MALOP)
        REFERENCES LOP(MALOP)
);
GO

CREATE TABLE GIANGDAY
(
    MALOP VARCHAR(3),
    MAMH VARCHAR(10),
    MAGV VARCHAR(4),
    HOCKY TINYINT,
    NAM SMALLINT,
    TUNGAY SMALLDATETIME,
    DENNGAY SMALLDATETIME,

    CONSTRAINT PK_GIANGDAY PRIMARY KEY(MALOP, MAMH),

    CONSTRAINT FK_LOP_GD FOREIGN KEY(MALOP)
        REFERENCES LOP(MALOP),

    CONSTRAINT FK_MONHOC_GD FOREIGN KEY(MAMH)
        REFERENCES MONHOC(MAMH),

    CONSTRAINT FK_GIAOVIEN_GD FOREIGN KEY(MAGV)
        REFERENCES GIAOVIEN(MAGV)
);
GO

CREATE TABLE KETQUATHI
(
    MAHV VARCHAR(5),
    MAMH VARCHAR(10),
    LANTHI TINYINT,
    NGTHI SMALLDATETIME,
    DIEM NUMERIC(4,2),
    KQUA VARCHAR(10),

    CONSTRAINT PK_KETQUATHI PRIMARY KEY(MAHV, MAMH, LANTHI),

    CONSTRAINT FK_HOCVIEN_KQT FOREIGN KEY(MAHV)
        REFERENCES HOCVIEN(MAHV),

    CONSTRAINT FK_MONHOC_KQT FOREIGN KEY(MAMH)
        REFERENCES MONHOC(MAMH)
);
GO

-- Bổ sung khóa ngoại chéo

ALTER TABLE KHOA
    ADD CONSTRAINT FK_GIAOVIEN_K FOREIGN KEY(TRGKHOA)
        REFERENCES GIAOVIEN(MAGV);
GO

ALTER TABLE LOP
    ADD CONSTRAINT FK_HOCVIEN_L FOREIGN KEY(TRGLOP)
        REFERENCES HOCVIEN(MAHV);
GO


-- ============================================================
-- PHẦN II: SỬA ĐỔI CẤU TRÚC VÀ RÀNG BUỘC TOÀN VẸN
-- ============================================================

-- Câu 1
-- Thêm vào 3 thuộc tính GHICHU, DIEMTB, XEPLOAI cho quan hệ HOCVIEN. 

ALTER TABLE HOCVIEN ADD GHICHU NVARCHAR(20);
GO

ALTER TABLE HOCVIEN ADD DIEMTB NUMERIC(3,2);
GO

ALTER TABLE HOCVIEN ADD XEPLOAI NVARCHAR(10);
GO

-- Câu 2
-- Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp,
-- 2 ký tự cuối cùng là số thứ tự học viên trong lớp. VD: ‘K1101’.

ALTER TABLE HOCVIEN
    ADD CONSTRAINT CHK_MAHV
        CHECK 
        (
            LEN(MAHV) = 5 AND
            LEFT(MAHV, 3) = MALOP AND
            RIGHT(MAHV, 2) LIKE '[0-9][0-9]'
        );
GO

-- Câu 3
-- Thuộc tính `GIOITINH` chỉ có giá trị là ‘Nam’ hoặc ‘Nữ’.

ALTER TABLE GIAOVIEN
    ADD CONSTRAINT CHK_GT_GV
        CHECK (GIOITINH IN ('Nam', N'Nữ'));
GO

ALTER TABLE HOCVIEN
    ADD CONSTRAINT CHK_GT_HV
        CHECK (GIOITINH IN ('Nam', N'Nữ'));
GO

-- Câu 4
-- Điểm số của một lần thi có giá trị từ 0 đến 10
-- và cần lưu đến 2 số lẽ (VD: 6.22).

ALTER TABLE KETQUATHI
    ADD CONSTRAINT CHK_DIEM
        CHECK (DIEM BETWEEN 0.00 AND 10.00);
GO

-- Câu 5
-- Kết quả thi là ‘Đạt’ nếu điểm từ 5 đến 10
-- và ‘K Đạt’ nếu điểm nhỏ hơn 5.

ALTER TABLE KETQUATHI ALTER COLUMN KQUA NVARCHAR(10);
GO

ALTER TABLE KETQUATHI
    ADD CONSTRAINT CHK_KETQUA
        CHECK 
        (
            (DIEM >= 5.00 AND DIEM <= 10.00 AND KQUA = N'Đạt')
            OR
            (DIEM < 5.00 AND KQUA = N'K Đạt')
        );
GO

-- Câu 6
-- Học viên thi một môn tối đa 3 lần.

ALTER TABLE KETQUATHI
    ADD CONSTRAINT CHK_LANTHI CHECK (LANTHI > 0 AND LANTHI <= 3);
GO

-- Câu 7
-- Học kỳ chỉ có giá trị từ 1 đến 3. 

ALTER TABLE GIANGDAY
    ADD CONSTRAINT CHK_HOCKY CHECK (HOCKY BETWEEN 1 AND 3);
GO

-- Câu 8
-- Học vị của giáo viên chỉ có giá trị là ‘CN’, ‘KS’, ‘ThS’, ‘TS’.

ALTER TABLE GIAOVIEN
    ADD CONSTRAINT CHK_HOCVI
        CHECK (HOCVI IN ('CN', 'KS', 'ThS', 'TS'));
GO

-- Câu 9
-- Lớp trưởng của một lớp phải là học viên của lớp đó. 

CREATE TRIGGER TRG_LOPTRUONG
ON LOP
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN HOCVIEN hv ON i.TRGLOP = hv.MAHV
        WHERE i.MALOP <> hv.MALOP
    )
    BEGIN
        PRINT N'Lỗi: Lớp trưởng phải là học viên của chính lớp đó!';
        ROLLBACK TRANSACTION;
    END;
END;
GO

CREATE TRIGGER TRG_HOCVIEN_CHUYENLOP
ON HOCVIEN
AFTER UPDATE
AS
BEGIN
    IF UPDATE(MALOP)
    BEGIN
        IF EXISTS
        (
            SELECT 1
            FROM LOP l
            JOIN inserted i ON l.TRGLOP = i.MAHV
            WHERE l.MALOP <> i.MALOP
        )
        BEGIN
            PRINT N'Lỗi: Học viên này đang làm lớp trưởng.';
            PRINT N'Phải bổ nhiệm lớp trưởng mới trước khi cho học viên này chuyển lớp!';
            ROLLBACK TRANSACTION;
        END;
    END;
END;
GO

-- Câu 10
-- Trưởng khoa phải là giáo viên thuộc khoa và có học vị ‘TS’ hoặc ‘PTS’.

CREATE TRIGGER TRG_HOCVI
ON KHOA
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN GIAOVIEN gv ON i.TRGKHOA = gv.MAGV
        WHERE i.MAKHOA <> gv.MAKHOA
    )
    BEGIN
        PRINT N'Lỗi: Trưởng khoa phải là giáo viên của chính khoa đó!';
        ROLLBACK TRANSACTION;
    END;
END;
GO

CREATE TRIGGER TRG_CAPNHAT_TRUONGKHOA
ON GIAOVIEN
AFTER UPDATE, DELETE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM deleted d
        JOIN KHOA k ON d.MAGV = k.TRGKHOA
    )
    AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        PRINT N'Lỗi: Không thể xóa giáo viên vì họ đang đương nhiệm Trưởng khoa.';
        PRINT N'Vui lòng bổ nhiệm người khác làm Trưởng khoa trước khi thực hiện thao tác này.';
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN KHOA k ON i.MAGV = k.TRGKHOA
        WHERE i.MAKHOA <> k.MAKHOA OR i.HOCVI NOT IN ('TS', 'PTS')
    )
    BEGIN
        PRINT N'Lỗi: Giáo viên này đang là Trưởng khoa!';
        PRINT N'Không được phép chuyển khoa hay thay đổi học vị sai quy định.';
        PRINT N'Học vị Trưởng khoa phải là TS hoặc PTS.';
        ROLLBACK TRANSACTION;
    END;
END;
GO

ALTER TABLE GIAOVIEN DROP CONSTRAINT CHK_HOCVI;
GO

ALTER TABLE GIAOVIEN
    ADD CONSTRAINT CHK_HOCVI_UPDATED
        CHECK (HOCVI IN ('CN', 'KS', 'ThS', 'TS', 'PTS'));
GO

-- Câu 11
-- Học viên ít nhất là 18 tuổi.

ALTER TABLE HOCVIEN
    ADD CONSTRAINT CHK_TUOI_HV
        CHECK 
        (
            (YEAR(GETDATE()) - YEAR(NGSINH) > 18)
            OR
            (
                (YEAR(GETDATE()) - YEAR(NGSINH) = 18)
                AND
                (
                    MONTH(NGSINH) < 4 OR
                    (MONTH(NGSINH) = 4 AND DAY(NGSINH) <= 29)
                )
            )
        );
GO

-- Câu 12
-- Giảng dạy một môn học ngày bắt đầu (TUNGAY)
-- phải nhỏ hơn ngày kết thúc (DENNGAY).

ALTER TABLE GIANGDAY
    ADD CONSTRAINT CHK_NGAY
        CHECK (TUNGAY < DENNGAY);
GO

-- Câu 13
-- Giáo viên khi vào làm ít nhất là 22 tuổi.

ALTER TABLE GIAOVIEN
    ADD CONSTRAINT CHK_TUOI_GV
        CHECK 
        (
            (YEAR(GETDATE()) - YEAR(NGSINH) > 22)
            OR
            (
                (YEAR(GETDATE()) - YEAR(NGSINH) = 22)
                AND
                (
                    MONTH(NGSINH) < 4 OR
                    (MONTH(NGSINH) = 4 AND DAY(NGSINH) <= 29)
                )
            )
        );
GO

-- Câu 14
-- Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành
-- chênh lệch nhau không quá 3.

ALTER TABLE MONHOC
    ADD CONSTRAINT CHK_TC_CHENHLECH
        CHECK (ABS(TCLT - TCTH) <= 3);
GO

-- Câu 15
-- Học viên chỉ được thi một môn học nào đó khi
-- lớp của học viên đã học xong môn học này.

CREATE TRIGGER TRG_KQTHI_HOCXONG
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN HOCVIEN hv ON i.MAHV = hv.MAHV
        JOIN GIANGDAY gd ON hv.MALOP = gd.MALOP AND i.MAMH = gd.MAMH
        WHERE i.NGTHI <= gd.DENNGAY
    )
    BEGIN
        PRINT N'Lỗi: Lớp của học viên chưa học xong môn này!';
        PRINT N'Ngày thi bắt buộc phải diễn ra SAU ngày kết thúc môn học.';
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Câu 16
-- Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn.

CREATE TRIGGER TRG_TOIDA_3MON
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT gd.MALOP, gd.HOCKY, gd.NAM
        FROM GIANGDAY gd
        JOIN inserted i ON i.MALOP = gd.MALOP AND i.HOCKY = gd.HOCKY AND i.NAM = gd.NAM
        GROUP BY gd.MALOP, gd.HOCKY, gd.NAM
        HAVING COUNT(DISTINCT gd.MAMH) > 3
    )
    BEGIN
        PRINT N'Lỗi: Vượt quá số môn học quy định!';
        PRINT N'Mỗi lớp chỉ được học tối đa 3 môn học trong 1 học kỳ của một năm học.';
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Câu 17
-- Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó.

CREATE TRIGGER TRG_SISO_SOHV
ON LOP
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN HOCVIEN hv ON i.MALOP = hv.MALOP
        GROUP BY hv.MALOP, i.SISO
        HAVING i.SISO <> COUNT(hv.MAHV)
    )
    BEGIN
        PRINT N'Lỗi: Sĩ số của lớp chưa bằng số học viên.';
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Câu 18
-- Trong quan hệ DIEUKIEN giá trị của thuộc tính `MAMH` và `MAMH_TRUOC` 
-- trong cùng một bộ không được giống nhau (‘A’,’A’)
-- và cũng không tồn tại hai bộ (‘A’,’B’) và (‘B’,’A’).

ALTER TABLE DIEUKIEN
    ADD CONSTRAINT CHK_MH_KHONG_TRUNG
        CHECK (MAMH <> MAMH_TRUOC);
GO

CREATE TRIGGER TRG_DK_TIENQUYET
ON DIEUKIEN
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM DIEUKIEN dk
        JOIN inserted i ON dk.MAMH = i.MAMH_TRUOC AND dk.MAMH_TRUOC = i.MAMH
    )
    BEGIN
        PRINT N'Lỗi: Vòng lặp điều kiện tiên quyết!';
        PRINT N'Môn học này và điều kiện đang bị ràng buộc chéo lẫn nhau.';
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Câu 19
-- Các giáo viên có cùng học vị, học hàm, hệ số lương
-- thì mức lương bằng nhau.

CREATE TRIGGER TRG_MUCLUONG_BANGNHAU
ON GIAOVIEN
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN GIAOVIEN gv ON i.HOCVI = gv.HOCVI AND i.HOCHAM = gv.HOCHAM AND i.HESO = gv.HESO
        WHERE i.MUCLUONG <> gv.MUCLUONG
    )
    BEGIN
        PRINT N'Lỗi: Giáo viên có cùng học vị, học hàm, hệ số lương.';
        PRINT N'Mức lương phải giống nhau.';
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Câu 20
-- Học viên chỉ được thi lại (lần thi >1)
-- khi điểm của lần thi trước đó dưới 5.

CREATE TRIGGER TRG_THILAI
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN KETQUATHI kq ON i.MAHV = kq.MAHV AND i.MAMH = kq.MAMH AND i.LANTHI - 1 = kq.LANTHI
        WHERE i.LANTHI > 1 AND kq.DIEM >= 5
    )
    BEGIN
        PRINT N'Lỗi: Học viên chỉ thi lại khi điểm cũ dưới 5.';
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Câu 21
-- Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước
-- (cùng học viên, cùng môn học).

CREATE TRIGGER TRG_NGAYTHI
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN KETQUATHI kq ON i.MAHV = kq.MAHV AND i.MAMH = kq.MAMH AND i.LANTHI > kq.LANTHI
        WHERE i.NGTHI <= kq.NGTHI
    )
    BEGIN
        PRINT N'Lỗi: Ngày thi lần thi sau phải lớn hơn lần thi trước đó.';
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Câu 22
-- Học viên chỉ được thi những môn mà lớp của học viên đó đã học xong.

CREATE TRIGGER TRG_DSMON_HOCXONG
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM HOCVIEN hv
            JOIN GIANGDAY gd ON hv.MALOP = gd.MALOP
            WHERE hv.MAHV = i.MAHV AND gd.MAMH = i.MAMH AND i.NGTHI > gd.DENNGAY
        )
    )
    BEGIN
        PRINT N'Lỗi: Học viên chỉ được thi sau khi lớp học xong môn học này!';
        ROLLBACK TRANSACTION;
    END;
END;
GO

-- Câu 23
-- Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước sau
-- giữa các môn học (sau khi học xong những môn học phải
-- học trước mới được học những môn liền sau). 

CREATE TRIGGER TRG_PHANCONG_GIANGDAY
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN DIEUKIEN dk ON i.MAMH = dk.MAMH
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM GIANGDAY gd_truoc
            WHERE gd_truoc.MALOP = i.MALOP AND gd_truoc.MAMH = dk.MAMH_TRUOC AND gd_truoc.DENNGAY < i.TUNGAY
        )
    )
    BEGIN
        PRINT N'Lỗi: Thứ tự môn học được phân công giảng dạy phải đảm bảo điều kiện tiên quyết.';
    END;
END;
GO

-- Câu 24
-- Giáo viên chỉ được phân công dạy những môn
-- thuộc khoa giáo viên đó phụ trách.

CREATE TRIGGER TRG_PHANCONG_GIAOVIEN
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted i
        JOIN GIAOVIEN gv ON i.MAGV = gv.MAGV
        JOIN MONHOC mh ON i.MAMH = mh.MAMH
        WHERE gv.MAKHOA <> mh.MAKHOA
    )
    BEGIN
        PRINT N'Lỗi: Giáo viên chỉ được phân công giảng dạy những môn thuộc khoa mình đang công tác.';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- ============================================================
-- PHẦN 2: NHẬP DỮ LIỆU
-- ============================================================

-- Nhập dữ liệu cho bảng KHOA.

ALTER TABLE KHOA ALTER COLUMN TRGKHOA VARCHAR(4);
GO

INSERT INTO KHOA(MAKHOA, TENKHOA, NGTLAP, TRGKHOA)
VALUES
    ('KHMT', 'Khoa hoc may tinh', '2005-6-07', NULL),
    ('HTTT', 'He thong thong tin', '2005-6-07', NULL),
    ('CNPM', 'Cong nghe phan mem', '2005-6-07', NULL),
    ('MTT', 'Mang va truyen thong', '2005-10-20', NULL),
    ('KTMT', 'Ky thuat may tinh', '2005-12-20', NULL);
GO

-- Nhập dữ liệu cho bảng MONHOC.

INSERT INTO MONHOC(MAMH, TENMH, TCLT, TCTH, MAKHOA)
VALUES
    ('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT'),
    ('CTRR', 'Cau truc roi rac', 4, 1, 'KHMT'),
    ('CSDL', 'Co so du lieu', 3, 1, 'HTTT'),
    ('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT'),
    ('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT'),
    ('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT'),
    ('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT'),
    ('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT'),
    ('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT'),
    ('HDH', 'He dieu hanh', 3, 1, 'KTMT'),
    ('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM'),
    ('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM'),
    ('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM');
GO

-- Nhập dữ liệu cho bảng DIEUKIEN.

INSERT INTO DIEUKIEN(MAMH, MAMH_TRUOC)
VALUES
    ('CSDL', 'CTRR'),
    ('CSDL', 'CTDLGT'),
    ('CTDLGT', 'THDC'),
    ('PTTKTT', 'THDC'),
    ('PTTKTT', 'CTDLGT'),
    ('DHMT', 'THDC'),
    ('LTHDT', 'THDC'),
    ('PTTKHTTT', 'CSDL');
GO

-- Nhập dữ liệu cho bảng GIAOVIEN.

INSERT INTO GIAOVIEN(MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGVL, HESO, MUCLUONG, MAKHOA)
VALUES
    ('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '1950-5-02', '2004-01-11', 5.00, 2250000, 'KHMT'),
    ('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '1965-12-17', '2004-4-20', 4.50, 2025000, 'HTTT'),
    ('GV03', 'Do Nghiem Phung', 'TS', 'GS', N'Nữ', '1950-8-01', '2004-9-23', 4.00, 1800000, 'CNPM'),
    ('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '1961-02-22', '2005-01-12', 4.50, 2025000, 'KTMT'),
    ('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '1958-3-12', '2005-01-12', 3.00, 1350000, 'HTTT'),
    ('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '1953-3-11', '2005-01-12', 4.50, 2025000, 'KHMT'),
    ('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '1971-11-23', '2005-3-01', 4.00, 1800000, 'KHMT'),
    ('GV08', 'Le Thi Tran', 'KS', NULL, N'Nữ', '1974-3-26', '2005-3-01', 1.69, 760500, 'KHMT'),
    ('GV09', 'Nguyen To Lan', 'ThS', 'GV', N'Nữ', '1966-12-31', '2005-3-01', 4.00, 1800000, 'HTTT'),
    ('GV10', 'Le Tran Anh Loan', 'KS', NULL, N'Nữ', '1972-7-17', '2005-3-01', 1.86, 837000, 'CNPM'),
    ('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '1980-01-12', '2005-5-15', 2.67, 1201500, 'MTT'),
    ('GV12', 'Tran Van Anh', 'CN', NULL, N'Nữ', '1981-3-29', '2005-5-15', 1.69, 760500, 'CNPM'),
    ('GV13', 'Nguyen Linh Dan', 'CN', NULL, N'Nữ', '1980-5-23', '2005-5-15', 1.69, 760500, 'KTMT'),
    ('GV14', 'Truong Minh Chau', 'ThS', 'GV', N'Nữ', '1976-11-30', '2005-5-15', 3.00, 1350000, 'MTT'),
    ('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '1978-5-04', '2005-5-15', 3.00, 1350000, 'KHMT');
GO

-- Cập nhật trưởng khoa cho các khoa.

UPDATE KHOA SET TRGKHOA = 'GV01' WHERE MAKHOA = 'KHMT';
GO
UPDATE KHOA SET TRGKHOA = 'GV02' WHERE MAKHOA = 'HTTT';
GO
UPDATE KHOA SET TRGKHOA = 'GV03' WHERE MAKHOA = 'CNPM';
GO

-- Nhập dữ liệu cho bảng LOP.

ALTER TABLE LOP ALTER COLUMN TRGLOP VARCHAR(5);
GO

INSERT INTO LOP(MALOP, TENLOP, TRGLOP, SISO, MAGVCN)
VALUES
    ('K11', 'Lop 1 khoa 1', NULL, 11, 'GV07'),
    ('K12', 'Lop 2 khoa 1', NULL, 12, 'GV09'),
    ('K13', 'Lop 3 khoa 1', NULL, 12, 'GV14');
GO

-- Nhập dữ liệu cho bảng HOCVIEN.

INSERT INTO HOCVIEN(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP)
VALUES
    ('K1101', 'Nguyen Van', 'A', '1986-01-27', 'Nam', 'TpHCM', 'K11'),
    ('K1102', 'Tran Ngoc', 'Han', '1986-3-14', N'Nữ', 'Kien Giang', 'K11'),
    ('K1103', 'Ha Duy', 'Lap', '1986-4-18', 'Nam', 'Nghe An', 'K11'),
    ('K1104', 'Tran Ngoc', 'Linh', '1986-3-30', N'Nữ', 'Tay Ninh', 'K11'),
    ('K1105', 'Tran Minh', 'Long', '1986-02-27', 'Nam', 'TpHCM', 'K11'),
    ('K1106', 'Le Nhat', 'Minh', '1986-01-24', 'Nam', 'TpHCM', 'K11'),
    ('K1107', 'Nguyen Nhu', 'Nhut', '1986-01-27', 'Nam', 'Ha Noi', 'K11'),
    ('K1108', 'Nguyen Manh', 'Tam', '1986-02-27', 'Nam', 'Kien Giang', 'K11'),
    ('K1109', 'Phan Thi Thanh', 'Tam', '1986-01-27', N'Nữ', 'Vinh Long', 'K11'),
    ('K1110', 'Le Hoai', 'Thuong', '1986-02-05', N'Nữ', 'Can Tho', 'K11'),
    ('K1111', 'Le Ha', 'Vinh', '1986-12-25', 'Nam', 'Vinh Long', 'K11'),
    ('K1201', 'Nguyen Van', 'B', '1986-02-11', 'Nam', 'TpHCM', 'K12'),
    ('K1202', 'Nguyen Thi Kim', 'Duyen', '1986-01-18', N'Nữ', 'TpHCM', 'K12'),
    ('K1203', 'Tran Thi Kim', 'Duyen', '1986-9-17', N'Nữ', 'TpHCM', 'K12'),
    ('K1204', 'Truong My', 'Hanh', '1986-5-19', N'Nữ', 'Dong Nai', 'K12'),
    ('K1205', 'Nguyen Thanh', 'Nam', '1986-4-17', 'Nam', 'TpHCM', 'K12'),
    ('K1206', 'Nguyen Thi Truc', 'Thanh', '1986-3-04', N'Nữ', 'Kien Giang', 'K12'),
    ('K1207', 'Tran Thi Bich', 'Thuy', '1986-02-08', N'Nữ', 'Nghe An', 'K12'),
    ('K1208', 'Huynh Thi Kim', 'Trieu', '1986-4-08', N'Nữ', 'Tay Ninh', 'K12'),
    ('K1209', 'Pham Thanh', 'Trieu', '1986-02-23', 'Nam', 'TpHCM', 'K12'),
    ('K1210', 'Ngo Thanh', 'Tuan', '1986-02-14', 'Nam', 'TpHCM', 'K12'),
    ('K1211', 'Do Thi', 'Xuan', '1986-3-09', N'Nữ', 'Ha Noi', 'K12'),
    ('K1212', 'Le Thi Phi', 'Yen', '1986-3-12', N'Nữ', 'TpHCM', 'K12'),
    ('K1301', 'Nguyen Thi Kim', 'Cuc', '1986-6-09', N'Nữ', 'Kien Giang', 'K13'),
    ('K1302', 'Truong Thi My', 'Hien', '1986-3-18', N'Nữ', 'Nghe An', 'K13'),
    ('K1303', 'Le Duc', 'Hien', '1986-3-21', 'Nam', 'Tay Ninh', 'K13'),
    ('K1304', 'Le Quang', 'Hien', '1986-4-18', 'Nam', 'TpHCM', 'K13'),
    ('K1305', 'Le Thi', 'Huong', '1986-3-27', N'Nữ', 'TpHCM', 'K13'),
    ('K1306', 'Nguyen Thai', 'Huu', '1986-3-30', 'Nam', 'Ha Noi', 'K13'),
    ('K1307', 'Le Thanh', 'Cong', '1986-10-20', 'Nam', 'Hai Phong', 'K13'),
    ('K1308', 'Tran Thi Le', 'Thanh', '1986-01-01', N'Nữ', 'Ca Mau', 'K13'),
    ('K1309', 'Huynh Ngoc', 'Tham', '1986-11-05', N'Nữ', 'Vinh Long', 'K13'),
    ('K1310', 'Tran Thi Ngoc', 'Tuyen', '1986-3-10', N'Nữ', 'Bac Kan', 'K13'),
    ('K1311', 'Tran Pham', 'Linh', '1986-11-11', 'Nam', 'Soc Trang', 'K13'),
    ('K1312', 'Nguyen', 'Minh', '1986-02-14', 'Nam', 'Da Lat', 'K13');
GO

-- Cập nhật trưởng lớp cho các lớp.

UPDATE LOP SET TRGLOP = 'K1108' WHERE MALOP = 'K11';
GO
UPDATE LOP SET TRGLOP = 'K1205' WHERE MALOP = 'K12';
GO
UPDATE LOP SET TRGLOP = 'K1305' WHERE MALOP = 'K13';
GO

-- Nhập dữ liệu cho bảng GIANGDAY.

INSERT INTO GIANGDAY(MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY)
VALUES
    ('K11', 'THDC', 'GV07', 1, 2006, '2006-01-02', '2006-5-12'),
    ('K12', 'THDC', 'GV06', 1, 2006, '2006-01-02', '2006-5-12'),
    ('K13', 'THDC', 'GV15', 1, 2006, '2006-01-02', '2006-5-12'),
    ('K11', 'CTRR', 'GV01', 1, 2006, '2006-01-09', '2006-5-17'),
    ('K12', 'CTRR', 'GV15', 1, 2006, '2006-01-09', '2006-5-17'),
    ('K13', 'CTRR', 'GV08', 1, 2006, '2006-01-09', '2006-5-17'),
    ('K11', 'CTDLGT', 'GV06', 2, 2006, '2006-6-01', '2006-7-15'),
    ('K12', 'CTDLGT', 'GV08', 2, 2006, '2006-6-01', '2006-7-15'),
    ('K13', 'CTDLGT', 'GV15', 2, 2006, '2006-6-01', '2006-7-15'),
    ('K13', 'CSDL', 'GV05', 3, 2006, '2006-8-01', '2006-12-15'),
    ('K13', 'DHMT', 'GV07', 3, 2006, '2006-8-01', '2006-12-15'),
    ('K11', 'CSDL', 'GV02', 3, 2006, '2006-8-01', '2006-12-15'),
    ('K12', 'CSDL', 'GV09', 3, 2006, '2006-8-01', '2006-12-15'),
    ('K11', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-02-18'),
    ('K12', 'HDH', 'GV04', 1, 2007, '2007-01-02', '2007-3-20'),
    ('K11', 'DHMT', 'GV07', 1, 2007, '2007-02-18', '2007-3-20');
GO

-- Nhập dữ liệu cho bảng KETQUATHI.

INSERT INTO KETQUATHI(MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA)
VALUES
    ('K1101', 'CSDL', 1, '2006-12-20', 10.00, NULL),
    ('K1101', 'CTDLGT', 1, '2006-07-25', 9.00, NULL),
    ('K1101', 'THDC', 1, '2006-05-20', 9.00, NULL),
    ('K1101', 'CTRR', 1, '2006-05-20', 9.50, NULL),
    ('K1102', 'CSDL', 1, '2006-12-20', 4.00, NULL),
    ('K1102', 'CSDL', 2, '2006-12-27', 4.25, NULL),
    ('K1102', 'CSDL', 3, '2007-01-10', 4.50, NULL),
    ('K1102', 'CTDLGT', 1, '2006-07-25', 4.50, NULL),
    ('K1102', 'CTDLGT', 2, '2006-08-05', 4.00, NULL),
    ('K1102', 'CTDLGT', 3, '2006-08-15', 6.00, NULL),
    ('K1102', 'THDC', 1, '2006-05-20', 5.00, NULL),
    ('K1102', 'CTRR', 1, '2006-05-20', 7.00, NULL),
    ('K1103', 'CSDL', 1, '2006-12-20', 3.50, NULL),
    ('K1103', 'CSDL', 2, '2007-01-05', 8.25, NULL),
    ('K1103', 'CTDLGT', 1, '2006-07-25', 7.00, NULL),
    ('K1103', 'THDC', 1, '2006-05-20', 8.00, NULL),
    ('K1103', 'CTRR', 1, '2006-05-20', 6.50, NULL),
    ('K1104', 'CSDL', 1, '2006-12-20', 3.75, NULL),
    ('K1104', 'CTDLGT', 1, '2006-07-25', 4.00, NULL),
    ('K1104', 'THDC', 1, '2006-05-20', 4.00, NULL),
    ('K1104', 'CTRR', 1, '2006-05-20', 4.00, NULL),
    ('K1104', 'CTRR', 2, '2006-05-25', 3.50, NULL),
    ('K1104', 'CTRR', 3, '2006-06-30', 5.00, NULL),
    ('K1201', 'CSDL', 1, '2006-12-20', 6.00, NULL),
    ('K1201', 'CTDLGT', 1, '2006-07-25', 5.00, NULL),
    ('K1201', 'THDC', 1, '2006-05-20', 8.50, NULL),
    ('K1201', 'CTRR', 1, '2006-05-20', 9.00, NULL),
    ('K1202', 'CSDL', 1, '2006-12-20', 8.00, NULL),
    ('K1202', 'CTDLGT', 1, '2006-07-25', 4.00, NULL),
    ('K1202', 'CTDLGT', 2, '2006-8-05', 5.00, NULL),
    ('K1202', 'THDC', 1, '2006-05-20', 4.00, NULL),
    ('K1202', 'THDC', 2, '2006-05-27', 5.00, NULL),
    ('K1202', 'CTRR', 1, '2006-05-20', 3.00, NULL),
    ('K1202', 'CTRR', 2, '2006-05-25', 4.00, NULL),
    ('K1202', 'CTRR', 3, '2006-06-30', 6.25, NULL),
    ('K1203', 'CSDL', 1, '2006-12-20', 9.25, NULL),
    ('K1203', 'CTDLGT', 1, '2006-07-25', 9.50, NULL),
    ('K1203', 'THDC', 1, '2006-05-20', 10.00, NULL),
    ('K1203', 'CTRR', 1, '2006-05-20', 10.00, NULL),
    ('K1204', 'CSDL', 1, '2006-12-20', 8.50, NULL),
    ('K1204', 'CTDLGT', 1, '2006-07-25', 6.75, NULL),
    ('K1204', 'THDC', 1, '2006-05-20', 5.00, NULL),
    ('K1204', 'CTRR', 1, '2006-05-20', 6.00, NULL),
    ('K1301', 'CSDL', 1, '2006-12-20', 4.25, NULL),
    ('K1301', 'CTDLGT', 1, '2006-07-25', 8.00, NULL),
    ('K1301', 'THDC', 1, '2006-05-20', 7.75, NULL),
    ('K1301', 'CTRR', 1, '2006-05-20', 8.00, NULL),
    ('K1302', 'CSDL', 1, '2006-12-20', 6.75, NULL),
    ('K1302', 'CTDLGT', 1, '2006-07-25', 5.00, NULL),
    ('K1302', 'THDC', 1, '2006-05-20', 8.00, NULL),
    ('K1302', 'CTRR', 1, '2006-05-20', 8.50, NULL),
    ('K1303', 'CSDL', 1, '2006-12-20', 4.00, NULL),
    ('K1303', 'CTDLGT', 1, '2006-07-25', 4.50, NULL),
    ('K1303', 'CTDLGT', 2, '2006-8-07', 4.00, NULL),
    ('K1303', 'CTDLGT', 3, '2006-8-15', 5.00, NULL),
    ('K1303', 'THDC', 1, '2006-05-20', 4.50, NULL),
    ('K1303', 'CTRR', 1, '2006-05-20', 3.25, NULL),
    ('K1303', 'CTRR', 2, '2006-05-25', 5.00, NULL),
    ('K1304', 'CSDL', 1, '2006-12-20', 7.75, NULL),
    ('K1304', 'CTDLGT', 1, '2006-07-25', 9.75, NULL),
    ('K1304', 'THDC', 1, '2006-05-20', 5.50, NULL),
    ('K1304', 'CTRR', 1, '2006-05-20', 5.00, NULL),
    ('K1305', 'CSDL', 1, '2006-12-20', 9.25, NULL),
    ('K1305', 'CTDLGT', 1, '2006-07-25', 10.00, NULL),
    ('K1305', 'THDC', 1, '2006-05-20', 8.00, NULL),
    ('K1305', 'CTRR', 1, '2006-05-20', 10.00, NULL);
GO

-- Cập nhật kết quả thi cho các học viên.

UPDATE KETQUATHI SET KQUA = N'Đạt' WHERE DIEM >= 5.0 AND KQUA IS NULL;
GO
UPDATE KETQUATHI SET KQUA = N'K Đạt' WHERE DIEM < 5.0 AND KQUA IS NULL;
GO

-- ============================================================
-- PHẦN 3: BÀI TẬP DML

-- Câu 1
-- Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa.
-- ============================================================

UPDATE GIAOVIEN
    SET HESO = HESO + 0.2
    WHERE MAGV IN
    (
        SELECT TRGKHOA
        FROM KHOA
        WHERE TRGKHOA IS NOT NULL
    );
GO

-- Câu 2
-- Cập nhật giá trị điểm trung bình tất cả các môn học (DIEMTB)
-- của mỗi học viên (tất cả các môn học đều có hệ số 1
-- và nếu học viên thi một môn nhiều lần,
-- chỉ lấy điểm của lần thi sau cùng).

WITH DIEMLANCUOI AS
(
    SELECT MAHV, MAMH, DIEM,
        ROW_NUMBER() OVER (PARTITION BY MAHV, MAMH ORDER BY LANTHI DESC) AS XEPHANG
    FROM KETQUATHI
),
DIEMTB_HV AS
(
    SELECT MAHV, AVG(DIEM) AS DIEMTB_MOI
    FROM DIEMLANCUOI
    WHERE XEPHANG = 1
    GROUP BY MAHV
)
UPDATE HOCVIEN
    SET DIEMTB = ROUND(dtb.DIEMTB_MOI, 2)
    FROM HOCVIEN hv
    JOIN DIEMTB_HV dtb ON hv.MAHV = dtb.MAHV;
GO

-- Câu 3
-- Cập nhật giá trị cho cột GHICHU là ‘Cấm thi’ đối với trường hợp:
-- học viên có một môn bất kỳ thi lần thứ 3 dưới 5 điểm. 

UPDATE HOCVIEN
    SET GHICHU = N'Cấm thi'
    WHERE MAHV IN
    (
        SELECT DISTINCT MAHV
        FROM KETQUATHI
        WHERE LANTHI = 3 AND DIEM < 5.00
    );
GO

-- Câu 4
-- Cập nhật giá trị cho cột `XEPLOAI` trong quan hệ HOCVIEN như sau: 
-- * Nếu DIEMTB >= 9 thì XEPLOAI = ‘XS’
-- * Nếu 8 <= DIEMTB < 9 thì XEPLOAI = ‘G’
-- * Nếu 6.5 <= DIEMTB < 8 thì XEPLOAI = ‘K’
-- * Nếu 5 <=  DIEMTB < 6.5 thì XEPLOAI = ‘TB’
-- * Nếu DIEMTB < 5 thì XEPLOAI = ‘Y’

UPDATE HOCVIEN
    SET XEPLOAI =
        CASE
            WHEN DIEMTB >= 9.00 THEN 'XS'
            WHEN DIEMTB >= 8.00 AND DIEMTB < 9.00 THEN 'G'
            WHEN DIEMTB >= 6.50 AND DIEMTB < 8.00 THEN 'K'
            WHEN DIEMTB >= 5.00 AND DIEMTB < 6.50 THEN 'TB'
            ELSE 'Y'
        END
    WHERE DIEMTB IS NOT NULL;
GO

-- ============================================================
-- PHẦN 4: BÀI TẬP DQL

-- Câu 1
-- In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp)
-- lớp trưởng của các lớp.
-- ============================================================