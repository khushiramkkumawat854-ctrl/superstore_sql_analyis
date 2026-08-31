- 1. View all records
SELECT *
FROM superstore;

-- 2. Total Sales
SELECT SUM(sales) AS total_sales
FROM superstore;

-- 3. Total Profit
SELECT SUM(profit) AS total_profit
FROM superstore;

-- 4. Total Orders
SELECT COUNT(order_id) AS total_orders
FROM superstore;

-- 5. Average Order Value
SELECT ROUND(AVG(sales), 2) AS avg_order_value
FROM superstore;

-- 6. Sales by Category
SELECT
category,
SUM(sales) AS category_sales
FROM superstore
GROUP BY category
ORDER BY category_sales DESC;

-- 7. Profit by Category
SELECT
category,
SUM(profit) AS category_profit
FROM superstore
GROUP BY category
ORDER BY category_profit DESC;

-- 8. Sales by Sub-Category
SELECT
sub_category,
SUM(sales) AS total_sales
FROM superstore
GROUP BY sub_category
ORDER BY total_sales DESC;

-- 9. Top 10 Products by Sales
SELECT
product_name,
SUM(sales) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- 10. Top 10 Customers by Revenue
SELECT
customer_name,
SUM(sales) AS revenue
FROM superstore
GROUP BY customer_name
ORDER BY revenue DESC
LIMIT 10;

-- 11. Repeat Customers
SELECT
customer_name,
COUNT(order_id) AS orders_count
FROM superstore
GROUP BY customer_name
HAVING COUNT(order_id) > 1
ORDER BY orders_count DESC;

-- 12. Sales by Region
SELECT
region,
SUM(sales) AS region_sales
FROM superstore
GROUP BY region
ORDER BY region_sales DESC;

-- 13. Profit by State
SELECT
state,
SUM(profit) AS state_profit
FROM superstore
GROUP BY state
ORDER BY state_profit DESC;

-- 14. Monthly Sales Trend
SELECT
DATE_TRUNC('month', order_date) AS month,
SUM(sales) AS monthly_sales
FROM superstore
GROUP BY month
ORDER BY month;

-- 15. Monthly Profit Trend
SELECT
DATE_TRUNC('month', order_date) AS month,
SUM(profit) AS monthly_profit
FROM superstore
GROUP BY month
ORDER BY month;

-- 16. Quantity Sold by Category
SELECT
category,
SUM(quantity) AS total_quantity
FROM superstore
GROUP BY category
ORDER BY total_quantity DESC;

-- 17. Products with Discount Greater Than 10%
SELECT
product_name,
discount,
sales
FROM superstore
WHERE discount > 0.10
ORDER BY discount DESC;

-- 18. Orders with Above Average Sales
SELECT *
FROM superstore
WHERE sales > (
SELECT AVG(sales)
FROM superstore
);

-- 19. Profit Margin by Category
SELECT
category,
ROUND(SUM(profit) * 100.0 / SUM(sales), 2) AS profit_margin_percent
FROM superstore
GROUP BY category
ORDER BY profit_margin_percent DESC;

-- 20. Complete Sales Report
SELECT
order_id,
order_date,
customer_name,
city,
state,
region,
category,
sub_category,
product_name,
quantity,
sales,
profit
FROM superstore
ORDER BY order_date;