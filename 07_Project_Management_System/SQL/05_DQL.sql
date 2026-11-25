-- Question 1
-- Find employees (MANV, HONV, TENLOT, TENNV)
-- working in department 'NC'.

SELECT
    MANV,
    HONV,
    TENLOT,
    TENNV
FROM NHANVIEN
WHERE PHONG = 'NC';
GO


-- Question 2
-- Find employees (MANV, HONV, TENLOT, TENNV, PHAI)
-- with a salary greater than 2,000,000.

SELECT
    MANV,
    HONV,
    TENLOT,
    TENNV,
    PHAI
FROM NHANVIEN
WHERE MLUONG > 2000000;
GO


-- Question 3
-- Find employee full names and the department names they
-- belong to with a salary from 2,000,000 to 3,000,000.

SELECT
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    pb.TENPHG
FROM NHANVIEN nv
INNER JOIN PHONGBAN pb
    ON pb.MAPHG = nv.PHONG
WHERE nv.MLUONG BETWEEN 2000000 AND 3000000;
GO


-- Question 4
-- Find employees with a salary greater than 2,500,000 in department NC
-- or employees with a salary greater than 3,000,000 in department DH.

SELECT
    MANV,
    CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_NV
FROM NHANVIEN
WHERE (MLUONG > 2500000 AND PHONG = 'NC')
    OR (MLUONG > 3000000 AND PHONG = 'DH');
GO


-- Question 5
-- List the full names of employees in 'Tp HCM'.

SELECT CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_NV
FROM NHANVIEN
WHERE DCHI LIKE N'%Tp HCM%';
GO


-- Question 6
-- List the full names of employees
-- whose last name starts with the character 'N'.

SELECT CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_NV
FROM NHANVIEN
WHERE HONV LIKE N'N%';
GO


-- Question 7
-- List the birth date and address of employee 'Đinh Bá Tiến'.

SELECT
    NGSINH,
    DCHI
FROM NHANVIEN
WHERE CONCAT_WS(' ',HONV,TENLOT,TENNV) = N'Đinh Bá Tiến';
GO


-- Question 8
-- List employees whose birth year
-- is between 1960 and 1965.

SELECT CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_NV
FROM NHANVIEN
WHERE YEAR(NGSINH) BETWEEN 1960 AND 1965;
GO


-- Question 9
-- List employees and their ages.

SELECT
    CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_NV,
    DATEDIFF(YEAR,NGSINH,GETDATE()) AS TUOI_NV
FROM NHANVIEN;
GO


-- Question 10
-- List dependents under 18 years old
-- of employees with ID '001'.

SELECT
    CONCAT_WS(' ',HOTN,TENTN) AS HOTEN_THANNHAN,
    MANV
FROM THANNHAN
WHERE DATEDIFF(YEAR,NGAYSINH,GETDATE()) < 18
    AND MANV = '001';
GO


-- Question 11
-- List all female employees over 30 years old.

SELECT CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_NV
FROM NHANVIEN
WHERE PHAI = N'Nữ'
    AND DATEDIFF(YEAR,NGSINH,GETDATE()) > 30;
GO


-- Question 12
-- For each department, list the department name
-- and department locations.

SELECT
    pb.TENPHG,
    ddp.DIADIEM
FROM PHONGBAN pb
INNER JOIN DIADIEMPHG ddp
    ON ddp.MAPHG = pb.MAPHG;
GO


-- Question 13
-- Find the names of department managers for each department.

SELECT DISTINCT
    pb.TENPHG,
    CONCAT_WS(' ',HONV,TENLOT,TENNV) AS HOTEN_TRUONGPHONG
FROM PHONGBAN pb
INNER JOIN NHANVIEN nv
    ON nv.MANV = pb.TRGPHG;
GO


-- Question 14
-- Find TENDA, MADA, DDIEM_DA, TENPHG, MAPHG, TRPHG, NGNC.

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


