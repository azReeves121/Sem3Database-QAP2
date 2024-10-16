 CREATE DATABASE Online_Store;

--  TABLE

-- Products table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT
);

-- Customers table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

-- Orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    order_date DATE
);

-- Order Items table
CREATE TABLE order_items (
    order_id INT REFERENCES orders(id),
    product_id INT REFERENCES products(id),
    quantity INT,
    PRIMARY KEY (order_id, product_id)

);



-- INSERT


-- Insert Products
INSERT INTO products (product_name, price, stock_quantity)
VALUES 
('Laptop', 1200.00, 10),
('Smartphone', 800.00, 15),
('Tablet', 600.00, 20),
('Headphones', 150.00, 30),
('Smartwatch', 250.00, 25);

-- Insert Customers
INSERT INTO customers (first_name, last_name, email)
VALUES 
('Alice', 'Wonderland', 'alice@example.com'),
('Bob', 'Builder', 'bob@example.com'),
('Charlie', 'Chaplin', 'charlie@example.com'),
('Dana', 'Scully', 'dana@example.com');

-- Insert Orders
INSERT INTO orders (customer_id, order_date)
VALUES 
(1, '2024-10-01'),
(2, '2024-10-02'),
(3, '2024-10-03'),
(4, '2024-10-04'),
(1, '2024-10-05');

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity)
VALUES 
(1, 1, 1), (1, 2, 2),
(2, 3, 1), (2, 4, 1),
(3, 5, 1), (3, 1, 1),
(4, 2, 1), (4, 3, 1),
(5, 4, 2), (5, 5, 1);


-- -QUERIES

-- Retrieve the names and stock quantities of all products
SELECT product_name, stock_quantity FROM products;

-- Retrieve the product names and quantities for one of the orders placed
SELECT p.product_name, oi.quantity
FROM order_items oi
JOIN products p ON oi.product_id = p.id
WHERE oi.order_id = 1;

-- Retrieve all orders placed by a specific customer (including the ID’s of what was ordered and the quantities)
SELECT o.id AS order_id, p.product_name, oi.quantity
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE o.customer_id = 1;


-- UPDATE


-- Simulate reducing stock quantities of items for order 1
UPDATE products
SET stock_quantity = stock_quantity - 1
WHERE id = 1;

UPDATE products
SET stock_quantity = stock_quantity - 2
WHERE id = 2;


-- DELETE 


-- Remove one of the orders and all associated order items
DELETE FROM order_items
WHERE order_id = 1;

DELETE FROM orders
WHERE id = 1;

