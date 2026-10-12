USE master
GO

CREATE DATABASE QLHANGHOA
GO

USE QLHANGHOA
GO

-- ============================================================
-- PHẦN I - TẠO CƠ SỞ DỮ LIỆU VÀ CÁC BẢNG
-- ============================================================

CREATE TABLE KHACHHANG
(
	MAKH VARCHAR(4),
	HOTEN NVARCHAR(40),
	DCHI NVARCHAR(50),
	SODT VARCHAR(20),
	NGSINH SMALLDATETIME,
	NGDK SMALLDATETIME,
	DOANHSO MONEY,
	CONSTRAINT PK_KHACHHANG PRIMARY KEY(MAKH)
)
GO

CREATE TABLE NHANVIEN
(
	MANV VARCHAR(4),
	HOTEN NVARCHAR(40),
	SODT VARCHAR(20),
	NGVL SMALLDATETIME,
	CONSTRAINT PK_NHANVIEN PRIMARY KEY(MANV)
)
GO

CREATE TABLE SANPHAM
(
	MASP VARCHAR(4),
	TENSP NVARCHAR(40),
	DVT NVARCHAR(20),
	NUOCSX NVARCHAR(40),
	GIA MONEY,
	CONSTRAINT PK_SANPHAM PRIMARY KEY(MASP)
)
GO

CREATE TABLE HOADON
(
	SOHD INT,
	NGHD SMALLDATETIME,
	MAKH VARCHAR(4),
	MANV VARCHAR(4),
	TRIGIA MONEY,
	CONSTRAINT PK_HOADON PRIMARY KEY(SOHD),
	CONSTRAINT FK_KHACHHANG_HD FOREIGN KEY(MAKH)
								REFERENCES KHACHHANG(MAKH),
	CONSTRAINT FK_NHANVIEN_HD FOREIGN KEY(MANV)
								REFERENCES NHANVIEN(MANV)
)
GO

CREATE TABLE CTHD
(
	SOHD INT,
	MASP VARCHAR(4),
	SL INT,
	CONSTRAINT PK_CTHD PRIMARY KEY(SOHD,MASP),
	CONSTRAINT FK_HOADON_CTHD FOREIGN KEY(SOHD)
								REFERENCES HOADON(SOHD),
	CONSTRAINT FK_SANPHAM_CTHD FOREIGN KEY(MASP)
								REFERENCES SANPHAM(MASP)
)
GO

-- Câu 2
-- Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20)
-- cho quan hệ SANPHAM.

ALTER TABLE SANPHAM
	ADD GHICHU VARCHAR(20)
GO

-- Câu 3
-- Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint
-- cho quan hệ KHACHHANG.

ALTER TABLE KHACHHANG
	ADD LOAIKH TINYINT
GO

-- Câu 4
-- Sửa kiểu dữ liệu của thuộc tính GHICHU
-- trong quan hệ SANPHAM thành varchar(100).

ALTER TABLE SANPHAM
	ALTER COLUMN GHICHU VARCHAR(100)
GO

-- Câu 5
-- Xóa thuộc tính GHICHU trong quan hệ SANPHAM.

ALTER TABLE SANPHAM
	DROP COLUMN GHICHU
GO

-- Câu 6
-- Cài đặt thuộc tính LOAIKH trong quan hệ KHACHHANG
-- có thể lưu các giá trị là: ‘Vang lai’, ‘Thuong xuyen’, ‘Vip’, …

ALTER TABLE KHACHHANG
	ADD CONSTRAINT CHK_LOAIKH
		CHECK(LOAIKH IN('Vang lai','Thuong xuyen','Vip'))
GO

-- Câu 7
-- Đơn vị tính của sản phẩm chỉ có thể là
-- (‘Cây’,’hop’,’cai’,’quyen’,’chuc’).

ALTER TABLE SANPHAM
	ADD CONSTRAINT CHK_DVT
		CHECK(DVT IN('Cây','hop','cai','quyen','chuc'))
GO

-- Câu 8
-- Giá bán của sản phẩm từ 500 đồng trở lên.

ALTER TABLE SANPHAM
	ADD CONSTRAINT CHK_GIA
		CHECK(GIA>=500)
GO

-- Câu 9
-- Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm.

CREATE TRIGGER TRG_KHONGXOASPCUOI
ON CTHD
AFTER DELETE
AS
BEGIN
	DECLARE @MASP_VUAXOA VARCHAR(4)
	DECLARE @SLCONLAI INT

	SELECT @MASP_VUAXOA=MASP FROM deleted

	SELECT @SLCONLAI=COUNT(*)
	FROM CTHD
	WHERE MASP=@MASP_VUAXOA

	IF(@SLCONLAI=0)
	BEGIN
		PRINT N'Lỗi: Hóa đơn phải có ít nhất 1 sản phẩm. Không được xóa!'
		ROLLBACK
	END