-- Question 15
-- Find the names and addresses of all employees
-- in the 'Nghiên cứu' department.

SELECT
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    nv.DCHI
FROM NHANVIEN nv
INNER JOIN PHONGBAN pb
    ON pb.MAPHG = nv.PHONG
WHERE pb.TENPHG = N'Nghiên cứu';
GO


-- Question 16
-- Find the names of female employees and their dependents' names.

SELECT
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    CONCAT_WS(' ',tn.HOTN,tn.TENTN) AS HOTEN_THANNHAN
FROM NHANVIEN nv
INNER JOIN THANNHAN tn
    ON tn.MANV = nv.MANV
WHERE nv.PHAI = N'Nữ';
GO


-- Question 17
-- Find the IDs and names of employees in the 'Nghiên Cứu' department
-- participating in project 'Tin Học Hóa' working
-- 20 hours/week.

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


-- Question 18
-- For every project in 'Hà Nội', list project IDs (MADA),
-- and the name of the department controlling the project.

SELECT
    d.MADA,
    pb.TENPHG
FROM DEAN d
INNER JOIN PHONGBAN pb
    ON pb.MAPHG = d.PHONG
WHERE d.DDIEM_DA = N'Hà Nội';
GO


-- Question 19
-- For each project in 'Hà Nội', list the project name,
-- department name, full name and start date as manager of the manager
-- of the department controlling that project.

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


-- Question 20
-- For each project in 'Hà Nội', list the department name (PHONG),
-- manager full name (HONV, TENLOT, TENNV)
-- as well as address (DCHI) and birth date (NGSINH) of that manager.

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


-- Question 21
-- For each employee, list the employee's full name
-- and their direct supervisor's full name.

SELECT
    CONCAT_WS(' ',nv1.HONV,nv1.TENLOT,nv1.TENNV) AS HOTEN_NV,
    CONCAT_WS(' ',nv2.HONV,nv2.TENLOT,nv2.TENNV) AS HOTEN_NQUANLY
FROM NHANVIEN nv1
LEFT JOIN NHANVIEN nv2
    ON nv2.MANV = nv1.MA_NQL;
GO


-- Question 22
-- For each employee, list the employee's full name and the full name
-- of the manager of the department the employee works in.

SELECT
    CONCAT_WS(' ',nv1.HONV,nv1.TENLOT,nv1.TENNV) AS HOTEN_NV,
    CONCAT_WS(' ',nv2.HONV,nv2.TENLOT,nv2.TENNV) AS HOTEN_TRGPHG
FROM NHANVIEN nv1
LEFT JOIN PHONGBAN pb
    ON pb.MAPHG = nv1.PHONG
LEFT JOIN NHANVIEN nv2
    ON nv2.MANV = pb.TRGPHG;
GO


-- Question 23
-- List employee full names (HONV, TENLOT, TENNV)
-- and the names of projects they participate in, if any.

SELECT
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    d.TENDA
FROM NHANVIEN nv
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
INNER JOIN DEAN d
    ON d.MADA = pc.MADA;
GO


-- Question 24
-- List the names of projects that employee 'Đinh Bá Tiến'
-- has participated in.

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


-- Question 25
-- List the number of projects in the company.

SELECT COUNT(MADA) AS SL_DEAN
FROM DEAN;
GO


-- Question 26
-- List the number of projects controlled by the 'Nghiên Cứu' department.

SELECT COUNT(d.MADA) AS SL_DEAN
FROM DEAN d
INNER JOIN PHONGBAN pb
    ON pb.MAPHG = d.PHONG
WHERE pb.TENPHG = N'Nghiên Cứu';
GO


-- Question 27
-- List the average salary of all female employees.

SELECT AVG(MLUONG) AS LUONG_TB
FROM NHANVIEN
WHERE PHAI = N'Nữ';
GO


-- Question 28
-- List the number of dependents of employee 'Đinh Bá Tiến'.

