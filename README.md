Electronics shop 

Dawit Adane
PIA25 Databaseteknik Individual Project

Summery:
It demonstrates how to store and retrieve data for brands, products, customers, orders, and reviews, with proper relationships between tables. 

Installation: 
 Create and Activate Virtual Environnment
    python -m venv venv
    venv\Scripts\activate
 Insatall requirements
    pip install -requirements.txt
    SQLAlchemy
    psycopg2-binary
    python-dotenv
    tabulate
    greenlet
    typing-extensions

Database Setup
   CREATE DATABASE electronics_db

Features

Database
   . Uses SQLAlchemy ORM for connection and transactions
     Includes error hadnling and session management
     supports .env environment variable for secure configuration
Queries
     Parameterized ORM queries for safety
     Covers one- to- many and many-to many relationships
     Includes filtering, grouping, joining and aggregation

OPTIMIZATION
    Optimization.sql shows two indexes and performance improvement using EXPLAIN ANALYSIS
ER Model
Relationships
    One brand → many products
    One customer → many orders
    One order → many order_items
    one product → many reviews
    
Run SQL scripts
  \schema.sql
  \testdata.sql

Run the application
python src/main.py

The program connects to the database and displays
    All products
    products with prices over 5000 SEK 
    Orders from 2024
    Pending orders
    Products with brand names
    Orders with customers names
    Customer purchases
    Product count per brand
    Top spending customers
    products with avarage ratings
    pending orders with customer info