END
GO

-- Câu 10
-- Ngày khách hàng đăng ký là khách hàng thành viên phải
-- lớn hơn ngày sinh của người đó. 

ALTER TABLE KHACHHANG
	ADD CONSTRAINT CHK_NGDK_NGSINH
		CHECK(NGDK>NGSINH)
GO

-- Câu 11
-- Ngày mua hàng (NGHD) của một khách hàng thành viên
-- sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên (NGDK).

CREATE TRIGGER TRG_KTNGAYMUAHANG
ON HOADON
AFTER INSERT,UPDATE
AS
BEGIN
	IF EXISTS
	(
		SELECT 1
		FROM inserted i
		JOIN KHACHHANG kh ON i.MAKH=kh.MAKH
		WHERE i.NGHD<kh.NGDK
	)

	BEGIN
		PRINT N'Lỗi: Ngày lập hóa đơn không nhỏ hơn ngày đăng ký thành viên!'
		ROLLBACK TRANSACTION
	END
END
GO

-- Câu 12
-- Ngày bán hàng (NGHD) của một nhân viên
-- phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.

CREATE TRIGGER TRG_KTNGAYBANHANG
ON HOADON
AFTER INSERT,UPDATE
AS
BEGIN
	IF EXISTS
	(
		SELECT 1
		FROM inserted i
		JOIN NHANVIEN nv ON i.MANV=nv.MANV
		WHERE i.NGHD<nv.NGVL
	)

	BEGIN
		PRINT N'Lỗi: Ngày bán hàng không nhỏ hơn ngày vào làm!'
		ROLLBACK TRANSACTION
	END
END
GO

-- Câu 13
-- Mỗi một hóa đơn phải có ít nhất một chi tiết hóa đơn.

CREATE TRIGGER TRG_TOITHIEUMOTCHITIET
ON CTHD
AFTER DELETE,UPDATE
AS
BEGIN
	IF EXISTS
	(
		SELECT d.SOHD
		FROM deleted d
		WHERE NOT EXISTS
		(
			SELECT 1
			FROM CTHD c
			WHERE c.SOHD=d.SOHD
		)
	)

	BEGIN
		PRINT N'Lỗi: Mỗi hóa đơn phải có ít nhất 1 chi tiết hóa đơn. Không được phép xóa chi tiết cuối cùng!'
		ROLLBACK TRANSACTION
	END
END
GO

-- Câu 14
-- Trị giá của một hóa đơn là tổng thành tiền (số lượng*đơn giá)
-- của các chi tiết thuộc hóa đơn đó.

CREATE TRIGGER TRG_CAPNHATTRIGIA_HOADON
ON CTHD
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
	UPDATE hd
	SET hd.TRIGIA=ISNULL(BangTinhTien.TongTien,0)
	FROM HOADON hd
	LEFT JOIN
	(
		SELECT ct.SOHD,SUM(ct.SL*sp.GIA) AS TongTien
		FROM CTHD ct
		JOIN SANPHAM sp ON ct.MASP=sp.MASP
		GROUP BY ct.SOHD
	) AS BangTinhTien ON hd.SOHD=BangTinhTien.SOHD
	WHERE hd.SOHD IN
	(
		SELECT SOHD FROM inserted
		UNION
		SELECT SOHD FROM deleted
	)
END
GO

-- Câu 15
-- Doanh số của một khách hàng là tổng trị giá các hóa đơn
-- mà khách hàng thành viên đó đã mua.

CREATE TRIGGER TRG_CAPNHATDOANHSO_KH
ON HOADON
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
	UPDATE kh
	SET DOANHSO=ISNULL(BangTinhDS.TongDoanhSo,0)
	FROM KHACHHANG kh
	LEFT JOIN
	(
		SELECT MAKH,SUM(TRIGIA) AS TongDoanhSo
		FROM HOADON
		GROUP BY MAKH
	) AS BangTinhDS ON kh.MAKH=BangTinhDS.MAKH
	WHERE kh.MAKH IN
	(
		SELECT MAKH FROM inserted
		UNION
		SELECT MAKH FROM deleted
	)
END
GO

ALTER TABLE KHACHHANG
	DROP CONSTRAINT CHK_LOAIKH
GO

ALTER TABLE KHACHHANG
	ALTER COLUMN LOAIKH VARCHAR(20)
GO

ALTER TABLE KHACHHANG
	ADD CONSTRAINT CHK_LOAIKH
		CHECK(LOAIKH IN('Vang lai','Thuong xuyen','Vip'))
GO

DELETE
	FROM KHACHHANG
GO

-- ============================================================
-- PHẦN II - NHẬP DỮ LIỆU
-- CÂU 1
-- Nhập dữ liệu vào các bảng của CSDL QLHangHoa.
-- ============================================================

