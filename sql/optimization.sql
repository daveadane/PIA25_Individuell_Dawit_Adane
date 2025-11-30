-- =============================================
-- OPTIMIZATION.SQL
-- =============================================
-- Purpose: Show index optimizations and performance improvements
-- =============================================

-- Query 1: Products filtered by price
-- ---------------------------------------------
-- Problem: Filtering by price in queries like
--    SELECT * FROM products WHERE price > 5000;
-- can be slow if no index exists on "price".
-- Solution: Create an index on price.

-- Before optimization
EXPLAIN ANALYZE
SELECT * FROM products WHERE price > 5000;

-- Create index on price
CREATE INDEX IF NOT EXISTS idx_products_price ON products(price);

-- After optimization
EXPLAIN ANALYZE
SELECT * FROM products WHERE price > 5000;

-- ---------------------------------------------
-- Expected improvement:
-- The sequential scan (Seq Scan) should be replaced
-- by an Index Scan or Bitmap Index Scan, reducing execution time.
-- Adding an index on the price column improves efficiency when filtering expensive products.

-- Query 2: Orders filtered by customer_id
-- ---------------------------------------------
-- Problem: Queries like
--    SELECT * FROM orders WHERE customer_id = 3;
-- are frequent and can be optimized.
-- Solution: Create an index on customer_id.

-- Before optimization
-- This slows down the large data because the database checks every row
EXPLAIN ANALYZE
SELECT * FROM orders WHERE customer_id = 3;

-- Create index on orders(customer_id)
--It helps PostgreSQL finds rows faster without scanning the entire table. 
CREATE INDEX IF NOT EXISTS idx_orders_customer_id ON orders(customer_id);

-- After optimization
EXPLAIN ANALYZE
SELECT * FROM orders WHERE customer_id = 3;

-- ---------------------------------------------
-- Expected improvement:
-- Execution plan will show Index Scan instead of Seq Scan.
-- This improves performance for customer-based lookups.
---Indexes reduce sequential scans, lower execution time, and improve scalability.
-- planning time is 0.030ms and Execution time is 0.013ms which is more faster

