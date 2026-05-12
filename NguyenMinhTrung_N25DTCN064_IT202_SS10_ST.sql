CREATE DATABASE hospital_vn_db;
USE hospital_vn_db;

-- 1. Khởi tạo dữ liệu: Tạo hai bảng Records_North và Records_South với cấu trúc giống hệt nhau (ID, Patient_Name, Diagnosis, Date).
CREATE TABLE Records_North (
    Record_ID INT PRIMARY KEY,
    Patient_Name VARCHAR(100),
    Diagnosis TEXT,
    Record_Date DATE
);

CREATE TABLE Records_South (
    Record_ID INT PRIMARY KEY,
    Patient_Name VARCHAR(100),
    Diagnosis TEXT,
    Record_Date DATE
);

INSERT INTO Records_North VALUES (1, 'Nguyen Van A', 'Flu', '2026-04-28');
INSERT INTO Records_South VALUES (1, 'Le Thi B', 'Cold', '2026-04-28');

-- 2 + 3 + 4. Xây dựng View tổng hợp: Tạo View tên National_Record_View bằng cách sử dụng lệnh UNION ALL và Định danh chi nhánh: Trong View, tự động tạo thêm một cột ảo mang 
-- tên Branch_Name với giá trị tương ứng là 'North' hoặc 'South' cho mỗi bản ghi. Đồng thời Xử lý xung đột: Kiểm tra trường hợp một bệnh nhân trùng mã ID ở cả hai chi nhánh. 
-- Phân tích cách View hiển thị dữ liệu này (Liệu có mất dữ liệu không?).
CREATE VIEW National_Record_View AS
SELECT  CONCAT('North-', Record_ID) AS VietNam_id, Patient_Name, Diagnosis, Record_Date, 'North' AS Branch FROM Records_North 
UNION ALL 
SELECT CONCAT('South-', Record_ID) AS VietNam_id, Patient_Name, Diagnosis, Record_Date, 'South' AS Branch FROM Records_South;

-- Phân tích cách View hiển thị dữ liệu này (Liệu có mất dữ liệu không?): View hiển thi dữ liệu này sẽ mất khi nó gộp 2 bảng bằng union còn không mất nếu nó gộp bảng bằng
-- union all nên tùy trường hợp mà view sẽ hiển thị khác nhau.
SELECT * FROM National_Record_View;


-- Đầu tiên em sẽ giải thích về cơ chế union và union all. Chúng ta có thể hiểu đơn giản union là gộp bảng lại nhưng loại bỏ những bản ghi trùng nhau để tạo ra một giá trị duy
-- nhất còn union all là phép gộp nhưng vẫn giữ nguyên dòng trùng đó. Và với việc union sẽ trả về một tập kết quả riêng chính vì thế ID có thể trùng nhau mà không gặp ảnh hưởng
-- của primary key. Tiếp theo đối với việc id bị trùng thì union sẽ bỏ hoàn toàn id trùng lặp để nó thành duy nhất còn union all sẽ giữ lại tập kết quả đó mà không đổi.