INSERT INTO KHACHHANG(MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO,LOAIKH)
	VALUES
		('KH01','Nguyen Van A','731 Tran Hung Dao, Q5, TpHCM','08823451','1960-01-22','2006-02-07',1060000,'Vang lai'),
		('KH02','Tran Ngoc Han','23/5 Nguyen Trai, Q5, TpHCM','0908256478','1974-4-03','2006-3-07',280000,'Vang lai'),
		('KH03','Tran Ngoc Linh','45 Nguyen Canh Chan, Q1, TpHCM','0938776266','1980-6-12','2006-5-08',3860000,'Vang lai'),
		('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q10, TpHCM','0917325476','1965-3-09','2006-02-10',250000,'Vang lai'),
		('KH05','Le Nhat Minh','34 Truong Dinh, Q3, TpHCM','08246108','1950-3-10','2006-8-10',21000,'Vang lai'),
		('KH06','Le Hoai Thuong','227 Nguyen Van Cu, Q5, TpHCM','08631738','1981-01-31','2006-4-11',915000,'Vang lai'),
		('KH07','Nguyen Van Tam','32/3 Tran Binh Trong, Q5, TpHCM','0916783565','1971-4-06','2006-01-12',12500,'Vang lai'),
		('KH08','Phan Thi Thanh','45/2 An Duong Vuong, Q5, TpHCM','0938435756','1971-1-10','2006-3-12',12500,'Vang lai'),
		('KH09','Le Ha Vinh','873 Le Hong Phong, Q5, TpHCM','08654763','1979-9-03','2007-4-01',70000,'Vang lai'),
		('KH10','Ha Duy Lap','34/34B Nguyen Trai, Q1, TphHCM','08768904','1983-5-02','2007-6-01',67500,'Vang lai')
GO

INSERT INTO NHANVIEN(MANV,HOTEN,SODT,NGVL)
	VALUES
		('NV01','Nguyen Nhu Nhut','0927345678','2006-4-13'),
		('NV02','Le Thi Phi Yen','0987567390','2006-4-21'),
		('NV03','Nguyen Van B','0997047382','2006-4-27'),
		('NV04','Ngo Thanh Tuan','0913758498','2006-6-24'),
		('NV05','Nguyen Thi Truc Thanh','0918590387','2006-7-20')
GO

INSERT INTO SANPHAM(MASP,TENSP,DVT,NUOCSX,GIA)
	VALUES
		('BC01','But chi',N'Cây','Singapore',3000),
		('BC02','But chi',N'Cây','Singapore',5000),
		('BC03','But chi',N'Cây','Viet Nam',3500),
		('BC04','But chi','hop','Viet Nam',30000),
		('BB01','But bi',N'Cây','Viet Nam',5000),
		('BB02','But bi',N'Cây',N'Trung Quốc',7000),
		('BB03','But bi','hop','Thai Lan',100000),
		('TV01','Tap 100 giay mong','quyen',N'Trung Quốc',2500),
		('TV02','Tap 200 giay mong','quyen',N'Trung Quốc',4500),
		('TV03','Tap 100 giay tot','quyen','Viet Nam',3000),
		('TV04','Tap 200 giay tot','quyen','Viet Nam',5500),
		('TV05','Tap 100 trang','chuc','Viet Nam',23000),
		('TV06','Tap 200 trang','chuc','Viet Nam',53000),
		('TV07','Tap 100 trang','chuc',N'Trung Quốc',34000),
		('ST01','So tay 500 trang','quyen',N'Trung Quốc',40000),
		('ST02','So tay loai 1','quyen','Viet Nam',55000),
		('ST03','So tay loai 2','quyen','Viet Nam',51000),
		('ST04','So tay','quyen','Thai Lan',55000),
		('ST05','So tay mong','quyen','Thai Lan',20000),
		('ST06','Phan viet bang','hop','Viet Nam',5000),
		('ST07','Phan khong bui','hop','Viet Nam',7000),
		('ST08','Bong bang','cai','Viet Nam',1000),
		('ST09','But long',N'Cây','Viet Nam',5000),
		('ST10','But long',N'Cây',N'Trung Quốc',7000)
GO

UPDATE KHACHHANG
	SET NGDK='2007-01-04'
	WHERE MAKH IN('KH09','KH10')
GO

