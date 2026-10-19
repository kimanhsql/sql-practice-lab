## Câu hỏi 1

Dưới đây là thông tin chi tiết về bài thực hành **QLBongDa** theo đúng giáo trình:

### 1. Tên bài và mục tiêu của bài
* **Tên bài:** **Bài 1. Cơ sở dữ liệu về Quản lý giải bóng đá (QLBongDa)**.
* **Mục tiêu của bài:** Trong giáo trình **không có mục ghi riêng "Mục tiêu của bài"**. Tuy nhiên, mục tiêu thực hành được thể hiện thông qua các yêu cầu bài tập gồm: khởi tạo CSDL, tạo các bảng dữ liệu kèm ràng buộc khóa chính - khóa ngoại, tạo liên kết, cũng như thực hành nhập dữ liệu, xóa và cập nhật dữ liệu trên CSDL QLBongDa.

---

### 2. Các phần trong bài
Bài thực hành QLBongDa được chia thành các phần nội dung chính ở hai chương thực hành:
* **Phần tạo lập cấu trúc CSDL (Trang 96 – 99):**
  1. **1. MÔ TẢ CƠ SỞ DỮ LIỆU**
  2. **2. YÊU CẦU**
* **Phần thao tác dữ liệu - DML (Trang 105 – 108):**
  1. **1. Nhập dữ liệu vào các table**
  2. Các yêu cầu thao tác dữ liệu (câu 2 đến câu 10).

---

### 3. Các bảng cần tạo
Bài thực hành yêu cầu tạo **9 bảng (table)** với danh sách thuộc tính chi tiết như sau:
1. **CAUTHU** (`MACT`, `HOTEN`, `VITRI`, `NGAYSINH`, `DIACHI`, `MACLB`, `MAQG`, `SO`)
2. **QUOCGIA** (`MAQG`, `TENQG`)
3. **CAULACBO** (`MACLB`, `TENCLB`, `MASAN`, `MATINH`)
4. **TINH** (`MATINH`, `TENTINH`)
5. **SANVD** (`MASAN`, `TENSAN`, `DIACHI`)
6. **HUANLV** (`MAHLV`, `TENHLV`, `NGAYSINH`, `DIACHI`, `DIENTHOAI`, `MAQG`)
7. **HLV_CLB** (`MAHLV`, `MACLB`, `VAITRO`)
8. **TRANDAU** (`MATRAN`, `NAM`, `VONG`, `NGAYTD`, `MACLB1`, `MACLB2`, `MASAN`, `KETQUA`)
9. **BANGXH** (`MACLB`, `NAM`, `VONG`, `SOTRAN`, `THANG`, `HOA`, `THUA`, `HIEUSO`, `DIEM`, `HANG`)

---

### 4. Các yêu cầu được đánh số trong đề bài

#### **A. Yêu cầu khởi tạo CSDL & Liên kết (Trang 99):**
1. **Tạo CSDL** có tên **QLBongDa**.
2. **Tạo các Table:** `CAUTHU`, `QUOCGIA`, `CAULACBO`, `TINH`, `HUANLV`, `SANVD`, `HLV_CLB`, `TRANDAU`, `BANGXH`.
3. **Tạo liên kết** cho các Table trong CSDL trên.

#### **B. Yêu cầu thao tác dữ liệu - DML (Trang 105, 108):**
1. **Nhập dữ liệu** vào các table (`CAUTHU`, `QUOCGIA`, `CAULACBO`, `TINH`, `SANVD`, `HUANLV`, `HLV_CLB`, `TRANDAU`, `BANGXH`).
2. **Xóa** cầu thủ ‘Nguyễn Vũ Phong’.
3. **Xóa** các cầu thủ có tuổi trên 40.
4. **Xóa** các cầu thủ có tuổi trên 35 ở câu lạc bộ ‘BBD’.
5. **Xóa** các cầu thủ có tuổi trên 35 ở câu lạc bộ ‘BECAMEX BÌNH DƯƠNG’.
6. **Đổi vị trí** thi đấu của cầu thủ ‘Nguyễn Trường Sơn’ thành ‘Tiền đạo’.
7. **Ghi nhận địa chỉ** của huấn luyện viên ‘Lê Huỳnh Đức’ là ‘TP.HCM’.
8. **Đổi vị trí** của cầu thủ ‘Nguyễn Công Vinh’ với cầu thủ ‘Trần Tấn Tài’.
9. **Thay huấn luyện viên mới** của ‘GẠCH ĐỒNG TÂM LONG AN’ là ‘Nguyễn Đức Thắng’.
10. **Đổi tên câu lạc bộ** ‘BECAMEX BÌNH DƯƠNG’ thành ‘BÌNH DƯƠNG’.

