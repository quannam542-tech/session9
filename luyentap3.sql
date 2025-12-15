create schema luyentap3;
set search_path to luyentap3
;
CREATE TABLE Category (
                          category_id INT PRIMARY KEY,
                          category_name VARCHAR(100) NOT NULL
);
CREATE TABLE Products (
                          product_id INT PRIMARY KEY,
                          category_id INT,
                          price DECIMAL(10,2),
                          stock_quantity INT,
                          FOREIGN KEY (category_id) REFERENCES Category(category_id)
);
-- Thêm dữ liệu vào bảng Category
INSERT INTO Category (category_id, category_name)
VALUES
    (1, 'Điện thoại'),
    (2, 'Laptop'),
    (3, 'Phụ kiện');

-- Thêm dữ liệu vào bảng Products
INSERT INTO Products (product_id, category_id, price, stock_quantity)
VALUES
    (101, 1, 15000000, 20),
    (102, 2, 25000000, 15),
    (103, 3, 500000, 100);
--1
-- Tạo index trên category_id
CREATE INDEX idx_products_category
    ON Products (category_id);

-- Tạo index trên price
CREATE INDEX idx_products_price
    ON Products (price);



-- Truy vấn
SELECT *
FROM Products
WHERE category_id = 2
ORDER BY price;