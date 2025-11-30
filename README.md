Electronics Shop Database System

Author: Dawit Adane
Course: PIA25 – Databaseteknik Individual Project

Summary

This project demonstrates how to store and retrieve data for brands, products, customers, orders, and reviews, while maintaining proper relationships between tables using SQLAlchemy ORM.

Clone the Repository

Run the following commands in your terminal:
git clone https://github.com/daveadane/PIA25_Individuell_Dawit_Adane.git
cd PIA25_Individuell_Dawit_Adane

Installation
1. Create and Activate a Virtual Environment

Windows:
python -m venv venv
venv\Scripts\activate

Mac/Linux:
source venv/bin/activate

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

Uses SQLAlchemy ORM for connection and transactions

Includes error handling and session management

Supports .env configuration for secure credentials

Queries

Uses parameterized ORM queries for safety

Demonstrates one-to-many and many-to-many relationships

Includes filtering, grouping, joining, and aggregation

Advanced Queries

The file queries_advanced.sql includes:

Multi-table joins

Subqueries and nested selects

Grouped aggregations

Window functions and ranking

Performance comparison between ORM and raw SQL queries

Optimization

The file Optimization.sql demonstrates:

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

When executed, the application connects to the PostgreSQL database and displays:

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

Conclusion

This project showcases a complete relational database system for an electronics store using PostgreSQL and SQLAlchemy ORM.

It demonstrates best practices in database design, advanced querying, query optimization, and Python-based data management.