INSERT INTO PHONGBAN (MAPHG, TENPHG, TRGPHG, NGNC)
VALUES
    ('NC', N'Research', NULL, '2000-01-15'),
    ('DH', N'Executive', NULL, '2001-03-01'),
    ('KD', N'Business', NULL, '2002-05-10'),
    ('NS', N'Human Resources', NULL, '2001-07-20'),
    ('TC', N'Finance', NULL, '2000-09-05'),
    ('KT', N'Engineering', NULL, '2002-01-12'),
    ('MK', N'Marketing', NULL, '2003-02-18'),
    ('HC', N'Administration', NULL, '2000-04-01'),
    ('IT', N'Information Technology', NULL, '2002-08-25'),
    ('QA', N'Quality Assurance', NULL, '2003-06-11'),
    ('PR', N'Public Relations', NULL, '2004-01-09'),
    ('LG', N'Logistics', NULL, '2001-11-30'),
    ('DV', N'Customer Service', NULL, '2003-09-14'),
    ('PT', N'Product Development', NULL, '2002-04-22'),
    ('DT', N'Training', NULL, '2004-03-05'),
    ('PL', N'Legal', NULL, '2001-06-19'),
    ('KH', N'Planning', NULL, '2002-10-08'),
    ('VH', N'Operations', NULL, '2003-12-01'),
    ('DA', N'Project Management', NULL, '2004-05-17'),
    ('AT', N'Information Security', NULL, '2005-02-28');
GO


INSERT INTO NHANVIEN (MANV, HONV, TENLOT, TENNV, NGSINH, DCHI, PHAI, MLUONG, MA_NQL, PHONG)
VALUES
    ('001', N'Dinh', N'Ba', N'Tien', '1963-01-09', N'731 Tran Hung Dao, Ho Chi Minh City', N'Male', 3500000.00, NULL, 'NC'),
    ('002', N'Nguyen', N'Thanh', N'Tung', '1962-08-20', N'291 Ho Van Hue, Ho Chi Minh City', N'Male', 4000000.00, '001', 'NC'),
    ('003', N'Le', N'Thi', N'Nhan', '1961-07-12', N'22 Nguyen Van Cu, Hanoi', N'Female', 3200000.00, '002', 'DH'),
    ('004', N'Dinh', N'Quang', N'Huy', '1964-04-15', N'45 Le Loi, Ho Chi Minh City', N'Male', 2800000.00, '001', 'NC'),
    ('005', N'Tran', N'Minh', N'Khoi', '1988-11-03', N'18 Hai Ba Trung, Hanoi', N'Male', 2400000.00, '003', 'DH'),
    ('006', N'Pham', N'Thu', N'Ha', '1965-02-25', N'88 Vo Van Tan, Ho Chi Minh City', N'Female', 3600000.00, '002', 'KD'),
    ('007', N'Ngo', N'Van', N'An', '1975-06-14', N'102 Nguyen Hue, Da Nang', N'Male', 2100000.00, '006', 'KD'),
    ('008', N'Vu', N'Hong', N'Ngoc', '1960-12-10', N'56 Tran Phu, Ho Chi Minh City', N'Female', 2900000.00, '003', 'NS'),
    ('009', N'Hoang', N'Duc', N'Manh', '1982-09-19', N'77 Ly Thuong Kiet, Hanoi', N'Male', 1900000.00, '008', 'NS'),
    ('010', N'Dang', N'Kim', N'Chi', '1963-05-28', N'12 Phan Dinh Phung, Ho Chi Minh City', N'Female', 3800000.00, '002', 'TC'),
    ('011', N'Bui', N'Gia', N'Bao', '1990-03-17', N'30 Pasteur, Ho Chi Minh City', N'Male', 2200000.00, '010', 'TC'),
    ('012', N'Do', N'Thi', N'Mai', '1964-10-04', N'91 Cach Mang Thang 8, Hanoi', N'Female', 3300000.00, '003', 'KT'),
    ('013', N'Ly', N'Hoang', N'Nam', '1979-07-22', N'64 Dien Bien Phu, Da Nang', N'Male', 2600000.00, '012', 'KT'),
    ('014', N'Mai', N'Thanh', N'Lan', '1962-01-30', N'15 Nguyen Thi Minh Khai, Ho Chi Minh City', N'Female', 3100000.00, '006', 'MK'),
    ('015', N'Truong', N'Quoc', N'Viet', '1985-12-05', N'120 Hung Vuong, Can Tho', N'Male', 1800000.00, '014', 'MK'),
    ('016', N'Phan', N'Anh', N'Nguyet', '1965-08-11', N'204 Ba Thang Hai, Ho Chi Minh City', N'Female', 2700000.00, '008', 'HC'),
    ('017', N'Luu', N'Tuan', N'Kiet', '1992-04-29', N'39 Pham Ngu Lao, Hanoi', N'Male', 2300000.00, '012', 'IT'),
    ('018', N'Ho', N'Ngoc', N'Diep', '1961-11-16', N'83 Bui Vien, Ho Chi Minh City', N'Female', 3400000.00, '010', 'QA'),
    ('019', N'Duong', N'Minh', N'Tuan', '1977-06-02', N'51 Tran Hung Dao, Hue', N'Male', 2500000.00, '018', 'PR'),
    ('020', N'Ta', N'Thi', N'Huong', '1964-09-08', N'140 Le Duan, Da Nang', N'Female', 3700000.00, '001', 'PT');
GO


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


