# QLCongTrinh - Construction Management System

## Bài 2. Cơ sở dữ liệu QLCongTrinh (Quản lý công trình)

---

# Phần I - Xây dựng cơ sở dữ liệu QLCongTrinh

## 1. Mô tả cơ sở dữ liệu

Cơ sở dữ liệu **QL_CONGTRINH** dùng để quản lý thông tin về các công trình xây dựng, bao gồm kiến trúc sư, chủ thầu, chủ nhân công trình, công nhân, công trình, quá trình tham gia thi công và thông tin thiết kế.

---

### 1.1. Bảng KTRUCSU

```sql
KTRUCSU(
    HOTEN_KTS NVARCHAR(100),
    NAMS_KTS INT,
    PHAI NVARCHAR(3),
    NOI_TN NVARCHAR(200),
    DCHI_LL_KTS NVARCHAR(200),
)
```

Bảng KTRUCSU lưu trữ thông tin về các kiến trúc sư tham gia thiết kế công trình.

Thông tin gồm:

- Mã kiến trúc sư.
- Họ tên kiến trúc sư.
- Năm sinh.
- Năm tốt nghiệp.

---

### 1.2. Bảng CHUTHAU

```sql
CHUTHAU(
    TEN_THAU NVARCHAR(100),
    TEL NVARCHAR(20) NOT NULL,
    DCHI_THAU NVARCHAR(200)
)
```

Bảng CHUTHAU lưu trữ thông tin về các chủ thầu chịu trách nhiệm thi công công trình.

Thông tin gồm:

- Mã chủ thầu.
- Họ tên chủ thầu.
- Địa chỉ.
- Điện thoại.

---

### 1.3. Bảng CHUNHAN

```sql
CHUNHAN(
    TEN_CHU NVARCHAR(100),
    DCHI_CHU NVARCHAR(200) NOT NULL,
)
```

Bảng CHUNHAN lưu trữ thông tin về các chủ nhân sở hữu công trình.

Thông tin gồm:

- Mã chủ nhân.
- Họ tên chủ nhân.
- Địa chỉ.
- Điện thoại.

---

### 1.4. Bảng CONGNHAN

```sql
CONGNHAN(
    HOTEN_CN NVARCHAR(100),
    NAMS_CN INT,
    NAM_VAO_N DATETIME,
    CH_MON NVARCHAR(200)       
)
```

Bảng CONGNHAN lưu trữ thông tin về các công nhân tham gia thi công công trình.

Thông tin gồm:

- Mã công nhân.
- Họ tên công nhân.
- Năm sinh.
- Nghề nghiệp.

---

### 1.5. Bảng CONGTRINH

```sql
CONGTRINH(
    STT_CTR NUMERIC IDENTITY(1,1),
    TEN_CTR NVARCHAR(200) NOT NULL,
    DCHI_CTR NVARCHAR(200),
    TINH_THANH NVARCHAR(100),
    KINH_PHI FLOAT,
    TEN_CHU NVARCHAR(100) NOT NULL,
    TEN_THAU NVARCHAR(100) NOT NULL,
    NGAY_BD DATETIME,
)
```

Bảng CONGTRINH lưu trữ thông tin về các công trình xây dựng.

Thông tin gồm:

- Mã công trình.
- Tên công trình.
- Địa điểm xây dựng.
- Ngày khởi công.
- Ngày kết thúc.
- Mã chủ thầu.
- Mã chủ nhân.

---

### 1.6. Bảng THAMGIA

```sql
THAMGIA(
    HOTEN_CN NVARCHAR(100),
    STT_CTR NUMERIC,
    NGAY_TGIA DATETIME,
    SO_NGAY INT,
)
```

Bảng THAMGIA thể hiện mối quan hệ giữa công nhân và công trình mà họ tham gia thi công.

Thông tin gồm:

- Mã công nhân.
- Mã công trình.
- Thời gian tham gia.

Bảng này dùng để ghi nhận quá trình tham gia thi công của công nhân tại các công trình.

---

### 1.7. Bảng THIETKE

```sql
THIETKE(

)
```

Bảng THIETKE thể hiện mối quan hệ giữa kiến trúc sư và công trình được thiết kế.

Thông tin gồm:

- Mã kiến trúc sư.
- Mã công trình.
- Ngày thiết kế.

Bảng này dùng để ghi nhận kiến trúc sư tham gia thiết kế từng công trình.

---

## 2. Yêu cầu

**Yêu cầu 1. Tạo cơ sở dữ liệu**

Tạo cơ sở dữ liệu có tên:

QL_CONGTRINH

**Yêu cầu 2. Tạo các bảng**

Tạo các bảng sau trong cơ sở dữ liệu QL_CONGTRINH:

- KTRUCSU
- CHUTHAU
- CHUNHAN
- CONGNHAN
- CONGTRINH
- THAMGIA
- THIETKE

**Yêu cầu 3. Tạo liên kết giữa các bảng**

Thiết lập các mối quan hệ giữa những bảng trong cơ sở dữ liệu theo yêu cầu của bài thực hành.

**Yêu cầu 4. Xem mô hình liên kết giữa các bảng**

Hiển thị mô hình quan hệ giữa các bảng để kiểm tra các liên kết đã thiết lập trong cơ sở dữ liệu.