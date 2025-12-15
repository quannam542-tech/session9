create schema luyentap5;
set search_path to luyentap5
;
CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           customer_name VARCHAR(100),
                           email VARCHAR(100),
                           phone VARCHAR(20)
);
CREATE TABLE sales (
                       sale_id SERIAL PRIMARY KEY,
                       customer_id INT REFERENCES customers(customer_id),
                       amount NUMERIC,
                       sale_date DATE
);
INSERT INTO customers (customer_name, email, phone)
VALUES
    ('Nguyễn Văn An', 'an.nguyen@example.com', '0901234567'),
    ('Trần Thị Bình', 'binh.tran@example.com', '0912345678'),
    ('Lê Văn Cường', 'cuong.le@example.com', '0923456789');
INSERT INTO sales (customer_id, amount, sale_date)
VALUES
    (1, 5000000, '2025-12-01'),
    (2, 3000000, '2025-12-05'),
    (1, 2000000, '2025-12-10'),
    (3, 8000000, '2025-12-12');
CREATE OR REPLACE PROCEDURE calculate_total_sales(
    start_date DATE,
    end_date DATE,
    OUT total NUMERIC
)
    LANGUAGE plpgsql
AS $$
BEGIN
    -- Tính tổng amount trong khoảng thời gian
    SELECT COALESCE(SUM(amount), 0)
    INTO total
    FROM sales
    WHERE sale_date BETWEEN start_date AND end_date;
END;
$$;
CALL calculate_total_sales('2025-12-01', '2025-12-10');