INSERT INTO DIADIEMPHG (MAPHG, DIADIEM)
VALUES
    ('NC', N'Hanoi'),
    ('NC', N'Da Nang'),
    ('DH', N'Ho Chi Minh City'),
    ('KD', N'Hanoi'),
    ('NS', N'Da Nang'),
    ('TC', N'Hanoi'),
    ('KT', N'Ho Chi Minh City'),
    ('MK', N'Da Nang'),
    ('HC', N'Hanoi'),
    ('IT', N'Ho Chi Minh City'),
    ('QA', N'Da Nang'),
    ('PR', N'Ho Chi Minh City'),
    ('LG', N'Can Tho'),
    ('DV', N'Ho Chi Minh City'),
    ('PT', N'Hanoi'),
    ('PL', N'Hanoi'),
    ('KH', N'Ho Chi Minh City'),
    ('VH', N'Da Nang'),
    ('DA', N'Hanoi'),
    ('AT', N'Hue');
GO


INSERT INTO DEAN (MADA, TENDA, DDIEM_DA, PHONG, NGBD_DA, NGKT_DA)
VALUES
    ('DA1', N'Computerization', N'Hanoi', 'NC', '2024-01-01', '2024-12-31'),
    ('DA2', N'Product X', N'Ho Chi Minh City', 'NC', '2024-02-01', '2024-11-30'),
    ('DA3', N'Training', N'Hanoi', 'DH', '2024-03-01', '2024-10-31'),
    ('DA4', N'Digital Transformation', N'Ho Chi Minh City', 'NC', '2024-01-15', '2024-12-15'),
    ('DA5', N'Warehouse Automation', N'Da Nang', 'KT', '2024-04-01', '2025-01-31'),
    ('DA6', N'Market Expansion', N'Ho Chi Minh City', 'KD', '2024-02-10', '2024-09-30'),
    ('DA7', N'HR Standardization', N'Hanoi', 'NS', '2024-05-01', '2024-11-15'),
    ('DA8', N'Budget Management', N'Ho Chi Minh City', 'TC', '2024-01-20', '2024-12-20'),
    ('DA9', N'Digital Brand', N'Da Nang', 'MK', '2024-03-15', '2024-10-20'),
    ('DA0', N'Document Digitization', N'Hanoi', 'HC', '2024-06-01', '2024-12-31'),
    ('D11', N'Core Network Upgrade', N'Ho Chi Minh City', 'IT', '2024-02-20', '2024-08-31'),
    ('D12', N'Automated Testing', N'Da Nang', 'QA', '2024-04-10', '2024-11-30'),
    ('D13', N'Internal Communications', N'Ho Chi Minh City', 'PR', '2024-05-05', '2024-10-15'),
    ('D14', N'Supply Chain Optimization', N'Can Tho', 'LG', '2024-01-10', '2024-12-10'),
    ('D15', N'Smart Call Center', N'Ho Chi Minh City', 'DV', '2024-03-25', '2024-09-25'),
    ('D16', N'Applied AI Research', N'Hanoi', 'PT', '2024-06-15', '2025-06-15'),
    ('D17', N'Legal Compliance', N'Hanoi', 'PL', '2024-02-05', '2024-07-31'),
    ('D18', N'2025 Planning', N'Ho Chi Minh City', 'KH', '2024-07-01', '2024-12-31'),
    ('D19', N'Operations Monitoring', N'Da Nang', 'VH', '2024-04-18', '2024-11-18'),
    ('D20', N'Data Security', N'Hue', 'AT', '2024-05-12', '2024-12-25');
GO


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


INSERT INTO THANNHAN (MANV, MATN, HOTN, TENTN, PHAI, NGAYSINH, QUANHE)
VALUES
    ('001', 'TN1', N'Dinh', N'Minh Anh', N'Female', '2015-05-10', N'Child'),
    ('001', 'TN2', N'Dinh', N'Gia Huy', N'Male', '2018-09-21', N'Child'),
    ('001', 'TN3', N'Le', N'Thi Hoa', N'Female', '1965-03-14', N'Wife'),
    ('002', 'TN1', N'Nguyen', N'Bao Vy', N'Female', '2012-07-04', N'Child'),
    ('002', 'TN2', N'Nguyen', N'Anh Khoa', N'Male', '2016-11-19', N'Child'),
    ('002', 'TN3', N'Tran', N'Thi Mai', N'Female', '1964-08-22', N'Wife'),
    ('003', 'TN1', N'Le', N'Quang Dung', N'Male', '2010-02-11', N'Child'),
    ('004', 'TN1', N'Dinh', N'Thao Vy', N'Female', '2019-06-30', N'Child'),
    ('005', 'TN1', N'Tran', N'Van Hung', N'Male', '1958-12-01', N'Father'),
    ('006', 'TN1', N'Pham', N'Ngoc Han', N'Female', '2014-04-17', N'Child'),
    ('007', 'TN1', N'Ngo', N'Khanh Linh', N'Female', '2017-01-25', N'Child'),
    ('008', 'TN1', N'Vu', N'Minh Khang', N'Male', '2011-08-08', N'Child'),
    ('008', 'TN2', N'Vu', N'Thi Lan', N'Female', '1955-10-03', N'Mother'),
    ('008', 'TN3', N'Nguyen', N'Van Duc', N'Male', '1959-07-12', N'Husband'),
    ('010', 'TN1', N'Dang', N'Gia Linh', N'Female', '2013-09-15', N'Child'),
    ('012', 'TN1', N'Do', N'Tuan Anh', N'Male', '2016-05-02', N'Child'),
    ('014', 'TN1', N'Mai', N'Phuong Thao', N'Female', '2015-12-20', N'Child'),
    ('016', 'TN1', N'Phan', N'Hoang Phuc', N'Male', '2018-03-18', N'Child'),
    ('018', 'TN1', N'Ho', N'Gia Han', N'Female', '2014-07-27', N'Child'),
    ('020', 'TN1', N'Ta', N'Minh Quan', N'Male', '2017-10-12', N'Child');
GO