INSERT INTO HOADON(SOHD,NGHD,MAKH,MANV,TRIGIA)
	VALUES
		(1001,'2006-7-23','KH01','NV01',320000),
		(1002,'2006-8-12','KH01','NV02',840000),
		(1003,'2006-8-23','KH02','NV01',100000),
		(1004,'2006-9-01','KH02','NV01',180000),
		(1005,'2006-10-20','KH01','NV02',3800000),
		(1006,'2006-10-16','KH01','NV03',2430000),
		(1007,'2006-10-28','KH03','NV03',510000),
		(1008,'2006-10-28','KH01','NV03',440000),
		(1009,'2006-10-28','KH03','NV04',200000),
		(1010,'2006-11-01','KH01','NV01',5200000),
		(1011,'2006-11-04','KH04','NV03',250000),
		(1012,'2006-11-30','KH05','NV03',21000),
		(1013,'2006-12-12','KH06','NV01',5000),
		(1014,'2006-12-31','KH03','NV02',3150000),
		(1015,'2007-01-01','KH06','NV01',910000),
		(1016,'2007-01-01','KH07','NV02',12500),
		(1017,'2007-01-02','KH08','NV03',35000),
		(1018,'2007-01-13','KH08','NV03',330000),
		(1019,'2007-01-13','KH01','NV03',30000),
		(1020,'2007-01-14','KH09','NV04',70000),
		(1021,'2007-01-16','KH10','NV03',67500),
		(1022,'2007-01-16',NULL,'NV03',7000),
		(1023,'2007-01-17',NULL,'NV01',330000)
GO

INSERT INTO CTHD(SOHD,MASP,SL)
	VALUES
		(1001,'TV02',10),
		(1001,'ST01',5),
		(1001,'BC01',5),
		(1001,'BC02',10),
		(1001,'ST08',10),
		(1002,'BC04',20),
		(1002,'BB01',20),
		(1002,'BB02',20),
		(1003,'BB03',10),
		(1004,'TV01',20),
		(1004,'TV02',10),
		(1004,'TV03',10),
		(1004,'TV04',10),
		(1005,'TV05',50),
		(1005,'TV06',50),
		(1006,'TV07',20),
		(1006,'ST01',30),
		(1006,'ST02',10),
		(1007,'ST03',10),
		(1008,'ST04',8),
		(1009,'ST05',10),
		(1010,'TV07',50),
		(1010,'ST07',50),
		(1010,'ST08',100),
		(1010,'ST04',50),
		(1010,'TV03',100),
		(1011,'ST06',50),
		(1012,'ST07',3),
		(1013,'ST08',5),
		(1014,'BC02',80),
		(1014,'BB02',100),
		(1014,'BC04',60),
		(1014,'BB01',50),
		(1015,'BB02',30),
		(1015,'BB03',7),
		(1016,'TV01',5),
		(1017,'TV02',1),
		(1017,'TV03',1),
		(1017,'TV04',5),
		(1018,'ST04',6),
		(1019,'ST05',1),
		(1019,'ST06',2),
		(1020,'ST07',10),
		(1021,'ST08',5),
		(1021,'TV01',7),
		(1021,'TV02',10),
		(1022,'ST07',1),
		(1023,'ST04',6)
GO

SELECT * FROM KHACHHANG
GO

SELECT * FROM NHANVIEN
GO

SELECT * FROM SANPHAM
GO

SELECT * FROM HOADON
GO

SELECT * FROM CTHD
GO

-- Câu 2
-- Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM.
-- Tạo quan hệ KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG.

SELECT * INTO SANPHAM1
	FROM SANPHAM
GO

ALTER TABLE SANPHAM1
	ADD CONSTRAINT CHK_DVT1
		CHECK(DVT IN('Cây','hop','cai','quyen','chuc'))
GO

ALTER TABLE SANPHAM1
	ADD CONSTRAINT CHK_GIA1
		CHECK(GIA>=500)
GO

SELECT * INTO KHACHHANG1
	FROM KHACHHANG
GO

ALTER TABLE KHACHHANG1
	ADD CONSTRAINT CHK_LOAIKH1
		CHECK(LOAIKH IN('Vang lai','Thuong xuyen','Vip'))
GO

ALTER TABLE KHACHHANG1
	ADD CONSTRAINT CHK_NGDK_NGSINH1
		CHECK(NGDK>NGSINH)
GO

SELECT * FROM SANPHAM1
GO

SELECT * FROM KHACHHANG1
GO

-- Câu 3
-- Cập nhật giá tăng 5% đối với những sản phẩm do ‘Thai Lan’
-- sản xuất (cho quan hệ SANPHAM1).

UPDATE SANPHAM1
	SET GIA=GIA+(GIA*0.05)
	WHERE NUOCSX='Thai Lan'
GO

SELECT NUOCSX,GIA
	FROM SANPHAM
	WHERE NUOCSX='Thai Lan'
GO

SELECT NUOCSX,GIA
	FROM SANPHAM1
	WHERE NUOCSX='Thai Lan'
GO

-- Câu 4
-- Cập nhật giá giảm 5% đối với những sản phẩm do ‘Trung Quốc’
-- sản xuất có giá từ 10.000 trở xuống (cho quan hệ SANPHAM1).

UPDATE SANPHAM1
	SET GIA=GIA-(GIA*0.05)
	WHERE NUOCSX=N'Trung Quốc' AND
			GIA<=10000
