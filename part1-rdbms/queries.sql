-- Q1
SELECT c.customer_name, SUM(p.price * od.quantity) AS total_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE c.city = 'Mumbai'
GROUP BY c.customer_name;

-- Q2
SELECT p.product_name, SUM(od.quantity) AS total_quantity
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 3;

-- Q3
SELECT sr.rep_name, COUNT(DISTINCT o.customer_id) AS customers_handled
FROM sales_reps sr
JOIN orders o ON sr.rep_id = o.rep_id
GROUP BY sr.rep_name;

-- Q4
SELECT o.order_id, SUM(p.price * od.quantity) AS total_value
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY o.order_id
HAVING SUM(p.price * od.quantity) > 10000
ORDER BY total_value DESC;

-- Q5
SELECT p.product_name
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
WHERE od.product_id IS NULL;
