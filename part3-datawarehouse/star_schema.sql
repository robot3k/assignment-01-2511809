-- =============================================================================
-- Part 3.1: Star Schema Design for Retail Data Warehouse
-- =============================================================================

-- =============================================================================
-- DROP TABLES (if they exist) - for re-execution
-- =============================================================================
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;

-- =============================================================================
-- DIMENSION TABLES
-- =============================================================================

-- Q1: Dim_Date - Date dimension table
-- Stores date-related attributes for time-based analysis
CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    year INT NOT NULL,
    month INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    quarter INT NOT NULL
);

-- Q2: Dim_Store - Store dimension table
-- Stores store-related attributes for location-based analysis
CREATE TABLE dim_store (
    store_key INT PRIMARY KEY,
    store_name VARCHAR(50) NOT NULL,
    store_city VARCHAR(50) NOT NULL
);

-- Q3: Dim_Product - Product dimension table
-- Stores product-related attributes for product-based analysis
CREATE TABLE dim_product (
    product_key INT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL
);

-- =============================================================================
-- FACT TABLE
-- =============================================================================

-- Q4: Fact_Sales - Central fact table for sales transactions
-- Contains numeric measures and foreign keys to dimension tables
CREATE TABLE fact_sales (
    sales_key INT PRIMARY KEY,
    transaction_id VARCHAR(20) NOT NULL UNIQUE,
    date_key INT NOT NULL,
    store_key INT NOT NULL,
    product_key INT NOT NULL,
    units_sold INT NOT NULL,
    unit_price DECIMAL(12, 2) NOT NULL,
    revenue DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (store_key) REFERENCES dim_store(store_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);

-- =============================================================================
-- INSERT STATEMENTS - CLEANED AND STANDARDIZED DATA
-- =============================================================================

-- -----------------------------------------------------------------------------
-- INSERT INTO dim_store (5 stores)
-- Note: Missing store_city values were inferred from store_name patterns
-- -----------------------------------------------------------------------------
INSERT INTO dim_store (store_key, store_name, store_city) VALUES (1, 'Chennai Anna', 'Chennai');
INSERT INTO dim_store (store_key, store_name, store_city) VALUES (2, 'Delhi South', 'Delhi');
INSERT INTO dim_store (store_key, store_name, store_city) VALUES (3, 'Bangalore MG', 'Bangalore');
INSERT INTO dim_store (store_key, store_name, store_city) VALUES (4, 'Pune FC Road', 'Pune');
INSERT INTO dim_store (store_key, store_name, store_city) VALUES (5, 'Mumbai Central', 'Mumbai');

-- -----------------------------------------------------------------------------
-- INSERT INTO dim_product (16 products)
-- Note: Category names standardized to proper case (Electronics, Grocery, Clothing)
-- 'Groceries' merged into 'Grocery', 'electronics' corrected to 'Electronics'
-- -----------------------------------------------------------------------------
INSERT INTO dim_product (product_key, product_name, category) VALUES (1, 'Speaker', 'Electronics');
INSERT INTO dim_product (product_key, product_name, category) VALUES (2, 'Tablet', 'Electronics');
INSERT INTO dim_product (product_key, product_name, category) VALUES (3, 'Phone', 'Electronics');
INSERT INTO dim_product (product_key, product_name, category) VALUES (4, 'Smartwatch', 'Electronics');
INSERT INTO dim_product (product_key, product_name, category) VALUES (5, 'Atta 10kg', 'Grocery');
INSERT INTO dim_product (product_key, product_name, category) VALUES (6, 'Jeans', 'Clothing');
INSERT INTO dim_product (product_key, product_name, category) VALUES (7, 'Biscuits', 'Grocery');
INSERT INTO dim_product (product_key, product_name, category) VALUES (8, 'Jacket', 'Clothing');
INSERT INTO dim_product (product_key, product_name, category) VALUES (9, 'Laptop', 'Electronics');
INSERT INTO dim_product (product_key, product_name, category) VALUES (10, 'Milk 1L', 'Grocery');
INSERT INTO dim_product (product_key, product_name, category) VALUES (11, 'Saree', 'Clothing');
INSERT INTO dim_product (product_key, product_name, category) VALUES (12, 'Headphones', 'Electronics');
INSERT INTO dim_product (product_key, product_name, category) VALUES (13, 'Pulses 1kg', 'Grocery');
INSERT INTO dim_product (product_key, product_name, category) VALUES (14, 'T-Shirt', 'Clothing');
INSERT INTO dim_product (product_key, product_name, category) VALUES (15, 'Rice 5kg', 'Grocery');
INSERT INTO dim_product (product_key, product_name, category) VALUES (16, 'Oil 1L', 'Grocery');

-- -----------------------------------------------------------------------------
-- INSERT INTO dim_date (unique dates from transactions)
-- Note: All dates standardized to YYYY-MM-DD format regardless of original format
-- Original formats included: DD/MM/YYYY, DD-MM-YYYY, and YYYY-MM-DD
-- -----------------------------------------------------------------------------
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (1, '2023-08-29', 2023, 8, 'August', 3);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (2, '2023-12-12', 2023, 12, 'December', 4);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (3, '2023-02-05', 2023, 2, 'February', 1);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (4, '2023-02-20', 2023, 2, 'February', 1);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (5, '2023-01-15', 2023, 1, 'January', 1);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (6, '2023-08-09', 2023, 8, 'August', 3);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (7, '2023-03-31', 2023, 3, 'March', 1);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (8, '2023-10-26', 2023, 10, 'October', 4);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (9, '2023-12-08', 2023, 12, 'December', 4);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (10, '2023-08-15', 2023, 8, 'August', 3);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (11, '2023-06-04', 2023, 6, 'June', 2);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (12, '2023-10-20', 2023, 10, 'October', 4);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (13, '2023-05-21', 2023, 5, 'May', 2);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (14, '2023-04-28', 2023, 4, 'April', 2);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (15, '2023-11-18', 2023, 11, 'November', 4);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (16, '2023-01-18', 2023, 1, 'January', 1);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (17, '2023-08-01', 2023, 8, 'August', 3);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (18, '2023-05-12', 2023, 5, 'May', 2);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (19, '2023-02-08', 2023, 2, 'February', 1);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (20, '2023-07-22', 2023, 7, 'July', 3);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (21, '2023-10-27', 2023, 10, 'October', 4);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (22, '2023-01-13', 2023, 1, 'January', 1);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (23, '2023-11-22', 2023, 11, 'November', 4);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (24, '2023-01-24', 2023, 1, 'January', 1);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (25, '2023-03-21', 2023, 3, 'March', 1);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (26, '2023-01-17', 2023, 1, 'January', 1);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (27, '2023-05-22', 2023, 5, 'May', 2);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (28, '2023-01-11', 2023, 1, 'January', 1);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (29, '2023-10-11', 2023, 10, 'October', 4);
INSERT INTO dim_date (date_key, full_date, year, month, month_name, quarter) VALUES (30, '2023-01-02', 2023, 1, 'January', 1);

-- -----------------------------------------------------------------------------
-- INSERT INTO fact_sales (15 sample transactions - cleaned data)
-- Note: Revenue calculated as units_sold * unit_price
-- All foreign keys reference cleaned dimension tables
-- -----------------------------------------------------------------------------
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (1, 'TXN5000', 1, 1, 1, 3, 49262.78, 147788.34);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (2, 'TXN5001', 2, 1, 2, 11, 23226.12, 255487.32);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (3, 'TXN5002', 3, 1, 3, 20, 48703.39, 974067.80);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (4, 'TXN5003', 4, 2, 2, 14, 23226.12, 325165.68);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (5, 'TXN5004', 5, 1, 4, 10, 58851.01, 588510.10);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (6, 'TXN5005', 6, 3, 5, 12, 52464.00, 629568.00);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (7, 'TXN5006', 7, 4, 4, 6, 58851.01, 353106.06);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (8, 'TXN5007', 8, 4, 6, 16, 2317.47, 37079.52);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (9, 'TXN5008', 9, 3, 7, 9, 27469.99, 247229.91);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (10, 'TXN5009', 10, 3, 4, 3, 58851.01, 176553.03);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (11, 'TXN5010', 11, 1, 8, 15, 30187.24, 452808.60);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (12, 'TXN5011', 12, 5, 6, 13, 2317.47, 30127.11);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (13, 'TXN5012', 13, 3, 9, 13, 42343.15, 550460.95);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (14, 'TXN5013', 14, 5, 10, 10, 43374.39, 433743.90);
INSERT INTO fact_sales (sales_key, transaction_id, date_key, store_key, product_key, units_sold, unit_price, revenue) VALUES (15, 'TXN5014', 15, 2, 8, 5, 30187.24, 150936.20);

-- =============================================================================
-- VERIFICATION QUERIES
-- =============================================================================

-- Verify dimension table counts
SELECT 'dim_date' AS table_name, COUNT(*) AS row_count FROM dim_date
UNION ALL
SELECT 'dim_store', COUNT(*) FROM dim_store
UNION ALL
SELECT 'dim_product', COUNT(*) FROM dim_product
UNION ALL
SELECT 'fact_sales', COUNT(*) FROM fact_sales;

-- Verify referential integrity
SELECT f.sales_key, f.transaction_id, d.full_date, s.store_name, p.product_name, f.revenue
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
JOIN dim_store s ON f.store_key = s.store_key
JOIN dim_product p ON f.product_key = p.product_key
ORDER BY f.sales_key;
