-- ============================================
-- queries_advanced.sql  
-- Electronics Shop – PostgreSQL
-- ============================================

-- ------------------------------------------------
-- SUBQUERIES (2 st)
-- ------------------------------------------------

-- 1) Products price are higher than the avarage price
--    compares with each product with global avarage price
SELECT
    p.id,
    p.name,
    p.price,
    ROUND((SELECT AVG(price) FROM products), 2) AS global_avg_price
FROM products p
WHERE p.price > (SELECT AVG(price) FROM products)
ORDER BY p.price DESC;

--OUTPUT
--5	"iPhone 14 Pro Max"	14999.00	6546.30
--1	"Samsung 65"""" TV"	12999.00	6546.30
--3	"HP Laptop"	         8999.00	6546.30
--6	"Apple iPad Air"	 8990.00	6546.30

---2) Find customers who have placed more than the avarage number of orders
--   
--    calculate first orders per customer and then compares against the avarage
WITH orders_per_customer AS (
    SELECT o.customer_id, COUNT(*) AS order_count
    FROM orders o
    GROUP BY o.customer_id
),
avg_orders AS (
    SELECT AVG(order_count)::numeric(10,2) AS avg_cnt
    FROM orders_per_customer
)
SELECT
    c.id,
    c.first_name || ' ' || c.last_name AS customer_name,
    opc.order_count,
    a.avg_cnt AS global_avg_order_count
FROM customers c
JOIN orders_per_customer opc ON opc.customer_id = c.id
CROSS JOIN avg_orders a
WHERE opc.order_count > a.avg_cnt
ORDER BY opc.order_count DESC, customer_name;

-- OUTPUT
--id   name     ordercount   glob avgcount
--3	"Sara Berg"	   3	       2.14

-- ------------------------------------------------
-- WINDOW FUNCTIONS (2 st) – PostgreSQL
-- ------------------------------------------------

-- 3) Rank products per manufacturer based on price(most expensive = rank 1)
--    ROW_NUMBER per customer.
SELECT
    b.name AS brand_name,
    p.name AS product_name,
    p.price,
    ROW_NUMBER() OVER (
        PARTITION BY p.brand_id
        ORDER BY p.price DESC
    ) AS price_rank_within_brand
FROM products p
JOIN brands b ON b.id = p.brand_id
ORDER BY p.price DESC;

-- This query ranks products with each brand using ROW_NUMBER(). It partitions by brand_id
-- and orders by price ascending. Thus, each brand's most expensive product has rank 1.

-- 4) Show each customer's total spending and their rank among all customers
--    summarizes order.total_amount and ranks with RANK() (tied ranks share the same number)
SELECT
    c.id,
    c.first_name || ' ' || c.last_name AS customer_name,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    RANK() OVER (ORDER BY COALESCE(SUM(o.total_amount), 0) DESC) AS spending_rank
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
GROUP BY c.id, c.first_name, c.last_name
ORDER BY spending_rank, customer_name;

-- This query calculates total spending per customer and assigns a rank RANK() OVER()
-- Customers spending the most receive rank 1 and the least has 7

-- ------------------------------------------------
-- CASE / conditional logic
-- ------------------------------------------------

-- 5)  Categorize products by price: 
--    Budget (<1000), Medium (1000–5000), Premium (>5000)
SELECT
    p.id,
    p.name,
    p.price,
    CASE
        WHEN p.price < 1000 THEN 'Budget'
        WHEN p.price BETWEEN 1000 AND 5000 THEN 'Medium'
        ELSE 'Premium'
    END AS price_category
FROM products p
ORDER BY price_category, p.price;

-- This query uses a CASE expression to group products into categories. It simplifies
-- pricing analysis and organizes products by price range.

-- 6) Categorize customers by number of orders
--    VIP (>3), Regular (2–3), New (1)
--    (customers without orders are excluded, but can be included as "No Orders if needed")
WITH order_counts AS (
    SELECT o.customer_id, COUNT(*) AS order_count
    FROM orders o
    GROUP BY o.customer_id
)
SELECT
    c.id,
    c.first_name || ' ' || c.last_name AS customer_name,
    oc.order_count,
    CASE
        WHEN oc.order_count > 3 THEN 'VIP'
        WHEN oc.order_count BETWEEN 2 AND 3 THEN 'Regular'
        WHEN oc.order_count = 1 THEN 'New'
        ELSE 'No Orders'
    END AS customer_segment
FROM customers c
JOIN order_counts oc ON oc.customer_id = c.id  
ORDER BY customer_segment, oc.order_count DESC, customer_name;


