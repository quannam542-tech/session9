create schema luyentap7;
set search_path to luyentap7;
CREATE TABLE customers (
                           customer_id SERIAL PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           email VARCHAR(100) UNIQUE
);
CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        customer_id INT NOT NULL,
                        amount NUMERIC(10,2),
                        order_date DATE,
                        CONSTRAINT fk_customer
                            FOREIGN KEY (customer_id)
                                REFERENCES customers(customer_id)
                                ON DELETE CASCADE
);
INSERT INTO customers (name, email) VALUES
                                        ('Nguyen Van A', 'a@gmail.com'),
                                        ('Tran Thi B', 'b@gmail.com');

INSERT INTO orders (customer_id, amount, order_date) VALUES
                                                         (1, 500000, '2025-12-01'),
                                                         (1, 300000, '2025-12-05'),
                                                         (2, 700000, '2025-12-06');



create or REPLACE PROCEDURE add_order(p_customer_id INT, p_amount NUMERIC)

language plpgsql
as $$
    declare truyen_id int;
begin
    select order_id into truyen_id
        from orders
        where order_id = p_customer_id;



    if truyen_id is null then
        RAISE EXCEPTION 'Không tìm thấy sản phẩm với id %', p_customer_id;
    end if;

    if truyen_id =0 then
        RAISE EXCEPTION 'Không tìm thấy sản phẩm với id %', p_customer_id;
    end if;

insert INTO orders (customer_id, amount, order_date)
VALUES
    (p_customer_id, p_amount,  CURRENT_DATE);

    end;


$$
;
CALL add_order(1, 250000);