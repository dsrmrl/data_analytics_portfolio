
DROP DATABASE IF EXISTS `d_store`;
CREATE DATABASE `d_store`;
USE `d_store`;

-- Create `products` table
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `quantity_in_stock` INT NOT NULL,
  `unit_price` DECIMAL(5,2) NOT NULL,  -- Increased precision to 5,2 for better pricing support
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Populate `products`
INSERT INTO `products` (`name`, `quantity_in_stock`, `unit_price`) VALUES
('Party Needs - Birthday Banner', 36, 1.21),
('Meat - Chicken Breast, Magnolia', 15, 4.65),
('Condiments - Black Pepper', 25, 0.35),
('Veggies - Chinese Cabbage, Spuds', 90, 3.53),
('Sauce - Caesar Salad', 72, 1.63),
('Bread - Petit Baguette', 55, 2.39),
('Sun Valley- Sweet Potato', 99, 3.29),
('Island Fresh Picks - Strawberry', 35, 2.74),
('Fruits - Oranges', 67, 2.26),
('Snacks - Curly Pretzels', 16, 1.09),
('Bread - Daisy Muffins', 34, 2.20),
('Personal - Dove Shampoo', 45, 1.09);

-- Create `shippers` table
DROP TABLE IF EXISTS `shippers`;
CREATE TABLE `shippers` (
  `shipper_id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`shipper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Populate `shippers`
INSERT INTO `shippers` (`name`) VALUES
('SwiftExpress Logistics'),
('BlueSky Freight'),
('Titanic Cargo Solutions'),
('EagleWing Couriers');

-- Create `customers` table
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `birth_date` DATE DEFAULT NULL,
  `phone` VARCHAR(20) DEFAULT NULL,  -- Reduced length to 20 for consistency
  `address` VARCHAR(100) NOT NULL,  -- Increased length for better address storage
  `city` VARCHAR(50) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `points` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Populate `customers`
INSERT INTO `customers` (`first_name`, `last_name`, `birth_date`, `phone`, `address`, `city`, `state`, `points`) VALUES
('Emily', 'Johnson', '1985-06-15', '555-1234', '123 Oak St', 'New York', 'NY', 500),
('Daniel', 'Smith', '1990-09-22', '555-5678', '456 Pine St', 'Buffalo', 'NY', 3755),
('Sophia', 'Williams', '1988-04-10', '555-8765', '789 Maple Ave', 'Los Angeles', 'CA', 750),
('Liam', 'Brown', '1995-12-05', '555-4321', '147 Birch Rd', 'Chicago', 'IL', 2650),
('Ava', 'Davis', '1982-07-19', '555-9876', '369 Elm St', 'Miami', 'FL', 900),
('Mason', 'Miller', '1998-11-02', '555-1111', '852 Cedar Dr', 'Dallas', 'TX', 5000),
('Isabella', 'Martinez', '1993-05-25', '555-2222', '963 Walnut Ln', 'Phoenix', 'AZ', 1785),
('Noah', 'Anderson', '1987-08-14', '555-3333', '357 Redwood Ct', 'Seattle', 'WA', 2935),
('Charlotte', 'Taylor', '1991-03-30', '555-4444', '654 Palm Blvd', 'Boston', 'MA', 4325),
('Elijah', 'Harris', '1996-01-12', '555-5555', '951 Cypress Ave', 'Denver', 'CO', 2500);

-- Create `order_statuses` table
CREATE TABLE `order_statuses` (
  `order_status_id` TINYINT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`order_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Populate `order_statuses`
INSERT INTO `order_statuses` VALUES
(1, 'Processed'),
(2, 'Shipped'),
(3, 'Delivered');

-- Create `orders` table with foreign keys
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `status` TINYINT NOT NULL DEFAULT 1,
  `comments` VARCHAR(2000) DEFAULT NULL,
  `shipped_date` DATE DEFAULT NULL,
  `shipper_id` SMALLINT DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE CASCADE,
  FOREIGN KEY (`status`) REFERENCES `order_statuses` (`order_status_id`) ON DELETE CASCADE,
  FOREIGN KEY (`shipper_id`) REFERENCES `shippers` (`shipper_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `orders` (`customer_id`, `order_date`, `status`, `comments`, `shipped_date`, `shipper_id`)
VALUES
(1, '2024-01-15', 1, 'Urgent delivery requested.', NULL, NULL),  
(2, '2024-02-10', 2, 'Customer requested signature on delivery.', '2024-02-15', 3),  
(3, '2024-03-05', 1, NULL, NULL, NULL),  
(4, '2024-04-20', 2, 'Handle with care - fragile items.', '2024-04-25', 1),  
(5, '2024-05-30', 2, NULL, '2024-06-03', 2),  
(6, '2024-07-12', 1, 'Customer will pick up in store.', NULL, NULL),  
(7, '2024-09-18', 2, NULL, '2024-09-22', 3),  
(8, '2024-10-05', 1, 'Gift order - do not include receipt.', NULL, NULL),  
(9, '2024-11-25', 2, 'Expedited shipping requested.', '2024-11-28', 2),  
(10, '2025-01-10', 1, NULL, NULL, NULL);

-- Create `order_items` table with corrected structure
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`order_id`, `product_id`),
  FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE,
  FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Populate `order_items`
INSERT INTO `order_items` (`order_id`, `product_id`, `quantity`, `unit_price`) VALUES
(1, 1, 10, 1.21),
(1, 3, 5, 0.35),
(2, 2, 8, 4.65),
(2, 5, 12, 1.63),
(3, 4, 15, 3.53),
(3, 7, 20, 3.29),  
(4, 9, 6, 2.26),  
(4, 8, 14, 2.74),  
(5, 1, 25, 1.21),  
(5, 2, 18, 4.65),  
(6, 3, 9, 0.35),  
(6, 5, 7, 1.63),  
(7, 4, 30, 3.53),  
(7, 7, 15, 3.29),  
(8, 9, 10, 2.26),  
(8, 8, 9, 2.74),  
(9, 1, 12, 1.21),  
(9, 2, 5, 4.65),  
(10, 3, 8, 0.35),  
(10, 5, 6, 1.63);





