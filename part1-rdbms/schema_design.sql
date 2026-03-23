-- DROP (to avoid errors)
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sales_reps;

-- CREATE TABLES
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_name TEXT NOT NULL,
    city TEXT NOT NULL
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    product_name TEXT NOT NULL,
    price REAL NOT NULL
);

CREATE TABLE sales_reps (
    rep_id INTEGER PRIMARY KEY AUTOINCREMENT,
    rep_name TEXT NOT NULL
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    order_date TEXT NOT NULL,
    customer_id INTEGER,
    rep_id INTEGER,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (rep_id) REFERENCES sales_reps(rep_id)
);

CREATE TABLE order_details (
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- INSERT DATA
INSERT INTO customers (customer_name, city) VALUES
('Rohit', 'Mumbai'),
('Amit', 'Delhi'),
('Sneha', 'Mumbai'),
('Priya', 'Bangalore'),
('Karan', 'Pune');

INSERT INTO products (product_name, price) VALUES
('Laptop', 50000),
('Mouse', 500),
('Keyboard', 1500),
('Monitor', 12000),
('Tablet', 30000);

INSERT INTO sales_reps (rep_name) VALUES
('Raj'),
('Simran'),
('Arjun'),
('Neha'),
('Vikram');

INSERT INTO orders (order_id, order_date, customer_id, rep_id) VALUES
(1, '2025-01-01', 1, 1),
(2, '2025-01-02', 2, 2),
(3, '2025-01-03', 3, 3),
(4, '2025-01-04', 4, 4),
(5, '2025-01-05', 5, 5);

INSERT INTO order_details (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 4, 1),
(4, 5, 1);
