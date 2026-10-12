# QLGiangDay - Teaching Management System

## Bài 3. Cơ sở dữ liệu QLGiangDay (Quản lý giảng dạy)

---

## 1. Cơ sở dữ liệu

Cơ sở dữ liệu `QLGiangDay` gồm các bảng:

### GIAOVIEN

```sql
GIAOVIEN(MaGV, HoTen, #MaKhoa)
```

Quản lý thông tin giáo viên.

- MaGV: Mã giáo viên.
- HoTen: Họ tên giáo viên.
- MaKhoa: Mã khoa mà giáo viên thuộc về.

---

### MONHOC

```sql
MONHOC(MaMH, TenMH)
```

Quản lý thông tin môn học.

- MaMH: Mã môn học.
- TenMH: Tên môn học.

---

### PHONGHOC

```sql
PHONGHOC(Phong, ChucNang)
```

Quản lý thông tin phòng học.

- Phong: Tên hoặc mã phòng học.
- ChucNang: Chức năng của phòng học.

---

### KHOA

```sql
KHOA(MaKhoa, TenKhoa)
```

Quản lý thông tin khoa.

- MaKhoa: Mã khoa.
- TenKhoa: Tên khoa.

---

### LOP

```sql
LOP(MaLop, TenLop, #MaKhoa)
```

Quản lý thông tin lớp.

- MaLop: Mã lớp.
- TenLop: Tên lớp.
- MaKhoa: Mã khoa mà lớp thuộc về.

---

### LICHDAY

```sql
LICHDAY(
    #MaGV,
    #MaMH,
    #Phong,
    #MaLop,
    NgayDay,
    TuTiet,
    DenTiet,
    BaiDay,
    LyThuyet,
    GhiChu
)
```

Quản lý lịch dạy.

- MaGV: Mã giáo viên.
- MaMH: Mã môn học.
- Phong: Phòng học.
- MaLop: Mã lớp.
- NgayDay: Ngày dạy.
- TuTiet: Tiết bắt đầu.
- DenTiet: Tiết kết thúc.
- BaiDay: Bài dạy.
- LyThuyet: Thông tin về phần lý thuyết.
- GhiChu: Ghi chú.

---

## 2. Yêu cầu

### Câu 1

Tạo CSDL có tên là QLGiangDay.

---

### Câu 2

Tạo các table như trên vào CSDL QLGV có thiết lập ràng buộc khoá chính, khoá ngoại.

Các table cần tạo:

- GIAOVIEN
- MONHOC
- PHONGHOC
- KHOA
- LOP
- LICHDAY

Thiết lập:

- Khóa chính (Primary Key).
- Khóa ngoại (Foreign Key).

---

### Câu 3

Xem mô hình liên kết giữa các table.

---

### Câu 4

Thêm các cột sau vào bảng GIAOVIEN:

- Ngày sinh.
- Giới tính.
- Tuổi.

---

### Câu 5

Thêm cột SucChua (sức chứa) vào bảng PHONGHOC.

---

### Câu 6

Thêm các cột sau vào bảng MONHOC:

- SoTC: Số tín chỉ.
- TCLT: Số tín chỉ lý thuyết.
- TCTH: Số tín chỉ thực hành.

---

### Câu 7

Thêm cột SiSo vào bảng LOP.

SiSo biểu thị sĩ số của lớp.

---

### Câu 8

Thêm ràng buộc toàn vẹn cho các cột:

- SiSo
- SoTC
- TCLT
- TCTH
- SucChua
- TuoiGV