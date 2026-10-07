# QLBongDa - Football Management System

## Bài 1. Cơ sở dữ liệu về Quản lý giải bóng đá (QLBongDa) 

---

# Phần I - Xây dựng cơ sở dữ liệu QLBongDa

## 1. Mô tả cơ sở dữ liệu

Cơ sở dữ liệu **QLBongDa** dùng để quản lý thông tin về một giải bóng đá, bao gồm quốc gia, sân vận động, tỉnh/thành phố, câu lạc bộ, cầu thủ, huấn luyện viên, trận đấu và bảng xếp hạng.

---

### 1.1. Bảng CAUTHU

```sql
CAUTHU(
    MACT,
    HOTEN,
    VITRI,
    NGAYSINH,
    DIACHI,
    MACLB,
    MAQG,
    SO
)
```

Mỗi cầu thủ có:

- Mã số duy nhất: MACT
- Họ tên: HOTEN
- Ngày sinh: NGAYSINH
- Địa chỉ: DIACHI
- Câu lạc bộ đang thi đấu: MACLB
- Quốc gia: MAQG
- Vị trí thi đấu: VITRI
- Số áo: SO

Các vị trí thi đấu được phép:

- Thủ môn
- Tiền đạo
- Tiền vệ
- Trung vệ
- Hậu vệ

Ràng buộc:

Cầu thủ thuộc cùng một câu lạc bộ phải có số áo khác nhau.

---

### 1.2. Bảng QUOCGIA

```sql
QUOCGIA(
    MAQG,
    TENQG
)
```

Mỗi quốc gia có:

- Mã quốc gia duy nhất: MAQG
- Tên quốc gia duy nhất: TENQG

---

### 1.3. Bảng CAULACBO

```sql
CAULACBO(
    MACLB,
    TENCLB,
    MASAN,
    MATINH
)
```

Mỗi câu lạc bộ có:

- Mã câu lạc bộ duy nhất: MACLB
- Tên câu lạc bộ: TENCLB
- Sân bóng quản lý: MASAN
- Tỉnh/thành phố: MATINH

Ràng buộc:

Mỗi câu lạc bộ chỉ được phép đăng ký tối đa 8 cầu thủ nước ngoài.

---

### 1.4. Bảng TINH

```sql
TINH(
    MATINH,
    TENTINH
)
```

Mỗi tỉnh/thành có:

- Mã tỉnh/thành duy nhất: MATINH
- Tên tỉnh/thành duy nhất: TENTINH

---

### 1.5. Bảng SANVD

```sql
SANVD(
    MASAN,
    TENSAN,
    DIACHI
)
```

Mỗi sân bóng có:

- Mã sân duy nhất: MASAN
- Tên sân duy nhất: TENSAN
- Địa chỉ: DIACHI

---

### 1.6. Bảng HUANLV

```sql
HUANLV(
    MAHLV,
    TENHLV,
    NGAYSINH,
    DIACHI,
    DIENTHOAI,
    MAQG
)
```

Mỗi huấn luyện viên có:

- Mã số duy nhất: MAHLV
- Họ tên: TENHLV
- Ngày sinh: NGAYSINH
- Địa chỉ: DIACHI
- Điện thoại: DIENTHOAI
- Quốc gia: MAQG

---

### 1.7. Bảng HLV_CLB

```sql
HLV_CLB(
    MAHLV,
    MACLB,
    VAITRO
)
```

Bảng này thể hiện mối quan hệ giữa huấn luyện viên và câu lạc bộ.

- Một câu lạc bộ có thể có nhiều huấn luyện viên.
- Một huấn luyện viên có thể tham gia huấn luyện cho nhiều câu lạc bộ.
- VAITRO xác định vai trò của huấn luyện viên tại câu lạc bộ.

Các vai trò được phép:

- HLV chính
- HLV phụ
- HLV thể lực
- HLV thủ môn

Ràng buộc:

Mỗi câu lạc bộ chỉ có tối đa 2 HLV chính.

---

### 1.8. Bảng TRANDAU

```sql
TRANDAU(
    MATRAN,
    NAM,
    VONG,
    NGAYTD,
    MACLB1,
    MACLB2,
    MASAN,
    KETQUA
)
```

Mỗi trận đấu có:

