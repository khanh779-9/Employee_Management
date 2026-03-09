# Java Web - Quản Lý Nhân Viên

Dự án Java Web động giúp quản lý thông tin nhân viên, được phát triển bằng **JSP/Servlet**, chạy trên **Apache Tomcat**, và sử dụng **MySQL** làm cơ sở dữ liệu.

---

## Tính năng

- Thêm, sửa, xoá nhân viên, phòng ban, nghỉ phép, hợp đồng,...
- Tìm kiếm lọc theo tên, mã nhân viên
- Quản lý thông tin chi tiết
- Giao diện người dùng đơn giản với JSP

---

## Công nghệ sử dụng

| Thành phần       | Công nghệ                 |
|------------------|---------------------------|
| Backend          | Java Servlet, JSP         |
| Frontend         | HTML, CSS, JSP            |
| Server           | Apache Tomcat (8.x hoặc 9.x) |
| Cơ sở dữ liệu    | MySQL                     |
| IDE              | Eclipse hoặc IntelliJ     |

---

## Cấu trúc thư mục
```
EmployeeManager/
├── src/
│ └── controller/ # Servlet xử lý logic
│ └── model/ # Các lớp Java (Employee, DAO, DBContext)
├── WebContent/
│ └── index.jsp
│ └── employee.jsp
│ └── css/
├── WEB-INF/
│ └── web.xml
└── README.md
```

## Cấu hình môi trường

Ứng dụng đọc cấu hình DB từ biến môi trường:

- `DB_URL`
- `DB_USER`
- `DB_PASSWORD`
- `DB_DRIVER` (tuỳ chọn, mặc định `com.mysql.jdbc.Driver`)

Ví dụ `DB_URL`:

`jdbc:mysql://<host>:3306/ltudcsdl_doan?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC`

## Deploy Render

- Service đang chạy bằng `Dockerfile`.
- Docker build đã được cấu hình để tự tải và đóng gói runtime libraries (JPA/Hibernate/MySQL) vào `WEB-INF/lib`.
- Trên Render, vào **Environment** và set đủ `DB_URL`, `DB_USER`, `DB_PASSWORD`.
