- ============================================
-- SUPERSTORE SALES - DATA CLEANING



-- 1. Total number of records
SELECT COUNT(*) AS total_rows
FROM superstore_csv;


-- 2. Check duplicate Row IDs
SELECT
    row_id,
    COUNT(*) AS duplicate_count
FROM superstore_csv
GROUP BY row_id
HAVING COUNT(*) > 1;


-- 3. Check duplicate Order + Product combinations
SELECT
    order_id,
    product_id,
    COUNT(*) AS duplicate_count
FROM superstore_csv
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;


-- 4. Check missing values
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS missing_order_date,
    COUNT(*) FILTER (WHERE sales IS NULL) AS missing_sales,
    COUNT(*) FILTER (WHERE profit IS NULL) AS missing_profit
FROM superstore_csv;


-- 5. Check invalid sales values
SELECT *
FROM superstore_csv

WHERE sales < 0;


-- 6. Check invalid quantity
SELECT *
FROM superstore_csv

WHERE quantity <= 0;


-- 7. Check invalid discount
SELECT *
FROM superstore_csv
WHERE discount < 0
   OR discount > 1;


-- 8. Check invalid shipping dates
SELECT *
FROM superstore_csv
WHERE ship_date < order_date;


-- 9. Check missing product information
SELECT *
FROM superstore_csv
WHERE product_id IS NULL
   OR product_name IS NULL
   OR category IS NULL;


-- 10. Create clean table
CREATE TABLE superstore_clean AS
SELECT DISTINCT *
FROM superstore_csv
WHERE order_id IS NOT NULL
  AND customer_id IS NOT NULL
  AND order_date IS NOT NULL
  AND sales IS NOT NULL
  AND profit IS NOT NULL
  AND quantity > 0
  AND discount BETWEEN 0 AND 1;


-- 11. Validate cleaned dataset
SELECT
    COUNT(*) AS total_csv,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT product_id) AS total_products,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM superstore_clean