GO

SELECT NUOCSX,GIA
	FROM SANPHAM
	WHERE NUOCSX=N'Trung Quốc'
GO

SELECT NUOCSX,GIA
	FROM SANPHAM1
	WHERE NUOCSX=N'Trung Quốc'
GO

-- Câu 5
-- Cập nhật giá trị LOAIKH là ‘Vip’ đối với những khách hàng
-- đăng ký thành viên trước ngày 1/1/2007 có doanh số từ 10.000.000
-- trở lên hoặc khách hàng đăng ký thành viên từ 1/1/2007 trở về
-- sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG1). 

UPDATE KHACHHANG1
	SET LOAIKH='Vip'
	WHERE (NGDK<'2007-01-01' AND DOANHSO>=10000000) OR
			(NGDK>='2007-01-01' AND DOANHSO>=2000000)
GO

SELECT MAKH,DOANHSO,NGDK,LOAIKH
	FROM KHACHHANG
GO

SELECT MAKH,DOANHSO,NGDK,LOAIKH
	FROM KHACHHANG1
GO

-- ============================================================
-- PHẦN III - BÀI TẬP DML
-- ============================================================

-- Câu 1
-- In ra danh sách các sản phẩm (MASP, TENSP)
-- do 'Trung Quốc' sản xuất.

SELECT MASP,TENSP
	FROM SANPHAM
	WHERE NUOCSX=N'Trung Quốc'
GO

-- Câu 2
-- In ra danh sách các sản phẩm (MASP, TENSP)
-- có đơn vị tính là 'Cây', 'Quyển'.

SELECT MASP,TENSP,DVT
	FROM SANPHAM
	WHERE DVT IN(N'Cây','quyen')
GO

-- Câu 3
-- In ra danh sách các sản phẩm (MASP, TENSP)
-- có mã sản phẩm bắt đầu là 'B' và kết thúc là '01'.

SELECT MASP,TENSP
	FROM SANPHAM
	WHERE MASP LIKE 'B%01'
GO

-- Câu 4
-- In ra danh sách các sản phẩm (MASP, TENSP)
-- do 'Trung Quốc' sản xuất có giá từ 30.000 đến 40.000.

SELECT MASP,TENSP
	FROM SANPHAM
	WHERE NUOCSX=N'Trung Quốc' AND
		GIA BETWEEN 30000 AND 40000
GO

-- Câu 5
-- In ra danh sách các sản phẩm (MASP,TENSP) do ‘Trung Quốc’
-- hoặc ‘Thái Lan’ sản xuất có giá từ 30.000 đến 40.000.

SELECT MASP,TENSP,NUOCSX,GIA
	FROM SANPHAM
	WHERE (NUOCSX=N'Trung Quốc' OR NUOCSX='Thai Lan') AND
		GIA BETWEEN 30000 AND 40000
GO

-- Câu 6
-- In ra các số hóa đơn, trị giá hóa đơn bán ra
-- trong ngày 1/1/2007 và ngày 2/1/2007.

SELECT SOHD,TRIGIA
	FROM HOADON
	WHERE NGHD IN('2007-01-01','2007-01-02')
GO

-- Câu 7
-- In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007,
-- sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).

SELECT SOHD,TRIGIA
	FROM HOADON
	WHERE MONTH(NGHD)=1 AND YEAR(NGHD)=2007
	ORDER BY NGHD ASC,TRIGIA DESC
GO

-- Câu 8
-- In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng
-- trong ngày 1/1/2007.

SELECT kh.MAKH,HOTEN
	FROM KHACHHANG kh
	JOIN HOADON hd ON kh.MAKH=hd.MAKH
	WHERE NGHD='2007-01-01'
GO

-- Câu 9
-- In ra số hóa đơn, trị giá các hóa đơn do nhân viên
-- có tên 'Nguyen Van B' lập trong ngày 28/10/2006.

SELECT SOHD,TRIGIA
	FROM HOADON hd
	JOIN NHANVIEN nv ON hd.MANV=nv.MANV
	WHERE HOTEN='Nguyen Van B' AND
		NGHD='2006-10-28'
GO

-- Câu 10
-- In ra danh sách các sản phẩm (MASP, TENSP) được khách hàng
-- có tên 'Nguyen Van A' mua trong tháng 10/2006.

SELECT sp.MASP,sp.TENSP
	FROM KHACHHANG kh
	JOIN HOADON hd ON kh.MAKH=hd.MAKH
	JOIN CTHD ct ON hd.SOHD=ct.SOHD
	JOIN SANPHAM sp ON ct.MASP=sp.MASP
	WHERE kh.HOTEN='Nguyen Van A' AND
		MONTH(hd.NGHD)=10 AND
		YEAR(hd.NGHD)=2006
GO

