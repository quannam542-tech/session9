create schema luyentap2;
set search_path to luyentap2
;
CREATE TABLE Users (
                       user_id INT PRIMARY KEY,
                       email VARCHAR(100) UNIQUE,
                       username VARCHAR(50)
);
INSERT INTO Users (user_id, email, username)
VALUES
    (1, 'vana@example.com', 'nguyenvana'),
    (2, 'thib@example.com', 'tranthib'),
    (3, 'vanc@example.com', 'levanc');
EXPLAIN SELECT * FROM Users WHERE email = 'vana@example.com';

CREATE INDEX idx_users_email_hash
    ON Users USING HASH (email);

EXPLAIN SELECT * FROM Users WHERE email = 'vana@example.com';