---

### 5. Những trang chứa nội dung này
* **Trang 96, 97, 98, 99:** Nội dung phần mô tả các bảng, cấu trúc thuộc tính và yêu cầu tạo CSDL/Table/Liên kết.
* **Trang 105, 106, 107, 108:** Nội dung phần thực hành thao tác DML (Bài 1) bao gồm dữ liệu mẫu nhập vào các bảng và 10 câu hỏi yêu cầu thao tác xóa/cập nhật dữ liệu.

---

## Câu hỏi 2

Dưới đây là **đầy đủ tất cả các yêu cầu** của bài thực hành **QLBongDa** được trình bày theo đúng thứ tự, giữ nguyên văn bản, điều kiện và câu chữ gốc trong giáo trình:

---

### **PHẦN I: NGÔN NGỮ MÔ TẢ DỮ LIỆU (DDL)**
*(Trang 96 – 99)*

**Tên bài:** Bài 1. Cơ sở dữ liệu về Quản lý giải bóng đá (QLBongDa)

#### **Mục 2. YÊU CẦU (Trang 99):**
1. **Tạo CSDL có tên QLBongDa.** *(Tham chiếu: Trang 99)*
2. **Tạo các Table CAUTHU, QUOCGIA, CAULACBO, TINH, HUANLV, SANVD, HLV_CLB, TRANDAU, BANGXH.** *(Tham chiếu: Trang 99)*
3. **Tạo liên kết cho các Table trong CSDL trên.** *(Tham chiếu: Trang 99)*

---

### **PHẦN II: NGÔN NGỮ THAO TÁC DỮ LIỆU (DML)**
*(Trang 105 – 108)*

**Tên bài:** Bài 1: Sử dụng CSDL QLBongDa (ở phần I) thực hiện các yêu cầu sau:

#### **Danh sách các yêu cầu được đánh số (Trang 105, 108):**
1. **Nhập dữ liệu vào các table như sau:** `CAUTHU`, `QUOCGIA`, `CAULACBO`, `TINH`, `SANVD`, `HUANLV`, `HLV_CLB`, `TRANDAU`, `BANGXH`. *(Tham chiếu: Trang 105 – 107)*
2. **Xóa cầu thủ ‘Nguyễn Vũ Phong’.** *(Tham chiếu: Trang 108)*
3. **Xóa các cầu thủ có tuổi trên 40.** *(Tham chiếu: Trang 108)*
4. **Xóa các cầu thủ có tuổi trên 35 ở câu lạc bộ ‘BBD’.** *(Tham chiếu: Trang 108)*
5. **Xóa các cầu thủ có tuổi trên 35 ở câu lạc bộ ‘BECAMEX BÌNH DƯƠNG’.** *(Tham chiếu: Trang 108)*
6. **Đổi vị trí thi đấu của cầu thủ ‘Nguyễn Trường Sơn’ thành ‘Tiền đạo’.** *(Tham chiếu: Trang 108)*
7. **Ghi nhận địa chỉ của huấn luyện viên ‘Lê Huỳnh Đức’ là ‘TP.HCM’.** *(Tham chiếu: Trang 108)*
8. **Đổi vị trí của cầu thủ ‘Nguyễn Công Vinh’ với cầu thủ ‘Trần Tấn Tài’.** *(Tham chiếu: Trang 108)*
9. **Thay huấn luyện viên mới của ‘GẠCH ĐỒNG TÂM LONG AN’ là ‘Nguyễn Đức Thắng’.** *(Tham chiếu: Trang 108)*
10. **Đổi tên câu lạc bộ ‘BECAMEX BÌNH DƯƠNG’ thành ‘BÌNH DƯƠNG’.** *(Tham chiếu: Trang 108)*

---

