-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Máy chủ: localhost:3306
-- Thời gian đã tạo: Th6 01, 2025 lúc 03:35 AM
-- Phiên bản máy phục vụ: 8.4.3
-- Phiên bản PHP: 8.3.16

START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: ltudcsdl_doan
--
CREATE DATABASE ltudcsdl_doan CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ltudcsdl_doan;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng attendance
--

DROP TABLE IF EXISTS attendance;
CREATE TABLE attendance (
  attendance_id  INT AUTO_INCREMENT NOT NULL,
  employee_id    INT NOT NULL,
  attendance_date DATE NOT NULL,
  check_in       TIME NULL,
  check_out      TIME NULL,
  PRIMARY KEY (attendance_id),
  UNIQUE KEY uniq_emp_date (employee_id, attendance_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng contracts
--

DROP TABLE IF EXISTS contracts;
CREATE TABLE contracts (
  contract_id   INT AUTO_INCREMENT NOT NULL,
  employee_id   INT NOT NULL,
  contract_type VARCHAR(100) NOT NULL,
  start_date    DATE NOT NULL,
  end_date      DATE NOT NULL,
  note          TEXT NULL,
  PRIMARY KEY (contract_id),
  INDEX fk_contracts_emp (employee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng departments
--

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
  department_id INT AUTO_INCREMENT NOT NULL,
  name          VARCHAR(100) NOT NULL,
  manager_id    INT NULL,
  PRIMARY KEY (department_id),
  UNIQUE KEY uniq_dept_name (name),
  INDEX fk_departments_manager (manager_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng users
--

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  user_id   INT AUTO_INCREMENT NOT NULL,
  username  VARCHAR(50) NOT NULL,
  password  VARCHAR(255) NOT NULL,
  role      ENUM('admin','hr','employee') NOT NULL,
  PRIMARY KEY (user_id),
  UNIQUE KEY uniq_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng employees
--

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  employee_id   INT AUTO_INCREMENT NOT NULL,
  full_name     VARCHAR(100) NOT NULL,
  gender        ENUM('M','F') NOT NULL,
  dob           DATE NOT NULL,
  email         VARCHAR(100) NOT NULL,
  phone         VARCHAR(20) NOT NULL,
  address       TEXT NULL,
  department_id INT NULL,
  hire_date     DATE NOT NULL,
  position      VARCHAR(100) NOT NULL,
  user_id       INT NOT NULL,
  PRIMARY KEY (employee_id),
  UNIQUE KEY uniq_email (email),
  INDEX fk_employees_user (user_id),
  INDEX fk_employees_department (department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng leaves
--

DROP TABLE IF EXISTS leaves;
CREATE TABLE leaves (
  leave_id    INT AUTO_INCREMENT NOT NULL,
  employee_id INT NOT NULL,
  leave_type  ENUM('Phep','Benh','Khac') NOT NULL,
  start_date  DATE NOT NULL,
  end_date    DATE NOT NULL,
  status      ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (leave_id),
  INDEX fk_leaves_emp (employee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng rewards_discipline
--

DROP TABLE IF EXISTS rewards_discipline;
CREATE TABLE rewards_discipline (
  record_id    INT AUTO_INCREMENT NOT NULL,
  employee_id  INT NOT NULL,
  type         ENUM('reward','discipline') NOT NULL,
  title        VARCHAR(255) NOT NULL,
  description  TEXT NOT NULL,
  date_recorded DATE NOT NULL,
  PRIMARY KEY (record_id),
  INDEX fk_rewards_emp (employee_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng salary
--

DROP TABLE IF EXISTS salary;
CREATE TABLE salary (
  salary_id    INT AUTO_INCREMENT NOT NULL,
  employee_id  INT NOT NULL,
  month        TINYINT NOT NULL,
  year         SMALLINT NOT NULL,
  basic_salary DECIMAL(10,2) NOT NULL,
  allowance    DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  bonus        DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  deduction    DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  total_salary DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (salary_id),
  UNIQUE KEY uniq_salary_month (employee_id, month, year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



INSERT INTO attendance (attendance_id, employee_id, attendance_date, check_in, check_out) VALUES
(1, 1, '2024-12-18', '08:30:00', '17:30:00'),
(2, 2, '2025-05-01', '09:00:00', '18:00:00'),
(3, 3, '2024-02-19', '08:45:00', '17:15:00'),
(4, 4, '2025-05-01', '08:50:00', '17:20:00'),
(11,3, '2025-05-02', '09:05:00', '14:05:00');

INSERT INTO contracts (contract_id, employee_id, contract_type, start_date, end_date, note) VALUES
(1, 1, 'Loại A', '2020-01-10', '2023-01-11', 'adasd'),
(2, 2, 'Loại B', '2021-06-01', '2025-11-13', 'Probation'),
(3, 3, 'Intern', '2024-09-01', '2025-02-28', 'Internship'),
(4, 4, 'IT Temperature', '2022-09-01', '2025-06-10', 'dădwad'),
(8, 1, '5', '2025-05-14', '2025-05-29', '5'),
(9, 3, 'HĐ Ngắn 3', '2025-05-04', '2025-05-28', 'sdsad');

INSERT INTO departments (department_id, name, manager_id) VALUES
(1, 'Công nghệ thông tin (IT)', 1),
(2, 'Ban tuyển dụng (HR)', 2),
(3, 'Tài chính (Finance)', 3),
(4, 'Kinh doanh (Business)', 4),
(10,'jhvv\r\n', NULL),
(11,'sadsadasd', NULL);

INSERT INTO users (user_id, username, password, role) VALUES
(1,'admin','admin','admin'),
(2,'hr1','hr1','hr'),
(3,'emp1','emp1','employee'),
(4,'emp2','emp2','employee'),
(5,'emp3','emp3','employee'),
(6,'emp4','emp4','employee'),
(7,'emp5','emp5','employee');

INSERT INTO employees (employee_id, full_name, gender, dob, email, phone, address, department_id, hire_date, position, user_id) VALUES
(1,'Trần Đình KHoa','M','1990-05-20','trankhoa@gmail.com','0912345678','Hải Phòng',1,'2020-01-10','Developer',3),
(2,'Trần Thị Nga','F','1992-08-15','nga.tran@gmail.com','0987654321','Hồ Chí Minh',2,'2021-06-01','Nhân sự (HR)',4),
(3,'Lê Thanh Như','F','1988-12-05','lenhu@gmail.com','0901122334','Da Nang',3,'2019-03-15','Kế toán (Accountant)',5),
(4,'Phạm Thị Thanh Hằng','F','1995-07-22','hang.pham@gmail.com','0933221100','Cần Thơ',1,'2022-09-01','Tester',6),
(6,'asdsad','M','2002-02-05','asd@gmail.com','32432434','21323',2,'2025-05-22','32423',7);

INSERT INTO leaves (leave_id, employee_id, leave_type, start_date, end_date, status) VALUES
(1,1,'Khac','2025-05-10','2025-05-31','pending'),
(2,2,'Benh','2025-05-15','2025-05-16','pending'),
(3,3,'Phep','2025-05-20','2025-05-20','approved'),
(4,4,'Phep','2025-05-22','2025-05-23','rejected'),
(9,6,'Phep','2025-05-18','2025-05-31','approved'),
(10,2,'Phep','2025-05-05','2025-05-24','approved');

INSERT INTO rewards_discipline (record_id, employee_id, type, title, description, date_recorded) VALUES
(1,1,'reward','Nhân viên của tháng','Hiệu suất xuất sắc','2025-04-30'),
(2,2,'discipline','Nộp muộn','Trễ thời hạn báo cáo','2025-04-28'),
(3,3,'reward','adsad','Proposed new workflow','2025-05-05'),
(4,4,'discipline','Unapproved Leave','Absent without notice','2025-05-07'),
(6,2,'reward','sadasd','dsdfd','2025-05-08');

INSERT INTO salary (salary_id, employee_id, month, year, basic_salary, allowance, bonus, deduction, total_salary) VALUES
(1,1,1,2025,2324.00,2000000.00,1000000.00,0.00,3002324.00),
(2,2,5,2025,213312.00,1500000.00,500000.00,123.00,2213189.00),
(3,3,3,2025,2324.00,1000000.00,300000.00,0.00,1302324.00),
(4,4,5,2025,234324.00,500000.00,200000.00,4324.00,930000.00);

--
-- Ràng buộc đối với các bảng kết xuất
--

ALTER TABLE departments
  ADD CONSTRAINT fk_departments_manager
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id) ON DELETE SET NULL;

ALTER TABLE employees
  ADD CONSTRAINT fk_employees_department
    FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL,
  ADD CONSTRAINT fk_employees_user
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE;

ALTER TABLE contracts
  ADD CONSTRAINT fk_contracts_emp
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE;

ALTER TABLE leaves
  ADD CONSTRAINT fk_leaves_emp
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE;

ALTER TABLE rewards_discipline
  ADD CONSTRAINT fk_rewards_emp
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE;

ALTER TABLE salary
  ADD CONSTRAINT fk_salary_emp
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
