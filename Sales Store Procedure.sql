CREATE DATABASE IF NOT EXISTS sales_analytics;
USE sales_analytics;


CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    registration_date DATE,
    customer_segment ENUM('Premium', 'Standard', 'Basic') DEFAULT 'Standard'
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    subcategory VARCHAR(50),
    brand VARCHAR(50),
    unit_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    stock_quantity INT DEFAULT 0,
    launch_date DATE
);

CREATE TABLE sales_reps (
    rep_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    hire_date DATE,
    territory VARCHAR(50),
    commission_rate DECIMAL(4,2) DEFAULT 0.05
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    rep_id INT,
    order_date DATE,
    ship_date DATE,
    order_status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(12,2),
    discount_amount DECIMAL(10,2) DEFAULT 0.00,
    shipping_cost DECIMAL(8,2) DEFAULT 0.00,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (rep_id) REFERENCES sales_reps(rep_id)
);

CREATE TABLE order_details (
    detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_percent DECIMAL(5,2) DEFAULT 0.00,
    line_total DECIMAL(12,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

############### INSERTING DATA ######################

INSERT INTO customers (first_name, last_name, email, phone, city, state, country, registration_date, customer_segment) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101', 'New York', 'NY', 'USA', '2025-01-15', 'Premium'),
('Sarah', 'Johnson', 'sarah.j@email.com', '555-0102', 'Los Angeles', 'CA', 'USA', '2025-02-20', 'Standard'),
('Mike', 'Brown', 'mike.brown@email.com', '555-0103', 'Chicago', 'IL', 'USA', '2025-03-10', 'Basic'),
('Emma', 'Davis', 'emma.davis@email.com', '555-0104', 'Houston', 'TX', 'USA', '2025-04-05', 'Premium'),
('Robert', 'Wilson', 'r.wilson@email.com', '555-0105', 'Phoenix', 'AZ', 'USA', '2025-05-12', 'Standard'),
('Lisa', 'Garcia', 'lisa.garcia@email.com', '555-0106', 'Philadelphia', 'PA', 'USA', '2025-06-18', 'Premium'),
('David', 'Martinez', 'd.martinez@email.com', '555-0107', 'San Antonio', 'TX', 'USA', '2025-07-22', 'Basic'),
('Maria', 'Anderson', 'maria.a@email.com', '555-0108', 'San Diego', 'CA', 'USA', '2025-08-30', 'Standard'),
('James', 'Taylor', 'james.taylor@email.com', '555-0109', 'Dallas', 'TX', 'USA', '2025-09-14', 'Premium'),
('Jennifer', 'Thomas', 'jen.thomas@email.com', '555-0110', 'San Jose', 'CA', 'USA', '2025-10-25', 'Standard');

INSERT INTO products (product_name, category, subcategory, brand, unit_price, cost_price, stock_quantity, launch_date) VALUES
('Wireless Headphones Pro', 'Electronics', 'Audio', 'TechBrand', 199.99, 120.00, 150, '2025-01-01'),
('Smart Phone X1', 'Electronics', 'Mobile', 'PhoneCorp', 899.99, 550.00, 80, '2025-02-15'),
('Laptop Ultra', 'Electronics', 'Computers', 'CompuTech', 1299.99, 800.00, 45, '2025-03-01'),
('Gaming Mouse RGB', 'Electronics', 'Accessories', 'GameGear', 79.99, 45.00, 200, '2025-04-10'),
('4K Monitor 27"', 'Electronics', 'Displays', 'ViewTech', 399.99, 250.00, 75, '2025-05-20'),
('Mechanical Keyboard', 'Electronics', 'Accessories', 'TypeMaster', 149.99, 85.00, 120, '2025-06-05'),
('Wireless Speaker', 'Electronics', 'Audio', 'SoundWave', 129.99, 75.00, 180, '2025-07-12'),
('Tablet Pro 10"', 'Electronics', 'Mobile', 'TabletCorp', 549.99, 350.00, 60, '2025-08-18'),
('Smart Watch Series 5', 'Electronics', 'Wearables', 'WearTech', 299.99, 180.00, 95, '2025-09-25'),
('USB-C Hub', 'Electronics', 'Accessories', 'ConnectPro', 49.99, 25.00, 300, '2025-10-30'),
('Power Bank 10000mAh', 'Electronics', 'Mobile Accessories', 'Samsung', 1750.57, 1269.00, 43, '2024-02-05'),
('Webcam HD', 'Electronics', 'Computer Accessories', 'Mi', 1176.65, 1053.34, 151, '2024-04-05'),
('Bluetooth Speaker Mini', 'Electronics', 'Audio Devices', 'Zinq', 1227.34, 1024.04, 190, '2024-07-09'),
('Bluetooth Headphones', 'Electronics', 'Audio Devices', 'Apple', 3419.60, 2472.78, 292, '2024-09-25'),
('Smart Fitness Band', 'Electronics', 'Wearables', 'AmazonBasics', 3915.92, 2791.39, 37, '2024-07-08'),
('Gaming Mouse', 'Electronics', 'Computer Accessories', 'Zinq', 1326.43, 1161.33, 158, '2024-06-05'),
('Laptop Cooling Pad', 'Electronics', 'Computer Accessories', 'HP', 4304.80, 3430.38, 142, '2024-10-09'),
('Laptop Sleeve', 'Electronics', 'Computer Accessories', 'Dell', 4484.10, 3772.49, 206, '2024-06-14'),
('Smart Light Strip', 'Electronics', 'Others', 'Logitech', 1294.93, 946.97, 129, '2024-04-07'),
('Wireless Mouse', 'Electronics', 'Computer Accessories', 'AmazonBasics', 1999.42, 1621.65, 114, '2024-10-08'),
('HDMI Cable 2m', 'Electronics', 'Cables & Chargers', 'AmazonBasics', 1714.57, 1491.56, 264, '2024-06-24'),
('Power Bank 10000mAh', 'Electronics', 'Mobile Accessories', 'Sony', 3383.44, 2932.75, 250, '2024-05-20'),
('Smart Watch Series 7', 'Electronics', 'Wearables', 'Zinq', 4487.74, 3836.67, 55, '2024-07-24'),
('Wireless Keyboard', 'Electronics', 'Computer Accessories', 'Samsung', 3355.08, 3012.92, 94, '2024-01-16'),
('HDMI Cable 2m', 'Electronics', 'Cables & Chargers', 'Lenovo', 4292.98, 3283.01, 56, '2024-12-13'),
('SSD 1TB', 'Electronics', 'Storage Devices', 'Sony', 2232.70, 1608.71, 51, '2024-09-13'),
('Graphics Tablet', 'Electronics', 'Computer Accessories', 'HP', 1710.56, 1255.62, 87, '2024-11-12'),
('Noise Cancelling Headphones', 'Electronics', 'Audio Devices', 'Apple', 2019.18, 1466.69, 98, '2024-04-04'),
('Smartphone Holder', 'Electronics', 'Mobile Accessories', 'AmazonBasics', 3606.52, 3233.66, 238, '2024-03-11'),
('VR Headset', 'Electronics', 'Others', 'Sony', 2045.35, 1423.95, 213, '2024-02-08'),
('Smart Fitness Band', 'Electronics', 'Wearables', 'Sony', 3125.28, 2508.71, 85, '2024-06-10'),
('Wireless Mouse', 'Electronics', 'Computer Accessories', 'Apple', 4507.78, 3092.17, 242, '2024-01-27'),
('Mechanical Keyboard', 'Electronics', 'Computer Accessories', 'HP', 3400.23, 2794.39, 274, '2024-07-22'),
('Tablet Stand', 'Electronics', 'Mobile Accessories', 'Dell', 2286.51, 1866.48, 183, '2024-03-01'),
('Smart Watch Series 7', 'Electronics', 'Wearables', 'Sony', 4417.17, 3205.13, 290, '2024-10-28'),
('Fast Charging Adapter', 'Electronics', 'Mobile Accessories', 'Apple', 4105.72, 3193.83, 240, '2024-04-17'),
('Gaming Mouse', 'Electronics', 'Computer Accessories', 'Apple', 3213.70, 2867.78, 41, '2024-12-20'),
('Bluetooth Headphones', 'Electronics', 'Audio Devices', 'Zinq', 1925.20, 1566.36, 119, '2024-01-30'),
('USB Type-C Cable', 'Electronics', 'Cables & Chargers', 'Sony', 2246.63, 1725.38, 221, '2024-03-17'),
('Noise Cancelling Headphones', 'Electronics', 'Audio Devices', 'Sony', 4510.91, 3014.59, 134, '2024-05-28'),
('SSD 1TB', 'Electronics', 'Storage Devices', 'Zinq', 1571.62, 1145.44, 60, '2024-08-14'),
('Smart Light Strip', 'Electronics', 'Others', 'Logitech', 1996.17, 1631.93, 196, '2024-08-07'),
('Laptop Sleeve', 'Electronics', 'Computer Accessories', 'Lenovo', 1891.20, 1387.53, 52, '2024-03-20'),
('External Hard Drive 2TB', 'Electronics', 'Storage Devices', 'HP', 3687.88, 2971.64, 105, '2024-05-18'),
('Bluetooth Speaker Mini', 'Electronics', 'Audio Devices', 'Dell', 3884.30, 3045.50, 117, '2024-11-24'),
('Fast Charging Adapter', 'Electronics', 'Mobile Accessories', 'Sony', 4318.42, 2970.66, 113, '2024-12-06'),
('USB Type-C Cable', 'Electronics', 'Cables & Chargers', 'HP', 3746.40, 2962.57, 179, '2024-01-12'),
('Smartphone Holder', 'Electronics', 'Mobile Accessories', 'Sony', 1605.79, 1188.88, 93, '2024-08-26'),
('Graphics Tablet', 'Electronics', 'Computer Accessories', 'AmazonBasics', 4335.74, 3163.89, 94, '2024-05-11'),
('Wireless Keyboard', 'Electronics', 'Computer Accessories', 'AmazonBasics', 4314.41, 2993.31, 51, '2024-03-07'),
('Smart Light Strip', 'Electronics', 'Others', 'Lenovo', 1684.42, 1234.95, 46, '2024-06-26'),
('Laptop Cooling Pad', 'Electronics', 'Computer Accessories', 'Logitech', 3716.85, 2917.18, 134, '2024-10-02'),
('Wireless Mouse', 'Electronics', 'Computer Accessories', 'AmazonBasics', 3321.68, 2704.65, 180, '2024-09-05'),
('External Hard Drive 2TB', 'Electronics', 'Storage Devices', 'AmazonBasics', 3596.28, 3092.39, 63, '2024-07-13'),
('USB Hub 4-Port', 'Electronics', 'Computer Accessories', 'Lenovo', 4405.28, 3272.50, 195, '2024-02-28'),
('Mechanical Keyboard', 'Electronics', 'Computer Accessories', 'Zinq', 2233.35, 1644.90, 273, '2024-09-07'),
('Tablet Stand', 'Electronics', 'Mobile Accessories', 'Sony', 3256.71, 2982.90, 73, '2024-11-17'),
('VR Headset', 'Electronics', 'Others', 'Samsung', 1729.52, 1560.18, 91, '2024-05-07'),
('Bluetooth Headphones', 'Electronics', 'Audio Devices', 'HP', 3133.82, 2651.26, 287, '2024-02-01'),
('Smart Watch Series 7', 'Electronics', 'Wearables', 'HP', 3076.77, 2590.61, 49, '2024-08-02'),
('USB Hub 4-Port', 'Electronics', 'Computer Accessories', 'Lenovo', 3543.15, 2873.26, 150, '2024-11-01');


INSERT INTO sales_reps (first_name, last_name, email, hire_date, territory, commission_rate) VALUES
('Alex', 'Thompson', 'alex.t@company.com', '2022-03-15', 'West Coast', 0.06),
('Jessica', 'Lee', 'jessica.lee@company.com', '2022-07-20', 'East Coast', 0.05),
('Michael', 'Chen', 'michael.chen@company.com', '2022-11-10', 'Central', 0.055),
('Amanda', 'Rodriguez', 'amanda.r@company.com', '2025-01-25', 'South', 0.05),
('Kevin', 'Park', 'kevin.park@company.com', '2025-04-12', 'Northwest', 0.065);

INSERT INTO orders (customer_id, rep_id, order_date, ship_date, order_status, total_amount, discount_amount, shipping_cost) VALUES
(1, 1, '2024-01-15', '2024-01-17', 'Delivered', 1849.97, 50.00, 15.99),
(2, 2, '2024-01-20', '2024-01-22', 'Delivered', 729.98, 20.00, 12.99),
(3, 3, '2024-02-05', '2024-02-07', 'Delivered', 449.98, 0.00, 9.99),
(4, 1, '2024-02-12', '2024-02-14', 'Delivered', 1599.98, 100.00, 19.99),
(5, 4, '2024-02-18', '2024-02-20', 'Delivered', 179.98, 10.00, 8.99),
(6, 2, '2024-03-01', '2024-03-03', 'Delivered', 949.98, 0.00, 15.99),
(7, 5, '2024-03-10', '2024-03-12', 'Delivered', 229.98, 15.00, 7.99),
(8, 3, '2024-03-15', '2024-03-17', 'Delivered', 1199.98, 50.00, 18.99),
(9, 1, '2024-03-22', '2024-03-24', 'Delivered', 849.98, 25.00, 14.99),
(1, 4, '2024-04-05', '2024-04-07', 'Delivered', 329.98, 0.00, 11.99),
(3, 2, '2024-04-12', '2024-04-14', 'Processing', 679.98, 30.00, 13.99),
(5, 5, '2024-04-18', NULL, 'Pending', 799.98, 20.00, 16.99);

INSERT INTO order_details (order_id, product_id, quantity, unit_price, discount_percent, line_total) VALUES
-- Order 1
(1, 1, 2, 199.99, 5.00, 379.98),
(1, 2, 1, 899.99, 0.00, 899.99),
(1, 4, 3, 79.99, 10.00, 215.97),
(1, 6, 2, 149.99, 0.00, 299.98),
-- Order 2
(2, 3, 1, 1299.99, 15.00, 1104.99),
(2, 5, 1, 399.99, 0.00, 399.99),
-- Order 3
(3, 7, 2, 129.99, 0.00, 259.98),
(3, 9, 1, 299.99, 5.00, 284.99),
-- Order 4
(4, 8, 1, 549.99, 0.00, 549.99),
(4, 1, 3, 199.99, 8.00, 551.97),
-- Order 5
(5, 4, 1, 79.99, 0.00, 79.99),
(5, 10, 2, 49.99, 0.00, 99.98),
-- Continue for remaining orders...
(6, 2, 1, 899.99, 0.00, 899.99),
(6, 10, 1, 49.99, 0.00, 49.99),
(7, 6, 1, 149.99, 0.00, 149.99),
(7, 4, 1, 79.99, 0.00, 79.99),
(8, 3, 1, 1299.99, 0.00, 1299.99),
(9, 1, 2, 199.99, 0.00, 399.98),
(9, 7, 2, 129.99, 0.00, 259.98),
(9, 9, 1, 299.99, 5.00, 284.99),
(10, 7, 1, 129.99, 0.00, 129.99),
(10, 1, 1, 199.99, 0.00, 199.99),
(11, 5, 1, 399.99, 0.00, 399.99),
(11, 6, 2, 149.99, 0.00, 299.98),
(12, 8, 1, 549.99, 0.00, 549.99),
(12, 9, 1, 299.99, 0.00, 299.99);



Select * FROM customers;
Select * FROM order_details;
Select * FROM orders;
Select * FROM products;
Select * FROM sales_reps;



#####################################################################################################

DELIMITER //

	CREATE Procedure Getsalesummery() 
BEGIN
	-- Day wise Sales
    
    SELECT
    launch_date AS sale_day,
    SUM(unit_price * stock_quantity) AS daywise_sales,
    SUM(stock_quantity) AS daywise_quantity
  FROM products
  GROUP BY launch_date
  ORDER BY launch_date;
     
     -- Month wise Sales
     
	SELECT
    DATE_FORMAT(launch_date, '%Y-%m') AS sale_month,
    SUM(unit_price * stock_quantity) AS monthwise_sales,
    SUM(stock_quantity) AS monthwise_quantity
  FROM products
  GROUP BY DATE_FORMAT(launch_date, '%Y-%m')
  ORDER BY sale_month;
    
    -- Sub_category wise Sales
    
	SELECT
    subcategory,
    SUM(unit_price * stock_quantity) AS categorywise_sales,
    SUM(stock_quantity) AS categorywise_quantity
  FROM products
  GROUP BY subcategory
  ORDER BY categorywise_sales DESC;

        
END //

DELIMITER ;

Call Getsalesummery();