*(Lưu ý: Trong **Phần III: Truy vấn dữ liệu** từ trang 116 đến 126 của giáo trình, bài tập thực hành được thiết kế cho các CSDL khác bao gồm Quản lý hàng hóa, Quản lý học viên, Quản lý chuyến bay và Quản lý đề án, không có mục bài tập truy vấn SELECT riêng dành cho QLBongDa).*

💡 Bạn có muốn tôi tổng hợp lại toàn bộ dữ liệu mẫu cần nhập của 9 bảng ở câu số 1 (Phần II) để dễ dàng thao tác nhập liệu không?

---

## Câu hỏi 3

Dưới đây là thống kê chi tiết cấu trúc cơ sở dữ liệu **QLBongDa** theo từng bảng dựa trên thông tin trong giáo trình:

---

### **LƯU Ý VỀ THÔNG TIN TRỰC TIẾP VÀ CHƯA ĐƯỢC XÁC ĐỊNH TRONG GIÁO TRÌNH**
* **Thông tin được nêu trực tiếp:** Tên 9 bảng, danh sách từng thuộc tính, kiểu dữ liệu, khóa chính (PK), các thuộc tính bắt buộc (`NOT NULL`), thuộc tính tăng tự động (`Identity`) và các quy tắc/ràng buộc nghiệp vụ được mô tả bằng văn bản.
* **Thông tin chưa được xác định (giáo trình không ghi trực tiếp trong bảng mô tả chi tiết):**
  * Trong bảng chi tiết thuộc tính ở trang 97 – 98, giáo trình **không ghi chữ "KHÓA NGOẠI"** ở cột ghi chú/diễn giải cho bất kỳ bảng nào (thông tin tham chiếu khóa ngoại chỉ được nêu theo ngữ nghĩa mô tả bài toán ở trang 96 – 97 và yêu cầu tạo liên kết ở trang 99).
  * Giáo trình **chưa đưa ra câu lệnh SQL cụ thể** (như tên Constraint `PK_...`, `FK_...`, hoặc hành động `ON DELETE / ON UPDATE`).
  * Các thuộc tính không có chữ "BẮT BUỘC" (như `NGAYSINH`, `DIACHI`, `DIENTHOAI`) được hiểu theo mặc định là cho phép `NULL`, nhưng giáo trình không ghi rõ chữ "NULL" trong cột ghi chú của bảng.

---

### **THỐNG KÊ CẤU TRÚC CHI TIẾT TỪNG BẢNG**

#### **1. Bảng `CAUTHU`**
* **Tên bảng:** `CAUTHU`
* **Các thuộc tính & Kiểu dữ liệu (nêu trực tiếp):**
  1. `MACT`: `NUMERIC`
  2. `HOTEN`: `NVARCHAR(100)`
  3. `VITRI`: `NVARCHAR(20)`
  4. `NGAYSINH`: `DATETIME`
  5. `DIACHI`: `NVARCHAR(200)`
  6. `MACLB`: `VARCHAR(5)`
  7. `MAQG`: `VARCHAR(5)`
  8. `SO`: `INT`
* **Khóa chính (nêu trực tiếp):** `MACT`
* **Khóa ngoại:**
  * *Nêu trực tiếp theo ngữ nghĩa mô tả:* `MACLB` (thuộc một câu lạc bộ), `MAQG` (thuộc một quốc gia).
  * *Chưa được xác định:* Ký hiệu/chú thích "KHÓA NGOẠI" trong bảng mô tả thuộc tính ở trang 97.
* **Các ràng buộc được yêu cầu:**
  * *Nêu trực tiếp:*
    * `MACT`: Tăng tự động (`Is Identity: Yes`, `Identity Increment: 1`, `Identity Seed: 1`).
    * Bắt buộc (`NOT NULL`): `HOTEN`, `VITRI`, `MACLB`, `MAQG`, `SO`.
    * `VITRI` chỉ thuộc một trong các giá trị: 'Thủ môn', 'Tiền đạo', 'Tiền vệ', 'Trung vệ', 'Hậu vệ'.
    * Cầu thủ thuộc cùng một câu lạc bộ phải có số áo khác nhau.
  * *Chưa được xác định:* Trạng thái bắt buộc hay cho phép `NULL` của `NGAYSINH`, `DIACHI` (cột ghi chú để trống).

---

#### **2. Bảng `QUOCGIA`**
* **Tên bảng:** `QUOCGIA`
* **Các thuộc tính & Kiểu dữ liệu (nêu trực tiếp):**
  1. `MAQG`: `VARCHAR(5)`
  2. `TENQG`: `NVARCHAR(60)`
