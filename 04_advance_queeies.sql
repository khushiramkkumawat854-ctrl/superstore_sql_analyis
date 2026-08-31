-- 1. Rank Customers by Total Sales
WITH customer_sales AS (
SELECT
customer_name,
SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_name
)
SELECT
customer_name,
total_sales,
RANK() OVER (ORDER BY total_sales DESC) AS customer_rank
FROM customer_sales;

-- 2. Dense Rank Customers by Sales
WITH customer_sales AS (
SELECT
customer_name,
SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_name
)
SELECT
customer_name,
total_sales,
DENSE_RANK() OVER (ORDER BY total_sales DESC) AS dense_rank
FROM customer_sales;

-- 3. Row Number for Orders of Each Customer
SELECT
customer_name,
order_id,
order_date,
ROW_NUMBER() OVER (
PARTITION BY customer_name
ORDER BY order_date
) AS order_sequence
FROM superstore;

-- 4. Running Total of Sales
SELECT
order_date,
sales,
SUM(sales) OVER (
ORDER BY order_date
) AS running_total
FROM superstore;

-- 5. Monthly Sales with Previous Month Sales
WITH monthly_sales AS (
SELECT
DATE_TRUNC('month', order_date) AS month,
SUM(sales) AS total_sales
FROM superstore
GROUP BY month
)
SELECT
month,
total_sales,
LAG(total_sales) OVER (ORDER BY month) AS previous_month_sales
FROM monthly_sales;

-- 6. Monthly Sales Growth
WITH monthly_sales AS (
SELECT
DATE_TRUNC('month', order_date) AS month,
SUM(sales) AS total_sales
FROM superstore
GROUP BY month
)
SELECT
month,
total_sales,
LAG(total_sales) OVER (ORDER BY month) AS previous_month,
total_sales - LAG(total_sales) OVER (ORDER BY month) AS growth
FROM monthly_sales;

-- 7. Next Order Date for Each Customer
SELECT
customer_name,
order_id,
order_date,
LEAD(order_date) OVER (
PARTITION BY customer_name
ORDER BY order_date
) AS next_order_date
FROM superstore;

-- 8. Top Product in Each Category
WITH product_sales AS (
SELECT
category,
product_name,
SUM(sales) AS revenue
FROM superstore
GROUP BY category, product_name
)
SELECT
category,
product_name,
revenue
FROM (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY category
ORDER BY revenue DESC
) AS rn
FROM product_sales
) t
WHERE rn = 1;

-- 9. Customer Lifetime Value (CLV) Ranking
WITH clv AS (
SELECT
customer_name,
SUM(sales) AS lifetime_value
FROM superstore
GROUP BY customer_name
)
SELECT
customer_name,
lifetime_value,
DENSE_RANK() OVER (ORDER BY lifetime_value DESC) AS clv_rank
FROM clv;

-- 10. RFM Analysis
SELECT
customer_name,
MAX(order_date) AS last_order_date,
CURRENT_DATE - MAX(order_date) AS recency_days,
COUNT(order_id) AS frequency,
SUM(sales) AS monetary
FROM superstore
GROUP BY customer_name
ORDER BY monetary DESC;

-- 11. Customers Above Average Sales
WITH customer_sales AS (
SELECT
customer_name,
SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_name
)
SELECT *
FROM customer_sales
WHERE total_sales > (
SELECT AVG(total_sales)
FROM customer_sales
);

-- 12. Sales Contribution by Category
WITH total AS (
SELECT SUM(sales) AS total_sales
FROM superstore
)
SELECT
category,
SUM(sales) AS category_sales,
ROUND(
SUM(sales) * 100.0 / (SELECT total_sales FROM total),
2
) AS contribution_percent
FROM superstore
GROUP BY category
ORDER BY contribution_percent DESC;

-- 13. Most Recent Order for Each Customer
SELECT
customer_name,
order_id,
order_date
FROM (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY customer_name
ORDER BY order_date DESC
) AS rn
FROM superstore
) t
WHERE rn = 1;

-- 14. Profit Difference Between Consecutive Orders
SELECT
order_id,
order_date,
profit,
profit - LAG(profit) OVER (ORDER BY order_date) AS profit_difference
FROM superstore;

-- 15. Top 3 Customers by Sales
WITH customer_sales AS (
SELECT
customer_name,
SUM(sales) AS total_sales
FROM superstore
GROUP BY customer_name
)
SELECT *
FROM (
SELECT *,
DENSE_RANK() OVER (ORDER BY total_sales DESC) AS rnk
FROM customer_sales
) t
WHERE rnk <= 3;