-- Câu 11
-- Tìm các số hóa đơn đã mua sản phẩm có mã số 'BB01' hoặc 'BB02'.

SELECT SOHD,ct.MASP
	FROM CTHD ct
	JOIN SANPHAM sp ON ct.MASP=sp.MASP
	WHERE ct.MASP IN('BB01','BB02')
GO

-- Câu 12
-- Tìm các số hóa đơn đã mua sản phẩm có mã số 'BB01' hoặc 'BB02',
-- mỗi sản phẩm mua với số lượng từ 10 đến 20.

SELECT SOHD,ct.MASP
	FROM CTHD ct
	JOIN SANPHAM sp ON ct.MASP=sp.MASP
	WHERE ct.MASP IN('BB01','BB02') AND
			SL BETWEEN 10 AND 20
GO

-- Câu 13
-- Tìm các số hóa đơn mua cùng lúc 2 sản phẩm
-- có mã số 'BB01' và 'BB02', mỗi sản phẩm mua
-- với số lượng từ 10 đến 20.

SELECT SOHD
	FROM CTHD
	WHERE MASP='BB01' AND SL BETWEEN 10 AND 20

INTERSECT

SELECT SOHD
	FROM CTHD
	WHERE MASP='BB02' AND SL BETWEEN 10 AND 20
GO

-- Câu 14
-- In ra danh sách các sản phẩm (MASP, TENSP)
-- do 'Trung Quốc' sản xuất hoặc các sản phẩm
-- được bán ra trong ngày 1/1/2007.

SELECT MASP,TENSP
	FROM SANPHAM
	WHERE NUOCSX=N'Trung Quốc'

UNION

SELECT sp.MASP,sp.TENSP
	FROM HOADON hd
	JOIN CTHD ct ON hd.SOHD=ct.SOHD
	JOIN SANPHAM sp ON ct.MASP=sp.MASP
	WHERE NGHD='2007-01-01'
GO

-- Câu 15
-- In ra danh sách các sản phẩm (MASP, TENSP) không bán được.

SELECT sp.MASP,sp.TENSP
	FROM SANPHAM sp
	WHERE NOT EXISTS
	(
		SELECT 1
		FROM CTHD ct
		WHERE sp.MASP=ct.MASP
	)
GO

-- Câu 16
-- In ra danh sách các sản phẩm (MASP, TENSP)
-- không bán được trong năm 2006.

SELECT sp.MASP,sp.TENSP
	FROM SANPHAM sp
	WHERE NOT EXISTS
	(
		SELECT 1
		FROM CTHD ct
		JOIN HOADON hd ON ct.SOHD=hd.SOHD
		WHERE sp.MASP=ct.MASP AND
				YEAR(hd.NGHD)=2006
	)
GO

-- Câu 17
-- In ra danh sách các sản phẩm (MASP, TENSP)
-- do 'Trung Quốc' sản xuất không bán được trong năm 2006.

SELECT sp.MASP,sp.TENSP
	FROM SANPHAM sp
	WHERE NOT EXISTS
	(
		SELECT 1
		FROM CTHD ct
		JOIN HOADON hd ON ct.SOHD=hd.SOHD
		WHERE sp.MASP=ct.MASP AND
				YEAR(NGHD)=2006
	) AND
	NUOCSX=N'Trung Quốc'
GO

-- Câu 18
-- Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.

SELECT SOHD
	FROM CTHD ct
	JOIN SANPHAM sp ON ct.MASP=sp.MASP
	WHERE NUOCSX='Singapore'
	GROUP BY SOHD
	HAVING COUNT(DISTINCT sp.MASP)=
	(
		SELECT COUNT(*)
		FROM SANPHAM
		WHERE NUOCSX='Singapore'
	)
GO

-- Câu 19
-- Tìm số hóa đơn trong năm 2006 đã mua ít nhất
-- tất cả các sản phẩm do Singapore sản xuất.

SELECT ct.SOHD
	FROM CTHD ct
	JOIN HOADON hd ON ct.SOHD=hd.SOHD
	JOIN SANPHAM sp ON ct.MASP=sp.MASP
	WHERE YEAR(NGHD)=2006 AND
			NUOCSX='Singapore'
	GROUP BY ct.SOHD
	HAVING COUNT(DISTINCT sp.MASP)=
	(
		SELECT COUNT(*)
		FROM SANPHAM
		WHERE NUOCSX='Singapore'
	)
GO

-- Câu 20
-- Có bao nhiêu hóa đơn không phải của khách hàng
-- đăng ký thành viên mua?

SELECT COUNT(*) AS HOADON_KP_TV
	FROM HOADON
	WHERE MAKH IS NULL
GO

-- Câu 21
-- Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.

SELECT COUNT(DISTINCT MASP) AS SP_DUOCBAN_2006
	FROM CTHD ct
	JOIN HOADON hd ON ct.SOHD=hd.SOHD
	WHERE YEAR(NGHD)=2006
