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
('USB-C Hub', 'Electronics', 'Accessories', 'ConnectPro', 49.99, 25.00, 300, '2025-10-30');

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

#########################################################

Select * FROM customers;
Select * FROM order_details;
Select * FROM orders;
Select * FROM products;
Select * FROm sales_reps;

#################### QUERY-1 ##########################

Select 
order_id,
customer_id,
total_amount,
discount_amount,
(Select Count(*)
FROM orders),
(Select COUNT(DISTINCT customer_id) FROM orders),
(Select SUM(total_amount) FROM orders
);

Select count(*) as orders , Count(distinct customer_id) as Total_cus, sum(total_amount) as Toatl_rev, AVG(total_amount) as AVG_amount, SUM(discount_amount) as Total_dis FROM orders ;

Select product_name, SUM(line_total) rev, SUM(quantity) qt FROM order_details od
JOIN products pd ON od.product_id= pd.product_id
JOIN orders os ON od.order_id = os.order_id
WHERE order_status = "Delivered"
group by pd.product_name
order by rev DESC;

SELECT YEAR (sysdate()),
MONTH (sysdate()),
monthname(sysdate()) FROM DUAL;

Select YEAR (order_date) yr,
Month (order_date) mt,
Monthname(order_date) mn , 
COUNT(order_id) , SUM(total_amount) ta FROM orders od
WHERE order_status = "Delivered"
GROUP BY yr,mt,mn
ORDER BY ta DESC;

SELECT 
    customer_segment,
    COUNT(DISTINCT od.customer_id) as ci,
    COUNT(order_id) as td,
    SUM(total_amount) as tr,
    AVG(total_amount) as ag,
    SUM(total_amount) / COUNT(DISTINCT od.customer_id) as rc
FROM customers cs
LEFT JOIN orders od ON cs.customer_id = od.customer_id
WHERE od.order_status = 'Delivered' OR od.order_status IS NULL
GROUP BY cs.customer_segment
ORDER BY tr DESC;


SELECT 
    CONCAT(sr.first_name, ' ', sr.last_name) as sr,
    sr.territory,
    COUNT(od.order_id) as oh,
    SUM(od.total_amount) as ts,
    AVG(od.total_amount) as ads,
    SUM(od.total_amount) * sr.commission_rate as estimated_commission
FROM sales_reps sr
LEFT JOIN orders od ON sr.rep_id = od.rep_id
WHERE od.order_status = 'Delivered' OR od.order_status IS NULL
GROUP BY sr.rep_id, sr.first_name, sr.last_name, sr.territory, sr.commission_rate
ORDER BY ts DESC;


SELECT 
    pd.category,
    COUNT(DISTINCT pd.product_id) as pc,
    SUM(od.quantity) as us,
    SUM(od.line_total) as cr,
    AVG(pd.unit_price) as ap,
    SUM(od.line_total) / SUM(od.quantity) as au
FROM products pd
LEFT JOIN order_details od ON pd.product_id = od.product_id
LEFT JOIN orders os ON od.order_id = os.order_id
WHERE os.order_status = 'Delivered' OR os.order_status IS NULL
GROUP BY pd.category
HAVING cr > 0
ORDER BY cr DESC;


SELECT 
    p.product_name,
    p.category,
    SUM(od.quantity) as units_sold,
    SUM(od.line_total) as revenue,
    SUM(od.quantity * p.cost_price) as total_cost,
    SUM(od.line_total) - SUM(od.quantity * p.cost_price) as profit,
    ROUND(((SUM(od.line_total) - SUM(od.quantity * p.cost_price)) / SUM(od.line_total)) * 100, 2) as profit_margin_percent
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category
HAVING units_sold > 0
ORDER BY profit DESC;

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) as customer_name,
    c.customer_segment,
    COUNT(o.order_id) as total_orders,
    MIN(o.order_date) as first_order_date,
    MAX(o.order_date) as last_order_date,
    SUM(o.total_amount) as lifetime_value,
    AVG(o.total_amount) as avg_order_value,
    DATEDIFF(MAX(o.order_date), MIN(o.order_date)) as customer_lifespan_days
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Delivered'
GROUP BY c.customer_id, c.first_name, c.last_name, c.customer_segment
ORDER BY lifetime_value DESC;


SELECT 
    p.product_name,
    p.category,
    p.stock_quantity,
    COALESCE(SUM(od.quantity), 0) as total_sold,
    p.stock_quantity - COALESCE(SUM(od.quantity), 0) as remaining_stock,
    CASE 
        WHEN p.stock_quantity - COALESCE(SUM(od.quantity), 0) < 50 THEN 'Low Stock'
        WHEN p.stock_quantity - COALESCE(SUM(od.quantity), 0) < 100 THEN 'Medium Stock'
        ELSE 'High Stock'
    END as stock_status,
    COALESCE(SUM(od.line_total), 0) as total_revenue
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
LEFT JOIN orders o ON od.order_id = o.order_id AND o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category, p.stock_quantity
ORDER BY remaining_stock ASC;