- Mã trận duy nhất: MATRAN
- Mùa giải: NAM
- Vòng đấu: VONG
- Ngày thi đấu: NGAYTD
- Câu lạc bộ thứ nhất: MACLB1
- Câu lạc bộ thứ hai: MACLB2
- Sân thi đấu: MASAN
- Kết quả: KETQUA

---

### 1.9. Bảng BANGXH

```sql
BANGXH(
    MACLB,
    NAM,
    VONG,
    SOTRAN,
    THANG,
    HOA,
    THUA,
    HIEUSO,
    DIEM,
    HANG
)
```

Bảng xếp hạng cho biết kết quả xếp hạng của một câu lạc bộ trong một vòng đấu của một mùa giải.

Thông tin gồm:

- SOTRAN: Số trận đã đấu
- THANG: Số trận thắng
- HOA: Số trận hòa
- THUA: Số trận thua
- HIEUSO: Hiệu số bàn thắng - thua
- DIEM: Tổng điểm
- HANG: Thứ hạng

---

## 2. Hình minh họa cấu trúc bảng

Phần giáo trình có các hình minh họa cấu trúc bảng:

- CAUTHU
- QUOCGIA
- CAULACBO
- TINH
- SANVD
- HUANLV
- HLV_CLB
- TRANDAU
- BANGXH

Hình ảnh gốc được giữ trong:

17_Database_Projects\01_Football_Management_System\Images.

---

## 3. Một số thiết lập bảng

* CAUTHU - Tăng tự động MACT

Trong SQL Server, cột MACT được thiết lập tăng tự động thông qua:

Column Properties → Identity Specification

- (Is Identity): Yes
- Identity Increment: 1
- Identity Seed: 1

---

## 4. Yêu cầu

* Yêu cầu 1

Tạo cơ sở dữ liệu có tên:

QLBongDa

* Yêu cầu 2

Tạo các bảng:

- CAUTHU
- QUOCGIA
- CAULACBO
- TINH
- HUANLV
- SANVD
- HLV_CLB
- TRANDAU
- BANGXH

* Yêu cầu 3

Tạo liên kết giữa các bảng trong cơ sở dữ liệu.

# Phần II - Nhập dữ liệu và thao tác DML

## 1. Nhập dữ liệu

Sử dụng cơ sở dữ liệu QLBongDa ở Phần I và nhập dữ liệu vào các bảng:

- CAUTHU
- QUOCGIA
- CAULACBO
- TINH
- SANVD
- HUANLV
- HLV_CLB
- TRANDAU
- BANGXH

Dữ liệu chi tiết được trình bày trong giáo trình dưới dạng hình minh họa.

---

## 2. Xóa cầu thủ Nguyễn Vũ Phong

Xóa cầu thủ có họ tên:

Nguyễn Vũ Phong

---

## 3. Xóa cầu thủ có tuổi trên 40

Xóa tất cả các cầu thủ có tuổi trên 40.

---

## 4. Xóa cầu thủ có tuổi trên 35 ở câu lạc bộ BBD

Xóa các cầu thủ:

- Có tuổi trên 35
- Thuộc câu lạc bộ BBD

---

## 5. Xóa cầu thủ có tuổi trên 35 ở câu lạc bộ BECAMEX BÌNH DƯƠNG

Xóa các cầu thủ:

- Có tuổi trên 35
- Thuộc câu lạc bộ có tên:
BECAMEX BÌNH DƯƠNG

---

## 6. Thay đổi vị trí của Nguyễn Trường Sơn

Đổi vị trí thi đấu của cầu thủ:

Nguyễn Trường Sơn

thành:

Tiền đạo

---

## 7. Cập nhật địa chỉ của Lê Huỳnh Đức

Ghi nhận địa chỉ của huấn luyện viên:

Lê Huỳnh Đức

là:

TP.HCM

---

## 8. Đổi vị trí của hai cầu thủ

Đổi vị trí thi đấu của:

Nguyễn Công Vinh
Trần Tấn Tài

theo yêu cầu của đề bài.

---

## 9. Thay huấn luyện viên của GẠCH ĐỒNG TÂM LONG AN

Thay huấn luyện viên mới của câu lạc bộ:

GẠCH ĐỒNG TÂM LONG AN

bằng:

Nguyễn Đức Thắng

---

## 10. Đổi tên câu lạc bộ

Đổi tên câu lạc bộ:

BECAMEX BÌNH DƯƠNG

thành:

BÌNH DƯƠNG