-- =============================================================================
-- Part 3.2: Analytical Queries for Retail Data Warehouse
-- =============================================================================

-- =============================================================================
-- Q1: Total sales revenue by product category for each month
-- =============================================================================
-- Q1: Total sales revenue by product category for each month
-- This query analyzes revenue distribution across product categories over time,
-- enabling business users to identify seasonal trends and category performance.
SELECT 
    d.year,
    d.month,
    d.month_name,
    p.category,
    SUM(f.revenue) AS total_revenue,
    COUNT(f.sales_key) AS transaction_count
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY d.year, d.month, d.month_name, p.category
ORDER BY d.year, d.month, p.category;

-- =============================================================================
-- Q2: Top 2 performing stores by total revenue
-- =============================================================================
-- Q2: Top 2 performing stores by total revenue
-- This query identifies the best-performing store locations based on total revenue,
-- helping management understand which locations are driving the most business value.
SELECT 
    s.store_name,
    s.store_city,
    SUM(f.revenue) AS total_revenue,
    COUNT(f.sales_key) AS total_transactions,
    AVG(f.revenue) AS avg_transaction_value
FROM fact_sales f
JOIN dim_store s ON f.store_key = s.store_key
GROUP BY s.store_name, s.store_city
ORDER BY total_revenue DESC
LIMIT 2;

-- =============================================================================
-- Q3: Month-over-month sales trend across all stores
-- =============================================================================
-- Q3: Month-over-month sales trend across all stores
-- This query provides month-over-month comparison of sales performance,
-- enabling trend analysis and identification of growth or decline patterns.
WITH monthly_sales AS (
    SELECT 
        d.year,
        d.month,
        d.month_name,
        SUM(f.revenue) AS monthly_revenue,
        COUNT(f.sales_key) AS transaction_count
    FROM fact_sales f
    JOIN dim_date d ON f.date_key = d.date_key
    GROUP BY d.year, d.month, d.month_name
),
previous_month AS (
    SELECT 
        year,
        month,
        month_name,
        monthly_revenue,
        LAG(monthly_revenue) OVER (ORDER BY year, month) AS previous_month_revenue
    FROM monthly_sales
)
SELECT 
    year,
    month,
    month_name,
    monthly_revenue AS current_month_revenue,
    previous_month_revenue,
    (monthly_revenue - previous_month_revenue) AS revenue_change,
    CASE 
        WHEN previous_month_revenue IS NULL THEN NULL
        WHEN monthly_revenue > previous_month_revenue THEN 'INCREASE'
        WHEN monthly_revenue < previous_month_revenue THEN 'DECREASE'
        ELSE 'NO CHANGE'
    END AS trend_direction,
    CASE 
        WHEN previous_month_revenue IS NULL OR previous_month_revenue = 0 THEN NULL
        ELSE ROUND(((monthly_revenue - previous_month_revenue) / previous_month_revenue) * 100, 2)
    END AS percentage_change
FROM previous_month
ORDER BY year, month;

-- =============================================================================
-- ADDITIONAL USEFUL QUERIES (for reference)
-- =============================================================================

-- Quarterly revenue summary by category
SELECT 
    d.year,
    d.quarter,
    p.category,
    SUM(f.revenue) AS quarterly_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY d.year, d.quarter, p.category
ORDER BY d.year, d.quarter, p.category;

-- Store performance by category
SELECT 
    s.store_name,
    s.store_city,
    p.category,
    SUM(f.revenue) AS category_revenue,
    COUNT(f.sales_key) AS transaction_count
FROM fact_sales f
JOIN dim_store s ON f.store_key = s.store_key
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY s.store_name, s.store_city, p.category
ORDER BY s.store_name, category_revenue DESC;

-- Top selling products by revenue
SELECT 
    p.product_name,
    p.category,
    SUM(f.units_sold) AS total_units_sold,
    SUM(f.revenue) AS total_revenue
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
GROUP BY p.product_name, p.category
ORDER BY total_revenue DESC;