* **Khóa chính (nêu trực tiếp):** `MAQG`
* **Khóa ngoại:** Không có.
* **Các ràng buộc được yêu cầu:**
  * *Nêu trực tiếp:*
    * Bắt buộc (`NOT NULL`): `TENQG`.
    * `TENQG`: Tên duy nhất (UNIQUE).

---

#### **3. Bảng `CAULACBO`**
* **Tên bảng:** `CAULACBO`
* **Các thuộc tính & Kiểu dữ liệu (nêu trực tiếp):**
  1. `MACLB`: `VARCHAR(5)`
  2. `TENCLB`: `NVARCHAR(100)`
  3. `MASAN`: `VARCHAR(5)`
  4. `MATINH`: `VARCHAR(5)`
* **Khóa chính (nêu trực tiếp):** `MACLB`
* **Khóa ngoại:**
  * *Nêu trực tiếp theo ngữ nghĩa mô tả:* `MASAN` (quản lý một sân bóng), `MATINH` (thuộc một tỉnh thành).
  * *Chưa được xác định:* Ký hiệu "KHÓA NGOẠI" trong bảng mô tả thuộc tính.
* **Các ràng buộc được yêu cầu:**
  * *Nêu trực tiếp:*
    * Bắt buộc (`NOT NULL`): `TENCLB`, `MASAN`, `MATINH`.
    * Ràng buộc nghiệp vụ: Mỗi câu lạc bộ chỉ được phép đăng ký tối đa 8 cầu thủ nước ngoài.

---

#### **4. Bảng `TINH`**
* **Tên bảng:** `TINH`
* **Các thuộc tính & Kiểu dữ liệu (nêu trực tiếp):**
  1. `MATINH`: `VARCHAR(5)`
  2. `TENTINH`: `NVARCHAR(100)`
* **Khóa chính (nêu trực tiếp):** `MATINH`
* **Khóa ngoại:** Không có.
* **Các ràng buộc được yêu cầu:**
  * *Nêu trực tiếp:*
    * Bắt buộc (`NOT NULL`): `TENTINH`.
    * `TENTINH`: Tên tỉnh/thành duy nhất (UNIQUE).

---

#### **5. Bảng `SANVD`**
* **Tên bảng:** `SANVD`
* **Các thuộc tính & Kiểu dữ liệu (nêu trực tiếp):**
  1. `MASAN`: `VARCHAR(5)`
  2. `TENSAN`: `NVARCHAR(100)`
  3. `DIACHI`: `NVARCHAR(200)`
* **Khóa chính (nêu trực tiếp):** `MASAN`
* **Khóa ngoại:** Không có.
* **Các ràng buộc được yêu cầu:**
  * *Nêu trực tiếp:*
    * Bắt buộc (`NOT NULL`): `TENSAN`.
    * `TENSAN`: Tên sân duy nhất (UNIQUE).
  * *Chưa được xác định:* Trạng thái cho phép `NULL` của `DIACHI` (để trống phần ghi chú).

---

#### **6. Bảng `HUANLV`**
* **Tên bảng:** `HUANLV`
* **Các thuộc tính & Kiểu dữ liệu (nêu trực tiếp):**
  1. `MAHLV`: `VARCHAR(5)`
  2. `TENHLV`: `NVARCHAR(100)`
  3. `NGAYSINH`: `DATETIME`
  4. `DIACHI`: `NVARCHAR(200)`
  5. `DIENTHOAI`: `NVARCHAR(20)`
  6. `MAQG`: `VARCHAR(5)`
* **Khóa chính (nêu trực tiếp):** `MAHLV`
* **Khóa ngoại:**
  * *Nêu trực tiếp theo ngữ nghĩa mô tả:* `MAQG` (thuộc một quốc gia).
  * *Chưa được xác định:* Ký hiệu "KHÓA NGOẠI" trong bảng thuộc tính chi tiết.
* **Các ràng buộc được yêu cầu:**
  * *Nêu trực tiếp:* Bắt buộc (`NOT NULL`): `TENHLV`, `MAQG`.
  * *Chưa được xác định:* Trạng thái bắt buộc của `NGAYSINH`, `DIACHI`, `DIENTHOAI` (không ghi BẮT BUỘC).

