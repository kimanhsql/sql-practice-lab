# QLCongTrinh - Construction Management System

## Bài 2. Cơ sở dữ liệu QLCongTrinh (Quản lý công trình)

---

## 1. MÔ TẢ CƠ SỞ DỮ LIỆU

### KTRUCSU

`KTRUCSU(HOTEN_KTS, NAMS_KTS, PHAI, NOI_TN, DCHI_LL_KTS)`

Mỗi kiến trúc sư có:

- Họ tên
- Năm sinh
- Phái
- Nơi tốt nghiệp
- Địa chỉ liên lạc

Giả sử không có hai kiến trúc sư trùng tên.

---

### CHUTHAU

`CHUTHAU(TEN_THAU, TEL, DCHI_THAU)`

Mỗi chủ thầu xây dựng công trình có:

- Tên thầu
- Số điện thoại
- Địa chỉ

Giả sử không có hai chủ thầu trùng tên.

---

### CHUNHAN

`CHUNHAN(TEN_CHU, DCHI_CHU)`

Mỗi chủ nhân của một công trình có:

- Tên chủ nhân
- Địa chỉ

Giả sử không có hai chủ nhân trùng tên.

---

### CONGNHAN

`CONGNHAN(HOTEN_CN, NAMS_CN, NAM_VAO_N, CH_MON)`

Mỗi công nhân tham gia xây dựng các công trình có:

- Họ tên
- Năm sinh
- Năm vào nghề
- Chuyên môn

Giả sử không có hai công nhân trùng họ tên.

---

### CONGTRINH

`CONGTRINH(STT_CTR, TEN_CTR, DCHI_CTR, TINH_THANH, KINH_PHI, TEN_CHU, TEN_THAU, NGAY_BD)`

Mỗi công trình có:

- Số thứ tự
- Tên công trình
- Địa chỉ
- Tỉnh/thành
- Kinh phí xây dựng, đơn vị tính là triệu đồng
- Chủ nhân
- Chủ thầu xây dựng
- Ngày bắt đầu xây dựng

---

### THAMGIA

`THAMGIA(HOTEN_CN, STT_CTR, NGAY_TGIA, SO_NGAY)`

Một công nhân có thể tham gia xây dựng nhiều công trình.

Một công trình cũng có nhiều công nhân tham gia.

Khi một công nhân tham gia vào một công trình, thông tin được ghi nhận gồm:

- Ngày bắt đầu tham gia
- Số ngày tham gia

---

### THIETKE

`THIETKE(HOTEN_KTS, STT_CTR, THU_LAO)`

Một kiến trúc sư có thể thiết kế nhiều công trình.

Một công trình cũng có thể do nhiều kiến trúc sư cùng thiết kế.

Khi một kiến trúc sư thiết kế một công trình, thông tin về thù lao tương ứng được ghi nhận.

---

## 2. YÊU CẦU

### 1. Tạo cơ sở dữ liệu

Tạo CSDL có tên:

`QL_CONGTRINH`

### 2. Tạo các Table

Tạo các Table trong cơ sở dữ liệu `QL_CONGTRINH`.

Các Table được mô tả trong phần trên:

```text
KTRUCSU
CHUTHAU
CHUNHAN
CONGNHAN
CONGTRINH
THAMGIA
THIETKE
```

---

## 3. Tạo liên kết giữa các Table

Tạo liên kết giữa các Table trong CSDL `QL_CONGTRINH`.

---

## 4. Xem mô hình liên kết

Xem mô hình liên kết giữa các Table.