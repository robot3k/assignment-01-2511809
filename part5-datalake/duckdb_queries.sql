-- Q1: List all customers along with the total number of orders they have placed
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders
FROM 'C:\Users\angry\OneDrive\Desktop\Assignment Module 2\customers.csv' c
LEFT JOIN read_json_auto('C:\Users\angry\OneDrive\Desktop\Assignment Module 2\orders.json') o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

-- Q2: Find the top 3 customers by total order value
SELECT 
    c.name,
    SUM(o.total_amount) AS total_spent
FROM read_json_auto('C:\Users\angry\OneDrive\Desktop\Assignment Module 2\orders.json') o
JOIN 'C:\Users\angry\OneDrive\Desktop\Assignment Module 2\customers.csv' c
ON o.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
SELECT 
    c.name,
    p.product_name
FROM 'C:\Users\angry\OneDrive\Desktop\Assignment Module 2\customers.csv' c
JOIN read_json_auto('C:\Users\angry\OneDrive\Desktop\Assignment Module 2\orders.json') o
ON c.customer_id = o.customer_id
JOIN 'C:\Users\angry\OneDrive\Desktop\Assignment Module 2\products.parquet' p
ON o.order_id = p.order_id
WHERE c.city = 'Bangalore';

-- Q4: Join all three files to show customer name, order date, product name, and quantity
SELECT 
    c.name AS customer_name,
    o.order_date,
    p.product_name,
    p.quantity
FROM read_json_auto('C:\Users\angry\OneDrive\Desktop\Assignment Module 2\orders.json') o
JOIN 'C:\Users\angry\OneDrive\Desktop\Assignment Module 2\customers.csv' c
ON o.customer_id = c.customer_id
JOIN 'C:\Users\angry\OneDrive\Desktop\Assignment Module 2\products.parquet' p
ON o.order_id = p.order_id;