---

#### **7. Bảng `HLV_CLB`**
* **Tên bảng:** `HLV_CLB`
* **Các thuộc tính & Kiểu dữ liệu (nêu trực tiếp):**
  1. `MAHLV`: `VARCHAR(5)`
  2. `MACLB`: `VARCHAR(5)`
  3. `VAITRO`: `NVARCHAR(100)`
* **Khóa chính (nêu trực tiếp):** Khóa chính phức hợp gồm (`MAHLV`, `MACLB`).
* **Khóa ngoại:**
  * *Nêu trực tiếp theo ngữ nghĩa mô tả:* `MAHLV` (huấn luyện viên), `MACLB` (câu lạc bộ).
  * *Chưa được xác định:* Ký hiệu "KHÓA NGOẠI" ở bảng mô tả thuộc tính.
* **Các ràng buộc được yêu cầu:**
  * *Nêu trực tiếp:*
    * Bắt buộc (`NOT NULL`): `VAITRO`.
    * `VAITRO` chỉ thuộc một trong các giá trị: 'HLV chính', 'HLV phụ', 'HLV thể lực', 'HLV thủ môn'.
    * Mỗi câu lạc bộ chỉ có tối đa 2 HLV chính.

---

#### **8. Bảng `TRANDAU`**
* **Tên bảng:** `TRANDAU`
* **Các thuộc tính & Kiểu dữ liệu (nêu trực tiếp):**
  1. `MATRAN`: `NUMERIC`
  2. `NAM`: `INT`
  3. `VONG`: `INT`
  4. `NGAYTD`: `DATETIME`
  5. `MACLB1`: `VARCHAR(5)`
  6. `MACLB2`: `VARCHAR(5)`
  7. `MASAN`: `VARCHAR(5)`
  8. `KETQUA`: `VARCHAR(5)`
* **Khóa chính (nêu trực tiếp):** `MATRAN`
* **Khóa ngoại:**
  * *Nêu trực tiếp theo ngữ nghĩa mô tả:* `MACLB1` (câu lạc bộ 1), `MACLB2` (câu lạc bộ 2), `MASAN` (sân bóng).
  * *Chưa được xác định:* Ký hiệu "KHÓA NGOẠI" trong bảng mô tả thuộc tính.
* **Các ràng buộc được yêu cầu:**
  * *Nêu trực tiếp:*
    * `MATRAN`: Tăng tự động.
    * Bắt buộc (`NOT NULL`): `NAM`, `VONG`, `MACLB1`, `MACLB2`, `MASAN`, `KETQUA`.
  * *Chưa được xác định:* Trạng thái bắt buộc của `NGAYTD` (không ghi BẮT BUỘC).

---

#### **9. Bảng `BANGXH`**
* **Tên bảng:** `BANGXH`
* **Các thuộc tính & Kiểu dữ liệu (nêu trực tiếp):**
  1. `MACLB`: `VARCHAR(5)`
  2. `NAM`: `INT`
  3. `VONG`: `INT`
  4. `SOTRAN`: `INT`
  5. `THANG`: `INT`
  6. `HOA`: `INT`
  7. `THUA`: `INT`
  8. `HIEUSO`: `VARCHAR(5)`
  9. `DIEM`: `INT`
  10. `HANG`: `INT`
* **Khóa chính (nêu trực tiếp):** Khóa chính phức hợp gồm (`MACLB`, `NAM`, `VONG`).
* **Khóa ngoại:**
  * *Nêu trực tiếp theo ngữ nghĩa mô tả:* `MACLB` (câu lạc bộ).
  * *Chưa được xác định:* Ký hiệu "KHÓA NGOẠI" ở bảng mô tả thuộc tính.
* **Các ràng buộc được yêu cầu:**
  * *Nêu trực tiếp:* Bắt buộc (`NOT NULL`): Tất cả các thuộc tính còn lại (`SOTRAN`, `THANG`, `HOA`, `THUA`, `HIEUSO`, `DIEM`, `HANG`).

---

💡 Bạn có muốn tôi hỗ trợ viết các câu lệnh SQL `CREATE TABLE` chi tiết (bao gồm cả việc cài đặt khóa chính, khóa ngoại và các ràng buộc CHECK/UNIQUE) cho 9 bảng này không?