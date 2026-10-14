USE master;
GO

-- ============================================================
-- PHẦN I: TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG
-- ============================================================

-- Câu 1: Tạo cơ sở dữ liệu QL_CONGTRINH.

CREATE DATABASE QL_CONGTRINH;
GO

USE QL_CONGTRINH;
GO


-- ============================================================
-- Câu 2: Tạo các bảng trong cơ sở dữ liệu QL_CONGTRINH.
--
-- Các bảng cần tạo:
-- KTRUCSU   : Thông tin kiến trúc sư.
-- CHUTHAU   : Thông tin chủ thầu.
-- CHUNHAN   : Thông tin chủ nhân công trình.
-- CONGNHAN  : Thông tin công nhân.
-- CONGTRINH : Thông tin công trình.
-- THAMGIA   : Thông tin công nhân tham gia công trình.
-- THIETKE   : Thông tin kiến trúc sư thiết kế công trình.
-- ============================================================

CREATE TABLE KTRUCSU
(
    HOTEN_KTS NVARCHAR(100),
    NAMS_KTS INT,
    PHAI NVARCHAR(3),
    NOI_TN NVARCHAR(200),
    DCHI_LL_KTS NVARCHAR(200),
    CONSTRAINT PK_KTRUCSU PRIMARY KEY (HOTEN_KTS)
);
GO

CREATE TABLE CHUTHAU
(
    TEN_THAU NVARCHAR(100),
    TEL NVARCHAR(20) NOT NULL,
    DCHI_THAU NVARCHAR(200),
    CONSTRAINT PK_CHUTHAU PRIMARY KEY (TEN_THAU)
);
GO

CREATE TABLE CHUNHAN
(
    TEN_CHU NVARCHAR(100),
    DCHI_CHU NVARCHAR(200) NOT NULL,
    CONSTRAINT PK_CHUNHAN PRIMARY KEY (TEN_CHU)
);
GO

CREATE TABLE CONGNHAN
(
    HOTEN_CN NVARCHAR(100),
    NAMS_CN INT,
    NAM_VAO_N DATETIME,
    CH_MON NVARCHAR(200),
    CONSTRAINT PK_CONGNHAN PRIMARY KEY (HOTEN_CN)
);
GO

CREATE TABLE CONGTRINH
(
    STT_CTR NUMERIC IDENTITY(1,1),
    TEN_CTR NVARCHAR(200) NOT NULL,
    DCHI_CTR NVARCHAR(200),
    TINH_THANH NVARCHAR(100),
    KINH_PHI FLOAT,
    TEN_CHU NVARCHAR(100) NOT NULL,
    TEN_THAU NVARCHAR(100) NOT NULL,
    NGAY_BD DATETIME,

    CONSTRAINT PK_CONGTRINH PRIMARY KEY (STT_CTR),

    CONSTRAINT FK_CONGTRINH_CHUNHAN FOREIGN KEY (TEN_CHU)
        REFERENCES CHUNHAN(TEN_CHU),

    CONSTRAINT FK_CONGTRINH_CHUTHAU FOREIGN KEY (TEN_THAU)
        REFERENCES CHUTHAU(TEN_THAU)
);
GO

CREATE TABLE THAMGIA
(
    HOTEN_CN NVARCHAR(100),
    STT_CTR NUMERIC,
    NGAY_TGIA DATETIME,
    SO_NGAY INT,

    CONSTRAINT PK_THAMGIA PRIMARY KEY (HOTEN_CN, STT_CTR),

    CONSTRAINT FK_THAMGIA_CONGNHAN FOREIGN KEY (HOTEN_CN)
        REFERENCES CONGNHAN(HOTEN_CN),

    CONSTRAINT FK_THAMGIA_CONGTRINH FOREIGN KEY (STT_CTR)
        REFERENCES CONGTRINH(STT_CTR)
);
GO

CREATE TABLE THIETKE
(
    HOTEN_KTS NVARCHAR(100),
    STT_CTR NUMERIC,
    THU_LAO FLOAT,

    CONSTRAINT PK_THIETKE PRIMARY KEY (HOTEN_KTS, STT_CTR),

    CONSTRAINT FK_THIETKE_KTRUCSU FOREIGN KEY (HOTEN_KTS)
        REFERENCES KTRUCSU(HOTEN_KTS),

    CONSTRAINT FK_THIETKE_CONGTRINH FOREIGN KEY (STT_CTR)
        REFERENCES CONGTRINH(STT_CTR)
);
GO


-- ============================================================
-- Câu 3: Tạo các liên kết giữa các bảng trong cơ sở dữ liệu.
--
-- Các liên kết được khai báo bằng FOREIGN KEY trong
-- các câu lệnh CREATE TABLE ở trên:
--
-- CONGTRINH.TEN_CHU  -> CHUNHAN.TEN_CHU
-- CONGTRINH.TEN_THAU -> CHUTHAU.TEN_THAU
-- THAMGIA.HOTEN_CN   -> CONGNHAN.HOTEN_CN
-- THAMGIA.STT_CTR    -> CONGTRINH.STT_CTR
-- THIETKE.HOTEN_KTS  -> KTRUCSU.HOTEN_KTS
-- THIETKE.STT_CTR    -> CONGTRINH.STT_CTR
-- ============================================================


-- ============================================================
-- Câu 4: Xem mô hình liên kết giữa các bảng trong cơ sở dữ liệu.
--
-- Thực hiện bằng Database Diagrams trong SQL Server
-- Management Studio (SSMS).
-- ============================================================