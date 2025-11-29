
TRUNCATE brands RESTART IDENTITY CASCADE;
TRUNCATE products RESTART IDENTITY CASCADE;
TRUNCATE customers RESTART IDENTITY CASCADE;
TRUNCATE orders RESTART IDENTITY CASCADE;
TRUNCATE order_items RESTART IDENTITY CASCADE;
TRUNCATE reviews RESTART IDENTITY CASCADE;


-- ============================================
-- INSERT BRANDS
-- ============================================
INSERT INTO brands (name, country, founded_year, description, created_at)
VALUES
('Samsung', 'South Korea', 1938, 'Electronics and home appliances.', '2012-03-15'),
('HP', 'USA', 1939, 'Computers and office electronics.', '2013-05-10'),
('Apple', 'USA', 1976, 'Consumer electronics and software.', '2015-09-22'),
('Smeg', 'Italy', 1948, 'Premium kitchen appliances.', '2011-04-09'),
('Electrolux', 'Sweden', 1919, 'Home appliances and cleaning equipment.', '2010-07-01'),
('Ninja', 'USA', 1993, 'Kitchen appliances and blenders.', '2014-11-18');


-- ============================================
-- INSERT PRODUCTS
-- ============================================
INSERT INTO products (name, brand_id, sku, release_year, price, warranty_months, category, stock_quantity, created_at)
VALUES
('Samsung 65"" TV', 1, 'SAM-TV-65', 2023, 12999.00, 24, 'TV', 50, '2023-02-10'),
('Samsung Sound Bar', 1, 'SAM-SB-01', 2022, 2499.00, 12, 'Audio', 120, '2022-03-05'),
('HP Laptop', 2, 'HP-LT-15', 2023, 8999.00, 24, 'Laptop', 35, '2023-04-10'),
('HP Wireless Printer', 2, 'HP-PR-02', 2024, 3490.00, 24, 'Printer', 60, '2024-01-20'),
('iPhone 14 Pro Max', 3, 'APPLE-IP14PM', 2023, 14999.00, 24, 'Smartphone', 100, '2023-10-01'),
('Apple iPad Air', 3, 'APPLE-IPADAIR', 2022, 8990.00, 24, 'Tablet', 80, '2022-09-10'),
('Smeg Espresso Machine', 4, 'SMEG-ESP-01', 2020, 5999.00, 24, 'Kitchen', 30, '2020-04-12'),
('Smeg Bread Toaster', 4, 'SMEG-TOAST-01', 2021, 1499.00, 12, 'Kitchen', 80, '2021-05-10'),
('Electrolux Vacuum Cleaner', 5, 'ELEC-VC-01', 2022, 3499.00, 24, 'Cleaning', 70, '2022-08-20'),
('Ninja Juicer', 6, 'NINJA-JC-01', 2021, 2490.00, 18, 'Kitchen', 45, '2021-03-30');


-- ============================================
-- INSERT CUSTOMERS (chronologically corrected)
-- ============================================
INSERT INTO customers (first_name, last_name, email, phone, city, registration_date, created_at)
VALUES
('Anna', 'Johansson', 'anna.j@example.com', '0721112233', 'Stockholm', '2023-02-28', '2023-02-28'),
('Markus', 'Lindgren', 'markus.l@example.com', '0732223344', 'Göteborg', '2023-03-10', '2023-03-10'),
('Sara', 'Berg', 'sara.b@example.com', '0703334455', 'Malmö', '2023-05-30', '2023-05-30'),
('Johan', 'Ekström', 'johan.e@example.com', '0764445566', 'Uppsala', '2023-06-20', '2023-06-20'),
('Elin', 'Sundberg', 'elin.s@example.com', '0755556677', 'Västerås', '2024-04-01', '2024-04-01'),
('Lars', 'Nilsson', 'lars.n@example.com', '0708889999', 'Örebro', '2023-09-15', '2023-09-15'),
('Emma', 'Karlsson', 'emma.k@example.com', '0712223344', 'Lund', '2024-08-25', '2024-08-25');


