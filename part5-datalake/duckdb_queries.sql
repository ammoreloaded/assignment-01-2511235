--Q1

SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM read_csv_auto('customers.csv') c
LEFT JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;

--Q2
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM read_csv_auto('customers.csv') c
JOIN read_json_auto('orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 3;


--Q3
---- NOTE:
-- This query cannot be implemented because orders.json does not contain product_id
-- or any field linking to products.parquet.
-- Hence, product-level analysis is not possible with given raw data.

--Q4
-- DATA LIMITATION NOTE:
-- The orders.json file does not include product_id or any reference to products.
-- Therefore:
-- Q3 (products by city) and Q4 (3-table join) cannot be fully implemented.
-- Only customer-order level analysis is possible.