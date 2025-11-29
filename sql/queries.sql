
--============================================
--QUERY 1: Get all products sorted alphabetically
--------------------------------------------

SELECT
    id,name,price,category FROM products ORDER BY name ASC;


--============================================
---QUERY 2: Products costing more than 5000 kr
--------------------------------------------

SELECT
    id,name,price
FROM products
WHERE price > 5000
ORDER BY price DESC;


--============================================
----QUERY 3: Get all orders from year 2024
----------------------------------------------

SELECT
    id,customer_id,order_date,total_amount,status
FROM orders
WHERE order_date BETWEEN '2025-01-01' AND '2025-12-31'
ORDER BY order_date;


--============================================
---QUERY 4: Get all pending orders
--------------------------------------------

SELECT
    id,customer_id,order_date, total_amount,status
FROM orders
WHERE status = 'pending'
ORDER BY order_date DESC;

--============================================
--- QUERY 5: Products with their brand names
----------------------------------------------

SELECT
    p.id AS product_id,
    p.name AS product_name,
    b.name AS brand_name,
    p.price
FROM products p
JOIN brands b ON p.brand_id = b.id
ORDER BY brand_name, product_name;

--============================================
--QUERY 6: Orders with customer name and total
--------------------------------------------

SELECT
    o.id AS order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date,
    o.total_amount,
    o.status
FROM orders o
JOIN customers c ON o.customer_id = c.id
ORDER BY o.order_date DESC;

--============================================
--QUERY 7: Products purchased by each customer
----------------------------------------------

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    p.name AS product_name,
    oi.quantity,
    o.order_date
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_items oi ON oi.order_id = o.id
JOIN products p ON p.id = oi.product_id
ORDER BY customer_name, o.order_date;

--============================================
--QUERY 8: Count number of products per brand
--------------------------------------------

SELECT
    b.name AS brand_name,
    COUNT(p.id) AS number_of_products
FROM brands b
LEFT JOIN products p ON p.brand_id = b.id
GROUP BY b.name
ORDER BY number_of_products DESC;

--============================================
-- QUERY 9: Customers who spent the most total money
--------------------------------------------

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.id
WHERE o.status = 'completed'
GROUP BY customer_name
ORDER BY total_spent DESC;

--============================================
--QUERY 10: Products with their average rating
--------------------------------------------

SELECT
    p.name AS product_name,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.id) AS review_count
FROM products p
LEFT JOIN reviews r ON r.product_id = p.id
GROUP BY p.name
ORDER BY average_rating DESC NULLS LAST;


--============================================
--QUERY 11: pending orders including customer names and shipping info
--------------------------------------------

SELECT
    o.id AS order_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    o.order_date,
    o.total_amount,
    o.shipping_city
FROM orders o
JOIN customers c ON o.customer_id = c.id
WHERE o.status = 'pending'
ORDER BY o.order_date;

----------------------------------------------------------------------------------