SELECT COUNT(tn.TENTN) AS SO_THAN_NHAN
FROM THANNHAN tn
INNER JOIN NHANVIEN nv
    ON nv.MANV = tn.MANV
WHERE CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) = N'Đinh Bá Tiến';
GO


-- Question 29
-- For each project, list the project name (TENDA)
-- and the total weekly working hours
-- of all employees participating in that project.

SELECT
    d.TENDA,
    SUM(pc.THOIGIAN) AS TONGSOGIO_LV
FROM DEAN d
INNER JOIN PHANCONG pc
    ON pc.MADA = d.MADA
GROUP BY
    d.MADA,
    d.TENDA;
GO


-- Question 30
-- For each project, list how many employees participate
-- in that project.

SELECT
    d.MADA,
    d.TENDA,
    COUNT(DISTINCT pc.MANV) AS SL_NV_THAMGIA
FROM DEAN d
INNER JOIN PHANCONG pc
    ON pc.MADA = d.MADA
GROUP BY
    d.MADA,
    d.TENDA;
GO


-- Question 31
-- For each project, list the project name and the number of tasks
-- in this project.

SELECT
    d.TENDA,
    COUNT(DISTINCT pc.MANV) AS SL_CONGVIEC
FROM DEAN d
INNER JOIN PHANCONG pc
    ON pc.MADA = d.MADA
GROUP BY
    d.MADA,
    d.TENDA;
GO


-- Question 32
-- For each task in the project named 'Đào Tạo',
-- list the number of assigned employees.

SELECT
    d.MADA,
    d.TENDA,
    COUNT(DISTINCT pc.MANV) AS SL_NV_DUOCPC
FROM DEAN d
INNER JOIN PHANCONG pc
    ON pc.MADA = d.MADA
WHERE d.TENDA = N'Đào Tạo'
GROUP BY
    d.MADA,
    d.TENDA;
GO


-- Question 33
-- For each employee, list the employee's full name
-- and how many dependents that employee has.

SELECT
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    COUNT(DISTINCT tn.TENTN) AS TN_CUANV
FROM NHANVIEN nv
LEFT JOIN THANNHAN tn
    ON tn.MANV = nv.MANV
GROUP BY
    nv.MANV,
    nv.HONV,
    nv.TENLOT,
    nv.TENNV;
GO


-- Question 34
-- For each employee, list the number of employees
-- they directly supervise.

SELECT
    nv_ql.MANV,
    CONCAT_WS(' ', nv_ql.HONV, nv_ql.TENLOT, nv_ql.TENNV) AS HOTEN_NQL,
    COUNT(nv_duoi.MANV) AS SL_NV_DUOC_QL
FROM NHANVIEN nv_ql
LEFT JOIN NHANVIEN nv_duoi
    ON nv_duoi.MA_NQL = nv_ql.MANV
GROUP BY
    nv_ql.MANV,
    nv_ql.HONV,
    nv_ql.TENLOT,
    nv_ql.TENNV;
GO


-- Question 35
-- For each department, list the department name (TENPHG)
-- and the average salary of employees working
-- for that department.

SELECT
    pb.TENPHG,
    AVG(nv.MLUONG) AS LUONG_TB
FROM PHONGBAN pb
INNER JOIN NHANVIEN nv
    ON nv.PHONG = pb.MAPHG
GROUP BY
    pb.MAPHG,
    pb.TENPHG;
GO


-- Question 36
-- For departments with an average salary greater than 30,000,
-- list the department name and the number of employees
-- in that department.

SELECT
    pb.TENPHG,
    COUNT(nv.MANV) AS SL_NHANVIEN
FROM PHONGBAN pb
INNER JOIN NHANVIEN nv
    ON nv.PHONG = pb.MAPHG
GROUP BY
    pb.MAPHG,
    pb.TENPHG
HAVING AVG(nv.MLUONG) > 30000;
GO


