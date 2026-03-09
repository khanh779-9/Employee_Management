-- 1. Tạo database
CREATE DATABASE IF NOT EXISTS ltudcsdl_doan1
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE ltudcsdl_doan1;

-- =================
-- Tên bảng: users
-- =================
CREATE TABLE `users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('admin','hr','employee') NOT NULL,
  PRIMARY KEY (`user_id`)
);

-- =================
-- Tên bảng: departments
-- =================
CREATE TABLE `departments` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `manager_id` INT DEFAULT NULL,
  PRIMARY KEY (`department_id`)
);

-- =================
-- Tên bảng: employees
-- =================
CREATE TABLE `employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  `gender` ENUM('M','F') NOT NULL,
  `dob` DATE NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `address` TEXT,
  `department_id` INT NOT NULL,
  `hire_date` DATE NOT NULL,
  `position` VARCHAR(100) NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
);

ALTER TABLE `departments`
  ADD CONSTRAINT fk_manager
  FOREIGN KEY (`manager_id`) REFERENCES `employees` (`employee_id`);

-- =================
-- Tên bảng: attendance
-- =================
CREATE TABLE `attendance` (
  `attendance_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT,
  `date` DATE,
  `check_in` TIME,
  `check_out` TIME,
  PRIMARY KEY (`attendance_id`),
  FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
);

-- =================
-- Tên bảng: contracts
-- =================
CREATE TABLE `contracts` (
  `contract_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT,
  `contract_type` VARCHAR(100),
  `start_date` DATE,
  `end_date` DATE,
  `note` TEXT,
  PRIMARY KEY (`contract_id`),
  FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
);

-- =================
-- Tên bảng: leaves
-- =================
CREATE TABLE `leaves` (
  `leave_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT,
  `leave_type` ENUM('P','U','S'),
  `start_date` DATE,
  `end_date` DATE,
  `status` ENUM('pending','approved','rejected') DEFAULT 'pending',
  PRIMARY KEY (`leave_id`),
  FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
);

-- =================
-- Tên bảng: salary
-- =================
CREATE TABLE `salary` (
  `salary_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT,
  `month` INT,
  `year` INT,
  `basic_salary` DECIMAL(10,2) NOT NULL,
  `allowance` DECIMAL(10,2) DEFAULT 0.00,
  `bonus` DECIMAL(10,2) DEFAULT 0.00,
  `deduction` DECIMAL(10,2) DEFAULT 0.00,
  `total_salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`salary_id`),
  FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
);

-- =================
-- Tên bảng: rewards_discipline
-- =================
CREATE TABLE `rewards_discipline` (
  `record_id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` INT,
  `type` ENUM('reward','discipline'),
  `title` VARCHAR(255),
  `description` TEXT,
  `date_recorded` DATE,
  PRIMARY KEY (`record_id`),
  FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
); 

-- =================
-- Tên bảng: reports
-- =================
CREATE TABLE `reports` (
  `report_id` INT NOT NULL AUTO_INCREMENT,
  `report_name` TEXT,
  `report_description` TEXT,
  `report_type` ENUM('1','2','3','4') NOT NULL,
  `creation_datetime` DATETIME NOT NULL,
  PRIMARY KEY (`report_id`)
); 


-- =================
-- Dữ liệu mẫu: users
-- =================
INSERT INTO `users` (`user_id`, `username`, `password`, `role`) VALUES
(1, 'admin', 'admin123', 'admin'),
(2, 'hr01', 'hr123', 'hr'),
(3, 'employee1', 'employee1', 'employee');

-- =================
-- Dữ liệu mẫu: departments
-- =================
INSERT INTO `departments` (`department_id`, `name`) VALUES
(1, N'Phòng Nhân sự'),
(2, N'Phòng Kỹ thuật'),
(3, N'Phòng Hành chính');

-- =================
-- Dữ liệu mẫu: employees
-- =================
INSERT INTO `employees` (`employee_id`, `full_name`, `gender`, `dob`, `email`, `phone`, `address`, `department_id`, `hire_date`, `position`, `user_id`) VALUES
(1, N'Nguyễn Văn A', 'M', '1994-06-10', 'a@example.com', '0123456789', N'Hà Nội', 1, '2020-01-23', N'Trưởng phòng', 1),
(2, N'Trần Thị B', 'F', '1995-07-15', 'b@example.com', '0987654321', N'Đà Nẵng', 2, '2021-02-10', N'Nhân viên', 2),
(3, N'Lê Văn D', 'M', '1992-08-20', 'c@example.com', '0909090909', N'Hồ Chí Minh', 2, '2022-03-05', N'Kỹ sư', 3);

-- =================
-- Dữ liệu mẫu: attendance
-- =================
INSERT INTO `attendance` (`attendance_id`, `employee_id`, `date`, `check_in`, `check_out`) VALUES
(1, 2, '2025-05-20', '08:00:00', '17:00:00'),
(2, 3, '2025-05-20', '08:15:00', '17:10:00');

-- =================
-- Dữ liệu mẫu: contracts
-- =================
INSERT INTO `contracts` (`contract_id`, `employee_id`, `contract_type`, `start_date`, `end_date`, `note`) VALUES
(1, 2, N'Hợp đồng 1 năm', '2024-01-01', '2024-12-31', N'Thử việc'),
(2, 3, N'Hợp đồng 3 năm', '2023-06-01', '2026-06-01', N'Chính thức');

-- =================
-- Dữ liệu mẫu: leaves
-- =================
INSERT INTO `leaves` (`leave_id`, `employee_id`, `leave_type`, `start_date`, `end_date`, `status`) VALUES
(1, 2, 'P', '2025-05-01', '2025-05-02', 'approved'),
(2, 3, 'U', '2025-05-11', '2025-05-29', 'pending');

-- =================
-- Dữ liệu mẫu: salary
-- =================
INSERT INTO `salary` (`salary_id`, `employee_id`, `month`, `year`, `basic_salary`, `allowance`, `bonus`, `deduction`, `total_salary`) VALUES
(1, 2, 5, 2025, 10000000.00, 1500000.00, 500000.00, 200000.00, 11800000.00);

-- =================
-- Dữ liệu mẫu: rewards_discipline
-- =================
INSERT INTO `rewards_discipline` (`record_id`, `employee_id`, `type`, `title`, `description`, `date_recorded`) VALUES
(1, 2, 'reward', N'Nhân viên xuất sắc', N'Thành tích tốt trong công việc', '2025-04-30');

-- =================
-- Dữ liệu mẫu: reports
-- =================
INSERT INTO `reports` (`report_id`, `report_name`, `report_description`, `report_type`, `creation_datetime`) VALUES
(1, N'Báo cáo tháng 5', N'Tổng kết công việc tháng 5', '1', '2025-05-25 10:00:00');
