

create schema luyentap6;
set search_path to luyentap6;
CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          price NUMERIC,
                          category_id INT
);
INSERT INTO products (name, price, category_id)
VALUES
    ('Laptop Dell XPS 13', 25000000, 1),
    ('Chuột Logitech MX Master 3', 1500000, 2),
    ('Bàn phím cơ Keychron K2', 1800000, 2),
    ('Tai nghe Sony WH-1000XM5', 6000000, 3),
    ('Màn hình LG UltraFine 27"', 12000000, 4);
CREATE OR REPLACE PROCEDURE update_product_price(
    p_category_id INT,
    p_increase_percent NUMERIC
)
    LANGUAGE plpgsql
AS $$
DECLARE
    v_product_id INT;
    v_old_price NUMERIC;
    v_new_price NUMERIC;
BEGIN

    FOR v_product_id, v_old_price IN
        SELECT product_id, price
        FROM products
        WHERE category_id = p_category_id
        LOOP

            v_new_price := v_old_price * (1 + p_increase_percent / 100);


            UPDATE products
            SET price = v_new_price
            WHERE product_id = v_product_id;

            RAISE NOTICE 'Product %: old price = %, new price = %',
                v_product_id, v_old_price, v_new_price;
        END LOOP;
END;
$$;