-- Question 37
-- For each department, list the department name
-- and the number of projects that department controls.

SELECT
    pb.TENPHG,
    COUNT(d.MADA) AS SL_DEAN
FROM PHONGBAN pb
LEFT JOIN DEAN d
    ON d.PHONG = pb.MAPHG
GROUP BY
    pb.MAPHG,
    pb.TENPHG;
GO


-- Question 38
-- For each department, list the department name,
-- manager's full name
-- and the number of projects that department controls.

SELECT
    pb.TENPHG,
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_TRGPHG,
    COUNT(d.MADA) AS SL_DA
FROM PHONGBAN pb
LEFT JOIN NHANVIEN nv
    ON nv.MANV = pb.TRGPHG
LEFT JOIN DEAN d
    ON d.PHONG = pb.MAPHG
GROUP BY
    pb.MAPHG,
    pb.TENPHG,
    nv.MANV,
    nv.HONV,
    nv.TENLOT,
    nv.TENNV;
GO


-- Question 39
-- List the number of projects taking place at each location.

SELECT
    DDIEM_DA,
    COUNT(MADA) AS SODEAN
FROM DEAN
GROUP BY DDIEM_DA;
GO


-- Question 40
-- List projects (MADA) that have: an employee with last name
-- (HONV) 'Dinh' or a department manager controlling the project
-- with last name (HONV) 'Dinh'.

SELECT DISTINCT d.MADA
FROM DEAN d
LEFT JOIN PHANCONG pc
    ON pc.MADA = d.MADA
INNER JOIN NHANVIEN nv_pc
    ON nv_pc.MANV = pc.MANV
LEFT JOIN PHONGBAN pb
    ON pb.MAPHG = d.PHONG
LEFT JOIN NHANVIEN nv_tp
    ON nv_tp.MANV = pb.TRGPHG
WHERE nv_pc.HONV = N'Đinh'
    OR nv_tp.HONV = N'Đinh';
GO


-- Question 41
-- List employees (HONV, TENLOT, TENNV)
-- with more than 2 dependents.

SELECT
    nv.HONV,
    nv.TENLOT,
    nv.TENNV
FROM NHANVIEN nv
INNER JOIN THANNHAN tn
    ON tn.MANV = nv.MANV
GROUP BY
    nv.MANV,
    nv.HONV,
    nv.TENLOT,
    nv.TENNV
HAVING COUNT(tn.TENTN) > 2;
GO


-- Question 42
-- List employees (HONV, TENLOT, TENNV)
-- who have no dependents.

SELECT
    nv.HONV,
    nv.TENLOT,
    nv.TENNV
FROM NHANVIEN nv
LEFT JOIN THANNHAN tn
    ON tn.MANV = nv.MANV
GROUP BY
    nv.MANV,
    nv.HONV,
    nv.TENLOT,
    nv.TENNV
HAVING COUNT(tn.TENTN) = 0;
GO


-- Question 43
-- List department managers (HONV, TENLOT, TENNV)
-- who have at least one dependent.

SELECT
    nv.HONV,
    nv.TENLOT,
    nv.TENNV
FROM NHANVIEN nv
INNER JOIN PHONGBAN pb
    ON pb.TRGPHG = nv.MANV
INNER JOIN THANNHAN tn
    ON tn.MANV = nv.MANV
GROUP BY
    nv.MANV,
    nv.HONV,
    nv.TENLOT,
    nv.TENNV
HAVING COUNT(tn.TENTN) >= 1;
GO


-- Question 44
-- Find the last name (HONV) of department managers who have no family/dependents.

SELECT DISTINCT nv.HONV
FROM NHANVIEN nv
INNER JOIN PHONGBAN pb
    ON pb.TRGPHG = nv.MANV
WHERE NOT EXISTS
(
    SELECT 1
    FROM THANNHAN tn
    WHERE tn.MANV = nv.MANV
);
GO