GO

-- Câu 22
-- Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu?

SELECT MAX(TRIGIA) AS GIA_CAO_NHAT,MIN(TRIGIA) AS GIA_THAP_NHAT
	FROM HOADON
GO

-- Câu 23
-- Trị giá trung bình của tất cả các hóa đơn được bán ra
-- trong năm 2006 là bao nhiêu?

SELECT AVG(TRIGIA) AS GIA_TB
	FROM HOADON
GO

-- Câu 24
-- Tính doanh thu bán hàng trong năm 2006.

SELECT SUM(TRIGIA) AS DOANHTHU_2006
	FROM HOADON
	WHERE YEAR(NGHD)=2006
GO

-- Câu 25
-- Tìm số hóa đơn có trị giá cao nhất trong năm 2006.

SELECT SOHD
	FROM HOADON
	WHERE YEAR(NGHD)=2006 AND
	TRIGIA=
	(
		SELECT MAX(TRIGIA)
		FROM HOADON
		WHERE YEAR(NGHD)=2006
	)
GO

-- Câu 26
-- Tìm họ tên khách hàng đã mua hóa đơn
-- có trị giá cao nhất trong năm 2006.

SELECT kh.MAKH,kh.HOTEN
	FROM KHACHHANG kh
	JOIN HOADON ct ON kh.MAKH=ct.MAKH
	WHERE YEAR(NGHD)=2006 AND
			TRIGIA=
			(
				SELECT MAX(TRIGIA)
				FROM HOADON
				WHERE YEAR(NGHD)=2006
			)
GO

-- Câu 27
-- In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.

SELECT TOP 3 MAKH,HOTEN,DOANHSO
	FROM KHACHHANG
	ORDER BY DOANHSO DESC
GO

-- Câu 28
-- In ra danh sách các sản phẩm (MASP, TENSP) có giá bán
-- bằng 1 trong 3 mức giá cao nhất.

SELECT MASP,TENSP,GIA
	FROM SANPHAM
	WHERE GIA IN
	(
		SELECT DISTINCT TOP 3 GIA
		FROM SANPHAM
		ORDER BY GIA DESC
	)
GO

-- Câu 29
-- In ra danh sách các sản phẩm (MASP, TENSP)
-- do 'Thai Lan' sản xuất có giá bằng 1 trong 3
-- mức giá cao nhất (của tất cả các sản phẩm).

SELECT MASP,TENSP,GIA
	FROM SANPHAM
	WHERE NUOCSX='Thai Lan' AND
			GIA IN
			(
				SELECT DISTINCT TOP 3 GIA
				FROM SANPHAM
				ORDER BY GIA DESC
			)
GO

-- Câu 30
-- In ra danh sách các sản phẩm (MASP, TENSP)
-- do 'Trung Quốc' sản xuất có giá bằng 1 trong 3
-- mức giá cao nhất (của sản phẩm do 'Trung Quốc' sản xuất).

SELECT MASP,TENSP,GIA
	FROM SANPHAM
	WHERE NUOCSX=N'Trung Quốc' AND
			GIA IN
			(
				SELECT DISTINCT TOP 3 GIA
				FROM SANPHAM
				WHERE NUOCSX=N'Trung Quốc'
				ORDER BY GIA
			)
GO

-- Câu 31
-- In ra danh sách 3 khách hàng có doanh số cao nhất
-- (sắp xếp theo kiểu xếp hạng).

WITH XepHang_KH AS
(
	SELECT MAKH,HOTEN,DOANHSO,
			DENSE_RANK() OVER (ORDER BY DOANHSO DESC) AS RankDoanhSo
	FROM KHACHHANG
)
SELECT *
	FROM XepHang_KH
	WHERE RankDoanhSo<=3
GO

-- Câu 32
-- Tính tổng số sản phẩm do 'Trung Quốc' sản xuất.

SELECT COUNT(*) AS TONGSP_TQ
	FROM SANPHAM
	WHERE NUOCSX=N'Trung Quốc'
GO

-- Câu 33
-- Tính tổng số sản phẩm của từng nước sản xuất.

SELECT NUOCSX,COUNT(*) AS TONGSP
	FROM SANPHAM
	GROUP BY NUOCSX
GO

-- Câu 34
-- Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất,
-- trung bình của các sản phẩm.

SELECT NUOCSX,
		MAX(GIA) AS GIA_CAONHAT,
		MIN(GIA) AS GIA_THAPNHAT,
		AVG(GIA) AS GIA_TB
	FROM SANPHAM
	GROUP BY NUOCSX
GO

-- Câu 35
-- Tính doanh thu bán hàng mỗi ngày.

SELECT NGHD,SUM(TRIGIA) AS DOANHTHUNGAY
	FROM HOADON
	GROUP BY NGHD
