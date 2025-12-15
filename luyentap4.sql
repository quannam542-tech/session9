create schema luyentap4;
set search_path to luyentap4
;
-- Bảng Customer
    CREATE TABLE Customer (
                              customer_id INT PRIMARY KEY,
                              customer_name VARCHAR(100) NOT NULL,
                              phone VARCHAR(20),
                              email VARCHAR(100)
    );

    -- Bảng Product
    CREATE TABLE Product (
                             product_id INT PRIMARY KEY,
                             product_name VARCHAR(100) NOT NULL,
                             price DECIMAL(10,2)
    );
    CREATE TABLE Sales (
                           sale_id INT PRIMARY KEY,
                           customer_id INT,
                           product_id INT,
                           sale_date DATE,
                           amount DECIMAL(10,2),
                           FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
                           FOREIGN KEY (product_id) REFERENCES Product(product_id)
    );
-- Insert Customers
INSERT INTO Customer (customer_id, customer_name, phone, email)
VALUES
    (1, 'Nguyen Van A', '0901234567', 'vana@example.com'),
    (2, 'Tran Thi B', '0912345678', 'thib@example.com'),
    (3, 'Le Van C', '0923456789', 'vanc@example.com');

-- Insert Products
INSERT INTO Product (product_id, product_name, price)
VALUES
    (101, 'Laptop Dell XPS 13', 25000.00),
    (102, 'iPhone 15 Pro', 32000.00),
    (103, 'Samsung Galaxy Tab', 18000.00);

-- Insert Sales
INSERT INTO Sales (sale_id, customer_id, product_id, sale_date, amount)
VALUES
    (1001, 1, 101, '2025-12-01', 25000.00),
    (1002, 2, 102, '2025-12-05', 32000.00),
    (1003, 3, 103, '2025-12-10', 18000.00),
    (1004, 1, 102, '2025-12-12', 32000.00);
--Muốn tổng hợp tổng amount theo từng khách hàng
SELECT c.customer_id,
       c.customer_name,
       SUM(s.amount) AS total_amount
FROM Sales s
         JOIN Customer c ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_amount DESC;
-- băng view
CREATE VIEW CustomerSales AS
SELECT s.customer_id,
       SUM(s.amount) AS total_amount
FROM Sales s
GROUP BY s.customer_id;
--.Dùng view vừa tạo để lọc khách hàng có tổng mua > 1000:
SELECT *
FROM CustomerSales
WHERE total_amount > 1000;
--truy vấn trên view báo lõi
UPDATE CustomerSales
SET total_amount = 999999
WHERE customer_id = 1;

