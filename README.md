Electronics Shop Database System

Author: Dawit Adane
Course: PIA25 – Databaseteknik Individual Project

Summary

This project demonstrates how to design, store, and retrieve data for an Electronics Shop using a relational database.

It includes tables and relationships for brands, products, customers, orders, and reviews, ensuring proper data integrity and efficient querying.

Clone the Repository
git clone https://github.com/daveadane/PIA25_Individuell_Dawit_Adane.git
cd PIA25_Individuell_Dawit_Adane

Installation
1. Create and Activate a Virtual Environment
python -m venv venv
venv\Scripts\activate   # For Windows
# source venv/bin/activate   # For macOS/Linux

2. Install Dependencies
pip install -r requirements.txt


Required Packages:

SQLAlchemy

psycopg2-binary

python-dotenv

tabulate

greenlet

typing-extensions

Database Setup

Create the database:

CREATE DATABASE electronics_db;


Run the setup scripts:

\schema.sql
\testdata.sql

Electronics Shop Database System

Author: Dawit Adane
Course: PIA25 – Databaseteknik Individual Project

Summary

This project demonstrates how to design, store, and retrieve data for an Electronics Shop using a relational database.

It includes tables and relationships for brands, products, customers, orders, and reviews, ensuring proper data integrity and efficient querying.

Clone the Repository
git clone https://github.com/daveadane/PIA25_Individuell_Dawit_Adane.git
cd PIA25_Individuell_Dawit_Adane

Installation
1. Create and Activate a Virtual Environment
python -m venv venv
venv\Scripts\activate   # For Windows
# source venv/bin/activate   # For macOS/Linux

2. Install Dependencies
pip install -r requirements.txt


Required Packages:

SQLAlchemy

psycopg2-binary

python-dotenv

tabulate

greenlet

typing-extensions

Database Setup

Create the database:

CREATE DATABASE electronics_db;


Run the setup scripts:

\schema.sql
\testdata.sql

Features
Database

Uses SQLAlchemy ORM for database connection and transactions

Includes error handling and session management

Supports .env environment variables for secure configuration

Queries

Uses parameterized ORM queries for security

Demonstrates one-to-many and many-to-many relationships

Includes filtering, grouping, joining, and aggregation queries

Advanced Queries

The file queries_advanced.sql includes additional and more complex SQL queries such as:

Multi-table joins

Subqueries and nested selects

Grouped aggregations

Window functions and ranking

Performance comparison between ORM and raw SQL queries

Optimization

The Optimization.sql file demonstrates:

Creation of indexes to improve query performance

Use of EXPLAIN ANALYZE to measure efficiency improvements

ER Model and Relationships
Entity	Relationship
Brand	One brand → Many products
Customer	One customer → Many orders
Order	One order → Many order items
Product	One product → Many reviews
Run the Application
python src/main.py

Application Output

When executed, the application connects to the PostgreSQL database and displays the following:

All products

Products priced over 5000 SEK

Orders from 2024

Pending orders

Products with brand names

Orders with customer names

Customer purchase summaries

Product count per brand

Top spending customers

Products with average ratings

Pending orders with customer details

ER Model and Relationships
Entity	Relationship
Brand	One brand → Many products
Customer	One customer → Many orders
Order	One order → Many order items
Product	One product → Many reviews
Run the Application
python src/main.py

Application Output

When executed, the application connects to the PostgreSQL database and displays the following:

All products

Products priced over 5000 SEK

Orders from 2024

Pending orders

Products with brand names

Orders with customer names

Customer purchase summaries

Product count per brand

Top spending customers

Products with average ratings

Pending orders with customer details

Optimization Example

The Optimization.sql file includes:

Creation of indexes for faster query execution

Use of EXPLAIN ANALYZE to compare performance before and after indexing