-- Question 45
-- List employee full names (HONV, TENLOT, TENNV)
-- with a salary higher than the average salary
-- of the 'Nghiên cứu' department.

SELECT CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV
FROM NHANVIEN nv
WHERE nv.MLUONG >
(
    SELECT (nv2.MLUONG)
    FROM NHANVIEN nv2
    INNER JOIN PHONGBAN pb
        ON pb.MAPHG = nv2.PHONG
    WHERE pb.TENPHG = N'Nghiên cứu'
);
GO


-- Question 46
-- List the department name and manager full name
-- of the department with the most employees.

SELECT TOP 1
    pb.TENPHG,
    CONCAT_WS(' ',nv_tp.HONV,nv_tp.TENLOT,nv_tp.TENNV) AS HOTEN_TRGPHG
FROM PHONGBAN pb
INNER JOIN NHANVIEN nv
    ON nv.PHONG = pb.MAPHG
INNER JOIN NHANVIEN nv_tp
    ON nv_tp.MANV = pb.TRGPHG
GROUP BY
    pb.MAPHG,
    pb.TENPHG,
    nv_tp.HONV,
    nv_tp.TENLOT,
    nv_tp.TENNV
ORDER BY COUNT(nv.MANV) DESC;
GO


-- Question 47
-- Find full names (HONV, TENLOT, TENNV) and addresses (DCHI)
-- of employees working on a project in 'TP HCM'
-- whose own department is not located in
-- 'TP HCM'.

SELECT DISTINCT
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    nv.DCHI
FROM NHANVIEN nv
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
INNER JOIN DEAN d
    ON d.MADA = pc.MADA
WHERE d.DDIEM_DA LIKE N'%Tp HCM%'
    AND NOT EXISTS
    (
        SELECT 1
        FROM DIADIEMPHG dd
        WHERE dd.MAPHG = nv.PHONG
            AND dd.DIADIEM LIKE N'%Tp HCM%'
    );
GO


-- Question 48
-- Generalizing question 47, find full names and addresses of employees
-- working on a project in a city whose own department
-- is not located in that city.

SELECT DISTINCT
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV,
    nv.DCHI
FROM NHANVIEN nv
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
INNER JOIN DEAN d
    ON d.MADA = pc.MADA
WHERE d.DDIEM_DA IS NOT NULL
    AND NOT EXISTS
    (
        SELECT 1
        FROM DIADIEMPHG dd
        WHERE dd.MAPHG = nv.PHONG
            AND dd.DIADIEM = d.DDIEM_DA
    );
GO


-- Question 49
-- List employees (HONV, TENLOT, TENNV)
-- working on every project of the company.

SELECT
    nv.MANV,
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV
FROM NHANVIEN nv
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
WHERE (SELECT COUNT(*) FROM DEAN) > 0
GROUP BY
    nv.MANV,
    nv.HONV,
    nv.TENLOT,
    nv.TENNV
HAVING COUNT(DISTINCT pc.MADA) =
(
    SELECT COUNT(*)
    FROM DEAN
);
GO


-- Question 50
-- List employees (HONV, TENLOT, TENNV)
-- assigned to all projects controlled by department
-- 'Nghien cuu'.

SELECT
    nv.MANV,
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV
FROM NHANVIEN nv
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
INNER JOIN DEAN d
    ON d.MADA = pc.MADA
INNER JOIN PHONGBAN pb
    ON pb.MAPHG = d.PHONG
WHERE pb.TENPHG = N'Nghiên cứu'
GROUP BY
    nv.MANV,
    nv.HONV,
    nv.TENLOT,
    nv.TENNV
HAVING COUNT(DISTINCT pc.MADA) =
(
    SELECT COUNT(*)
    FROM DEAN d2
    INNER JOIN PHONGBAN pb2
        ON pb2.MAPHG = d2.PHONG
    WHERE pb2.TENPHG = N'Nghiên cứu'
);
GO


