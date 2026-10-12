# QLHangHoa - Product Sales Management System

## Bài 4 - Cơ sở dữ liệu Quản lý hàng hóa

---

## 1. Mô tả cơ sở dữ liệu

### KHACHHANG

`KHACHHANG (MAKH, HOTEN, DCHI, SODT, NGSINH, DOANHSO, NGDK)`

Lưu trữ thông tin khách hàng thành viên, bao gồm:

- Mã khách hàng
- Họ tên
- Địa chỉ
- Số điện thoại
- Ngày sinh
- Doanh số
- Ngày đăng ký thành viên

---

### NHANVIEN

`NHANVIEN (MANV, HOTEN, NGVL, SODT)`

Lưu trữ thông tin nhân viên bán hàng:

- Mã nhân viên
- Họ tên
- Ngày vào làm
- Số điện thoại

---

### SANPHAM

`SANPHAM (MASP, TENSP, DVT, NUOCSX, GIA)`

Lưu trữ thông tin sản phẩm:

- Mã sản phẩm
- Tên sản phẩm
- Đơn vị tính
- Nước sản xuất
- Giá bán

---

### HOADON

`HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA)`

Lưu trữ thông tin hóa đơn:

- Số hóa đơn
- Ngày mua hàng
- Mã khách hàng
- Mã nhân viên
- Trị giá hóa đơn

---

### CTHD

`CTHD (SOHD, MASP, SL)`

Lưu trữ chi tiết sản phẩm trong từng hóa đơn:

- Số hóa đơn
- Mã sản phẩm
- Số lượng

---

## 2. Yêu cầu thiết kế và ràng buộc

1. Tạo các quan hệ và khai báo khóa chính, khóa ngoại.
2. Thêm thuộc tính `GHICHU` kiểu `varchar(20)` vào quan hệ `SANPHAM`.
3. Thêm thuộc tính `LOAIKH` kiểu `tinyint` vào quan hệ `KHACHHANG`.
4. Sửa kiểu dữ liệu của `GHICHU` thành `varchar(100)`.
5. Xóa thuộc tính `GHICHU` khỏi `SANPHAM`.
6. Cài đặt thuộc tính `LOAIKH` để lưu các giá trị như `'Vang lai'`, `'Thuong xuyen'`, `'Vip'`, ...
7. Đơn vị tính của sản phẩm chỉ được phép là:
- `Cây`
- `hop`
- `cai`
- `quyen`
- `chuc`
8. Giá bán của sản phẩm phải từ 500 đồng trở lên.
9. Mỗi hóa đơn phải có ít nhất một sản phẩm.
10. Ngày đăng ký thành viên phải lớn hơn ngày sinh của khách hàng.
11. Ngày mua hàng của khách hàng thành viên phải lớn hơn hoặc bằng ngày đăng ký.
12. Ngày bán hàng của nhân viên phải lớn hơn hoặc bằng ngày vào làm.
13. Mỗi hóa đơn phải có ít nhất một chi tiết hóa đơn.
14. Trị giá hóa đơn bằng tổng `(số lượng × đơn giá)` của các chi tiết.
15. Doanh số khách hàng bằng tổng trị giá các hóa đơn mà khách hàng thành viên đã mua.

---

## 3. Dữ liệu mẫu

Đề bài cung cấp dữ liệu mẫu cho các quan hệ:

- `NHANVIEN`
- `KHACHHANG`
- `SANPHAM`
- `HOADON`
- `CTHD`

Dữ liệu mẫu được lưu và nhập trong các file SQL riêng của project.

---

## 4. Yêu cầu DML

Sử dụng CSDL quản lý hàng hóa để thực hiện các yêu cầu sau:

1. In danh sách các sản phẩm `(MASP, TENSP)` do `Trung Quốc` sản xuất.
2. In danh sách các sản phẩm `(MASP, TENSP)` có đơn vị tính là `Cây`, `Quyển`.
3. In danh sách các sản phẩm `(MASP, TENSP)` có mã sản phẩm bắt đầu bằng `B` và kết thúc bằng `01`.
4. In danh sách các sản phẩm `(MASP, TENSP)` do `Trung Quốc` sản xuất có giá từ 30.000 đến 40.000.
5. In danh sách các sản phẩm `(MASP, TENSP)` do `Trung Quốc` hoặc `Thái Lan` sản xuất có giá từ 30.000 đến 40.000.
6. In số hóa đơn và trị giá hóa đơn bán ra trong ngày 1/1/2007 và 2/1/2007.
7. In số hóa đơn và trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày tăng dần và trị giá giảm dần.
8. In danh sách khách hàng `(MAKH, HOTEN)` đã mua hàng trong ngày 1/1/2007.
9. In số hóa đơn và trị giá các hóa đơn do nhân viên `Nguyen Van B` lập trong ngày 28/10/2006.
10. In danh sách các sản phẩm `(MASP, TENSP)` được khách hàng `Nguyen Van A` mua trong tháng 10/2006.
11. Tìm các số hóa đơn đã mua sản phẩm có mã `BB01` hoặc `BB02`.
12. Tìm các số hóa đơn đã mua sản phẩm có mã `BB01` hoặc `BB02`, mỗi sản phẩm có số lượng từ 10 đến 20.
13. Tìm các số hóa đơn mua cùng lúc hai sản phẩm `BB01` và `BB02`, mỗi sản phẩm có số lượng từ 10 đến 20.
14. In danh sách các sản phẩm do `Trung Quốc` sản xuất hoặc được bán ra trong ngày 1/1/2007.
15. In danh sách các sản phẩm không bán được.
16. In danh sách các sản phẩm không bán được trong năm 2006.
17. In danh sách các sản phẩm do `Trung Quốc` sản xuất không bán được trong năm 2006.
18. Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
19. Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
20. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006?
22. Cho biết trị giá hóa đơn cao nhất và thấp nhất.
23. Tính trị giá trung bình của tất cả hóa đơn bán ra trong năm 2006.
24. Tính doanh thu bán hàng trong năm 2006.
25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
27. In danh sách 3 khách hàng `(MAKH, HOTEN)` có doanh số cao nhất.
28. In danh sách sản phẩm có giá bán bằng một trong 3 mức giá cao nhất.
29. In danh sách sản phẩm do `Thai Lan` sản xuất có giá bằng một trong 3 mức giá cao nhất của tất cả sản phẩm.
30. In danh sách sản phẩm do `Trung Quốc` sản xuất có giá bằng một trong 3 mức giá cao nhất của các sản phẩm Trung Quốc.
31. In danh sách 3 khách hàng có doanh số cao nhất theo kiểu xếp hạng.
32. Tính tổng số sản phẩm do `Trung Quốc` sản xuất.
33. Tính tổng số sản phẩm của từng nước sản xuất.
34. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất và trung bình.
35. Tính doanh thu bán hàng mỗi ngày.
36. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
37. Tính doanh thu bán hàng của từng tháng trong năm 2006.
38. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
39. Tìm hóa đơn có mua 3 sản phẩm do `Viet Nam` sản xuất, với 3 sản phẩm khác nhau.
40. Tìm khách hàng `(MAKH, HOTEN)` có số lần mua hàng nhiều nhất.
41. Tìm tháng có doanh số bán hàng cao nhất trong năm 2006.
42. Tìm sản phẩm có tổng số lượng bán ra thấp nhất trong năm 2006.
43. Với mỗi nước sản xuất, tìm sản phẩm có giá bán cao nhất.
44. Tìm nước sản xuất có ít nhất 3 sản phẩm với giá bán khác nhau.
45. Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.