GO

-- Câu 36
-- Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.

SELECT ct.MASP,sp.TENSP,SUM(SL) AS TONG_SL_BAN
	FROM CTHD ct
	JOIN HOADON hd ON ct.SOHD=hd.SOHD
	JOIN SANPHAM sp ON ct.MASP=sp.MASP
	WHERE MONTH(NGHD)=10 AND YEAR(NGHD)=2006
	GROUP BY ct.MASP,sp.TENSP
GO

-- Câu 37
-- Tính doanh thu bán hàng của từng tháng trong năm 2006.

SELECT MONTH(NGHD) AS THANG,SUM(TRIGIA) AS DOANHTHU_THANG
	FROM HOADON
	WHERE YEAR(NGHD)=2006
	GROUP BY MONTH(NGHD)
GO

-- Câu 38
-- Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.

SELECT SOHD
	FROM CTHD
	GROUP BY SOHD
	HAVING COUNT(DISTINCT MASP)>=4
GO

-- Câu 39
-- Tìm hóa đơn có mua 3 sản phẩm do 'Viet Nam'
-- sản xuất (3 sản phẩm khác nhau).

SELECT SOHD
	FROM CTHD ct
	JOIN SANPHAM sp ON ct.MASP=sp.MASP
	WHERE NUOCSX='Viet Nam'
	GROUP BY SOHD
	HAVING COUNT(DISTINCT ct.MASP)=3
GO

-- Câu 40
-- Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.

WITH SoLanMua AS
(
	SELECT MAKH,COUNT(SOHD) AS SoLan
	FROM HOADON
	WHERE MAKH IS NOT NULL
	GROUP BY MAKH
)
SELECT kh.MAKH,kh.HOTEN,sl.SOLAN
	FROM KHACHHANG kh
	JOIN SoLanMua sl ON kh.MAKH=sl.MAKH
	WHERE sl.SoLan=
			(
				SELECT MAX(SoLan)
				FROM SoLanMua
			)
GO

-- Câu 41
-- Tháng mấy trong năm 2006, doanh số bán hàng cao nhất?

WITH DoanhThuTheoThang AS
(
	SELECT MONTH(NGHD) AS Thang,SUM(TRIGIA) AS TongDoanhThu
		FROM HOADON
		WHERE YEAR(NGHD)=2006
		GROUP BY MONTH(NGHD)
)
SELECT Thang,TongDoanhThu
	FROM DoanhThuTheoThang
	WHERE TongDoanhThu=
			(
				SELECT MAX(TongDoanhThu)
				FROM DoanhThuTheoThang
			)
GO

-- Câu 42
-- Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra
-- thấp nhất trong năm 2006.

WITH TongBan26 AS
(
	SELECT ct.MASP,SUM(SL) AS TongSL
		FROM CTHD ct
		JOIN HOADON hd ON ct.SOHD=hd.SOHD
		WHERE YEAR(hd.NGHD)=2006
		GROUP BY ct.MASP
)
SELECT sp.MASP,sp.TENSP,t.TongSL
	FROM SANPHAM sp
	JOIN TongBan26 t ON sp.MASP=t.MASP
	WHERE t.TongSL=
			(
				SELECT MIN(TongSL)
				FROM TongBan26
			)
GO

-- Câu 43
-- Mỗi nước sản xuất, tìm sản phẩm (MASP, TENSP)
-- có giá bán cao nhất.

WITH XepGiaTheoNuoc AS
(
	SELECT MASP,TENSP,NUOCSX,GIA,
			ROW_NUMBER() OVER
			(
				PARTITION BY NUOCSX
				ORDER BY GIA DESC
			) AS rn
	FROM SANPHAM
)
SELECT MASP,TENSP,NUOCSX,GIA
	FROM XepGiaTheoNuoc
	WHERE rn=1
GO

-- Câu 44
-- Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm
-- có giá bán khác nhau.

SELECT NUOCSX
	FROM SANPHAM
	GROUP BY NUOCSX
	HAVING COUNT(DISTINCT GIA)>=3
GO

-- Câu 45
-- Trong 10 khách hàng có doanh số cao nhất, 
-- tìm khách hàng có số lần mua hàng nhiều nhất.

WITH Top10DS AS
(
	SELECT TOP 10 MAKH,HOTEN
		FROM KHACHHANG
		ORDER BY DOANHSO DESC
),
DemLuotMua AS
(
	SELECT t.MAKH,t.HOTEN,COUNT(hd.SOHD) AS SoLanMua
		FROM Top10DS t
		JOIN HOADON hd ON t.MAKH=hd.MAKH
		GROUP BY t.MAKH,t.HOTEN
)
SELECT TOP 1 MAKH,HOTEN,SoLanMua
	FROM DemLuotMua
	ORDER BY SoLanMua DESC
GO