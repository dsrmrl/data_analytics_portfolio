DROP DATABASE IF EXISTS `d_hr`;
CREATE DATABASE `d_hr`;
USE `d_hr`;


CREATE TABLE `offices` (
  `office_id` int(11) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  PRIMARY KEY (`office_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `offices` (`office_id`, `address`, `city`, `state`)
VALUES
(1, '555 Broadway', 'New York', 'NY'),
(2, '777 Wall St', 'Buffalo', 'NY'),
(3, '789 High St', 'Columbus', 'OH'),
(4, '101 River Rd', 'Cleveland', 'OH'),
(5, '123 Main St', 'Los Angeles', 'CA'),
(6, '456 Sunset Blvd', 'San Francisco', 'CA'),
(7, '987 Market St', 'Chicago', 'IL'),
(8, '654 Lake Shore Dr', 'Miami', 'FL'),
(9, '321 Windy Ave', 'New Orleans', 'LA'),
(10, '147 River Rd', 'Houston', 'TX');



CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `job_title` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `reports_to` int(11) DEFAULT NULL,
  `office_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `fk_employees_offices_idx` (`office_id`),
  KEY `fk_employees_employees_idx` (`reports_to`),
  CONSTRAINT `fk_employees_managers` FOREIGN KEY (`reports_to`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_employees_offices` FOREIGN KEY (`office_id`) REFERENCES `offices` (`office_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `employees` (`employee_id`, `first_name`, `last_name`, `job_title`, `salary`, `reports_to`, `office_id`)
VALUES
-- Top position (CEO)
(1, 'John', 'Smith', 'Chief Executive Officer', 200000, NULL, 1),  

-- Vice Presidents (Reports to CEO)
(2, 'Sarah', 'Johnson', 'Vice President of Sales', 150000, 1, 2),  
(3, 'Michael', 'Brown', 'Vice President of Operations', 150000, 1, 3),  

-- Sales & Marketing Department (Reports to VP Sales)
(4, 'Emily', 'Davis', 'Sales Manager', 90000, 2, 2),  
(5, 'David', 'Wilson', 'Account Executive', 75000, 2, 2),  
(6, 'Sophia', 'Martinez', 'Marketing Manager', 95000, 2, 3),  
(7, 'Ethan', 'Rodriguez', 'Sales Associate', 60000, 2, 2),  
(8, 'Liam', 'Walker', 'Marketing Coordinator', 65000, 2, 3),  

-- Operations & Logistics Department (Reports to VP Operations)
(9, 'Daniel', 'Anderson', 'Operations Manager', 100000, 3, 3),  
(10, 'Olivia', 'Thomas', 'Logistics Coordinator', 80000, 3, 3),  
(11, 'James', 'Harris', 'Warehouse Supervisor', 70000, 3, 3),  
(12, 'Emma', 'Clark', 'Customer Support Manager', 85000, 3, 1),  
(13, 'Lucas', 'Young', 'Supply Chain Analyst', 72000, 3, 3),  
(14, 'Mason', 'Lee', 'Procurement Specialist', 75000, 3, 3),  

-- Additional Employees
(15, 'Ava', 'Hall', 'HR Manager', 95000, 1, 1),  -- Reports to CEO (HR role)
(16, 'Noah', 'Allen', 'Financial Analyst', 88000, 1, 1),  -- Reports to CEO (Finance role)
(17, 'Charlotte', 'Scott', 'Sales Associate', 62000, 2, 2),  -- Reports to VP Sales
(18, 'Elijah', 'Adams', 'Customer Service Rep', 58000, 3, 1),  -- Reports to VP Operations
(19, 'Benjamin', 'White', 'Operations Assistant', 60000, 3, 3),  -- Reports to VP Operations
(20, 'Isabella', 'Harris', 'Marketing Intern', 40000, 2, 3);  -- Reports to VP Sales




