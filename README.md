**superstore Sales SQL Portfolio Project**

**Overview**

This project analyzes Superstore sales data using PostgreSQL. The objective is to identify sales trends, customer behavior, category profitability, regional performance, and business growth opportunities through SQL analysis.

Tools Used

- PostgreSQL
- SQL
- pgAdmin

Database Schema

The project uses a single table:

- superstore

The dataset contains order details, customer information, product categories, sales, quantity, discounts, and profit.

SQL Skills Demonstrated

- SELECT
- WHERE
- GROUP BY
- HAVING
- ORDER BY
- LIMIT
- Aggregate Functions
- Subqueries
- CTE (Common Table Expressions)
- Window Functions
- ROW_NUMBER
- RANK
- DENSE_RANK
- LAG
- LEAD
- Running Total
- RFM Analysis

Project Structure

superstore_sql_portfolio/
│
├── dataset/
│   └── superstore.csv
│
├── sql/
│   ├── 01_create_table.sql
│   ├── 02_import_data.sql
│   ├── 03_analysis_queries.sql
│   └── 04_advanced_queries.sql
│
├── insights/
│   └── business_insights.md
│
├── screenshots/
│   ├── top_products.png
│   ├── monthly_sales.png
│   └── category_profit.png
│
├── README.md
└── portfolio_summary.pdf

Business Problems Solved

- Total sales and profit analysis
- Category-wise sales performance
- Product performance analysis
- Customer revenue ranking
- Repeat customer identification
- Monthly sales trend analysis
- Regional sales comparison
- Profit margin analysis
- Sales contribution analysis
- RFM customer segmentation

Sample Query

SELECT category,
SUM(sales) AS category_sales
FROM superstore
GROUP BY category
ORDER BY category_sales DESC;

Key Insights

- Technology generated the highest sales and profit.
- Amit Kumar was the highest-value customer.
- West region produced the highest revenue.
- Sales increased from January to July.
- High discounts reduced overall profit margins.

Project Outcome

This project demonstrates practical SQL skills and the ability to convert raw retail sales data into actionable business insights suitable for management and stakeholder decision-making.