-- ============================================
-- INSERT ORDERS (2023–2025, fixed pending logic)
-- ============================================
INSERT INTO orders (customer_id, order_date, delivery_date, total_amount, status, shipping_city, created_at)
VALUES

(1, '2023-03-05', '2023-03-12', 12999.00, 'completed', 'Stockholm', '2023-03-05'),
(2, '2023-04-10', '2023-04-18', 2499.00, 'completed', 'Göteborg', '2023-04-10'),
(3, '2023-06-15', '2023-06-22', 5999.00, 'completed', 'Malmö', '2023-06-15'),
(4, '2023-07-02', '2023-07-10', 1499.00, 'completed', 'Uppsala', '2023-07-02'),
(6, '2023-09-25', '2023-10-02', 3499.00, 'completed', 'Örebro', '2023-09-25'),
(2, '2024-01-14', '2024-01-22', 8999.00, 'completed', 'Göteborg', '2024-01-14'),
(3, '2024-03-05', '2024-03-12', 8990.00, 'completed', 'Malmö', '2024-03-05'),
(5, '2024-05-21', '2024-05-28', 1499.00, 'completed', 'Västerås', '2024-05-21'),
(6, '2024-07-15', '2024-07-23', 2490.00, 'completed', 'Örebro', '2024-07-15'),
(7, '2024-09-10', '2024-09-18', 14999.00, 'completed', 'Lund', '2024-09-10'),
(1, '2025-02-10', '2025-02-18', 3490.00, 'completed', 'Stockholm', '2025-02-10'),
(5, '2025-04-12', '2025-04-20', 2490.00, 'completed', 'Västerås', '2025-04-12'),

-- 2025 Pending Orders (delivery not yet made → NULL)
(3, '2025-11-05', NULL, 12999.00, 'pending', 'Malmö', '2025-11-05'),
(4, '2025-11-12', NULL, 14999.00, 'pending', 'Uppsala', '2025-11-12'),
(7, '2025-11-15', NULL, 5999.00, 'pending', 'Lund', '2025-11-15');



-- ============================================
-- INSERT ORDER ITEMS
-- ============================================
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 12999.00),
(2, 2, 1, 2499.00),
(3, 7, 1, 5999.00),
(4, 8, 1, 1499.00),
(5, 9, 1, 3499.00),
(6, 3, 1, 8999.00),
(7, 6, 1, 8990.00),
(8, 8, 1, 1499.00),
(9, 10, 1, 2490.00),
(10, 5, 1, 14999.00),
(11, 4, 1, 3490.00),
(12, 10, 1, 2490.00),
(13, 1, 1, 12999.00),
(14, 5, 1, 14999.00),
(15, 7, 1, 5999.00);


-- ============================================
-- INSERT REVIEWS (each after delivery date)
-- ============================================
INSERT INTO reviews (product_id, customer_id, rating, comment, review_date, created_at)
VALUES
(1, 1, 5, 'Fantastic TV, excellent picture quality.', '2023-03-20', '2023-03-20'),
(2, 2, 3, 'lacks bass.', '2023-04-25', '2023-04-25'),
(7, 3, 4, 'Great espresso, though a bit noisy.', '2023-06-30', '2023-06-30'),
(8, 4, 5, 'Stylish toaster, perfect for breakfast.', '2023-07-18', '2023-07-18'),
(9, 6, 3, 'Average suction, works fine.', '2023-10-10', '2023-10-10'),
(3, 2, 5, 'HP laptop is fast and reliable.', '2024-01-29', '2024-01-29'),
(6, 3, 4, 'iPad Air is smooth and lightweight.', '2024-03-20', '2024-03-20'),
(8, 5, 3, 'Burns the bread too often.', '2024-06-05', '2024-06-05'),
(10, 6, 5, 'Juicer is efficient and easy to clean.', '2024-07-30', '2024-07-30'),
(5, 7, 5, 'iPhone is simply the best!', '2024-09-28', '2024-09-28'),
(4, 1, 4, 'Printer setup was easy, but ink cartidges are expensive.', '2025-02-25', '2025-02-25'),
(10, 5, 2, 'Cleaning is a pain, I barely use it anymore.', '2025-04-25', '2025-04-25');


 

