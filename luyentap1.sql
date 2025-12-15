create schema luyentap1;
set search_path to luyentap1
;
CREATE TABLE Customers (
                           customer_id INT PRIMARY KEY,
                           customer_name VARCHAR(100),
                           email VARCHAR(100),
                           phone VARCHAR(20),
                           address VARCHAR(200)
);
CREATE TABLE Orders (
                        order_id INT PRIMARY KEY,
                        customer_id INT,
                        order_date DATE,
                        total_amount DECIMAL(10,2),
                        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
INSERT INTO Orders (order_id, customer_id, order_date, total_amount)
VALUES
    (1, 101, '2025-12-01', 250.00),
    (2, 102, '2025-12-05', 450.50),
    (3, 103, '2025-12-10', 120.75);
INSERT INTO Customers (customer_id, customer_name, email, phone, address)
VALUES
    (101, 'Nguyen Van A', 'vana@example.com', '0901234567', 'Hà Nội'),
    (102, 'Tran Thi B', 'thib@example.com', '0912345678', 'Đà Nẵng'),
    (103, 'Le Van C', 'vanc@example.com', '0923456789', 'TP. Hồ Chí Minh');
--1
-- Tạo Index trên cột customer_id
CREATE INDEX idx_orders_customer_id
    ON Orders (customer_id);

SELECT * FROM Orders WHERE customer_id = 101;

EXPLAIN SELECT * FROM Orders WHERE customer_id = 101;
-- --Seq Scan on orders  (cost=0.00..1.04 rows=1 width=28)
-- Filter: (customer_id = 101)
