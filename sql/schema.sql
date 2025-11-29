
-- create a database schema for an electronics shop
-- removes old database if it exists and creates a new one
DROP DATABASE IF EXISTS electronics_db;
CREATE DATABASE electronics_db;

-- switch to the new database
\c electronics_db;

-- create a table for brands
CREATE TABLE brands (
     id SERIAL PRIMARY KEY,
     name VARCHAR(100) NOT NULL,
     country VARCHAR(100),
     founded_year INTEGER,
     description TEXT,
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

     -- name should be unique
        UNIQUE (name)
);

-- create a table for products
CREATE TABLE products (
      id SERIAL PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
       brand_id INTEGER NOT NULL REFERENCES brands(id) ON DELETE CASCADE,
       sku VARCHAR(50) UNIQUE,
       release_year INTEGER,
       price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
       warranty_months INTEGER CHECK (warranty_months >=0),
       category VARCHAR(100),
       stock_quantity INTEGER DEFAULT 0 CHECK (stock_quantity >= 0),
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- indexes for faster lookups
---- Index on brand_id improves performance for queries that:
-- - Join products with brands
-- - Filter products by brand
-- - Group products by brand
-- This is a common access pattern in an e-commerce database.
CREATE INDEX idx_products_brand_id ON products(brand_id);
CREATE INDEX idx_products_category ON products(category);


-- create a table for customers
CREATE TABLE customers (
      id SERIAL PRIMARY KEY,
      first_name VARCHAR(100) NOT NULL,
      last_name VARCHAR(100) NOT NULL,
      email VARCHAR(150) UNIQUE NOT NULL,
      phone VARCHAR(20),
      city VARCHAR(100),
      registration_date DATE DEFAULT CURRENT_DATE,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create a table for orders
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    order_date DATE DEFAULT CURRENT_DATE,
    delivery_date DATE, -- NULL if pending, set if completed
    total_amount DECIMAL(10,2) CHECK (total_amount >= 0),
    status VARCHAR(50) DEFAULT 'pending',
    shipping_city VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- If delivered, delivery_date must be >= order_date
    CHECK (
        delivery_date IS NULL 
        OR delivery_date >= order_date
    )
); 

-- index for faster lookups
--Index on customer_id improves performance when:
--Fetching all orders for a specific customer
--Joining orders with customers
--Grouping or aggregating orders by customer
CREATE INDEX idx_orders_customer_id ON orders(customer_id);

-- create a table for order items
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--index for faster lookups
--Retrieving all items belonging to an order
--Joining orders with their order items
--Calculating order totals (GROUP BY order_id)
CREATE INDEX idx_order_items_order_id ON order_items(order_id);

--Fetching all order items for a specific product
--Joining products with their order items
--Summarizing sales per product (GROUP BY product_id)
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- create a table for reviews
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    customer_id INTEGER NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    review_date DATE DEFAULT CURRENT_DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- a customer can review a product only once
    UNIQUE (product_id, customer_id)
);

-- index for faster lookups
--Retrieving all reviews for a product
--Joining products with their reviews
--Calculating average rating per product (GROUP BY product_id)
CREATE INDEX idx_reviews_product_id ON reviews(product_id);
--Fetching all reviews written by a specific customer
--Joining customers with their reviews
--Analyzing review activity per customer
CREATE INDEX idx_reviews_customer_id ON reviews(customer_id);