-- Question 51
-- Find full names of employees participating in all projects
-- controlled by the department the employee belongs to.

SELECT
    nv.MANV,
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV
FROM NHANVIEN nv
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
INNER JOIN DEAN d
    ON d.MADA = pc.MADA
WHERE d.PHONG = nv.PHONG
GROUP BY
    nv.MANV,
    nv.HONV,
    nv.TENLOT,
    nv.TENNV,
    nv.PHONG
HAVING COUNT(DISTINCT pc.MADA) =
(
    SELECT COUNT(*)
    FROM DEAN d2
    WHERE d2.PHONG = nv.PHONG
);
GO


-- Question 52
-- Find employees (HONV, TENLOT, TENNV)
-- assigned to all projects that employee 'Đinh Bá Tiến'
-- works on.

SELECT
    nv.MANV,
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV
FROM NHANVIEN nv
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
WHERE pc.MADA IN
(
    SELECT pc2.MADA
    FROM PHANCONG pc2
    INNER JOIN NHANVIEN nv2
        ON nv2.MANV = pc2.MANV
    WHERE CONCAT_WS(' ',nv2.HONV,nv2.TENLOT,nv2.TENNV) = N'Đinh Bá Tiến'
)
GROUP BY
    nv.MANV,
    nv.HONV,
    nv.TENLOT,
    nv.TENNV
HAVING COUNT(DISTINCT pc.MADA) =
(
    SELECT COUNT(DISTINCT pc3.MADA)
    FROM PHANCONG pc3
    INNER JOIN NHANVIEN nv3
        ON nv3.MANV = pc3.MANV
    WHERE CONCAT_WS(' ',nv3.HONV,nv3.TENLOT,nv3.TENNV) = N'Đinh Bá Tiến'
);
GO


-- Question 53
-- List employees assigned to all
-- tasks in project 'Sản phẩm X'.

SELECT
    nv.MANV,
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV
FROM NHANVIEN nv
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
INNER JOIN DEAN d
    ON d.MADA = pc.MADA
WHERE d.TENDA = N'Sản phẩm X'
GROUP BY
    nv.MANV,
    nv.HONV,
    nv.TENLOT,
    nv.TENNV
HAVING COUNT(*) =
(
    SELECT COUNT(*)
    FROM PHANCONG pc2
    INNER JOIN DEAN d2
        ON d2.MADA = pc2.MADA
    WHERE d2.TENDA = N'Sản phẩm X'
);
GO


-- Question 54
-- List employees participating in
-- all projects in TP HCM.

SELECT
    nv.MANV,
    CONCAT_WS(' ',nv.HONV,nv.TENLOT,nv.TENNV) AS HOTEN_NV
FROM NHANVIEN nv
INNER JOIN PHANCONG pc
    ON pc.MANV = nv.MANV
INNER JOIN DEAN d
    ON d.MADA = pc.MADA
WHERE d.DDIEM_DA LIKE N'%Tp HCM%'
GROUP BY
    nv.MANV,
    nv.HONV,
    nv.TENLOT,
    nv.TENNV
HAVING COUNT(DISTINCT pc.MADA) =
(
    SELECT COUNT(*)
    FROM DEAN d2
    WHERE d2.DDIEM_DA LIKE N'%Tp HCM%'
);
GO


-- Question 55
-- List departments controlling all projects in TP HCM.

SELECT
    pb.MAPHG,
    pb.TENPHG
FROM PHONGBAN pb
INNER JOIN DEAN d
    ON d.PHONG = pb.MAPHG
WHERE d.DDIEM_DA LIKE N'%Tp HCM%'
GROUP BY
    pb.MAPHG,
    pb.TENPHG
HAVING COUNT(DISTINCT d.MADA) =
(
    SELECT COUNT(*)
    FROM DEAN d2
    WHERE d2.DDIEM_DA LIKE N'%Tp HCM%'
);
GO