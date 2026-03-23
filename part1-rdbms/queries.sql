--Q1: List all customers from Mumbai along with their total order value
--Filters customers from Mumbai
--Calculates total purchase value
--SUM(quantity × price)

SELECT 
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * p.unit_price) AS total_order_value
FROM Customers c
JOIN Orders o 
    ON c.customer_id = o.customer_id
JOIN Order_Items oi 
    ON o.order_id = oi.order_id
JOIN Products p 
    ON oi.product_id = p.product_id
WHERE c.customer_city = 'Mumbai'
GROUP BY c.customer_id, c.customer_name;


--Q2: Find the top 3 products by total quantity sold
--Aggregates total quantity sold per product
--Sorts highest first
--Returns Top 3 products

SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM Products p
JOIN Order_Items oi 
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 3;



--Q3: List all sales representatives and the number of unique customers they have handled
--Uses DISTINCT to count unique customers
--LEFT JOIN ensures sales reps with no orders still appear


SELECT 
    sr.sales_rep_id,
    sr.sales_rep_name,
    COUNT(DISTINCT o.customer_id) AS unique_customers
FROM Sales_Reps sr
LEFT JOIN Orders o 
    ON sr.sales_rep_id = o.sales_rep_id
GROUP BY sr.sales_rep_id, sr.sales_rep_name;


--Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
--Calculate total value of each order
--Filter orders greater than 10,000

SELECT 
    o.order_id,
    SUM(oi.quantity * p.unit_price) AS order_total
FROM Orders o
JOIN Order_Items oi 
    ON o.order_id = oi.order_id
JOIN Products p 
    ON oi.product_id = p.product_id
GROUP BY o.order_id
HAVING SUM(oi.quantity * p.unit_price) > 10000
ORDER BY order_total DESC;


--Q5: Identify any products that have never been ordered
--LEFT JOIN keeps all products
--Products without order records will have NULL values


SELECT 
    p.product_id,
    p.product_name
FROM Products p
LEFT JOIN Order_Items oi 
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;