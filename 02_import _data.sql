COPY superstore
FROM 'C:\path\Superstore_10000_Rows.csv'
WITH (
    FORMAT CSV,
    HEADER TRUE,
    DELIMITER ','
);

--- Verify data import
SELECT COUNT(*) AS total_rows
FROM superstore;

-- - Preview imported data
SELECT *
FROM superstore
LIMIT 10;