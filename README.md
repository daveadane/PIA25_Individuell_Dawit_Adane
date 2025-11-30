# 💻 Electronics Shop ORM Project

**Dawit Adane**  
*PIA25 Databasteknik Individual Project*

---

## 🧾 Summary
This project demonstrates how to **store and retrieve data** for brands, products, customers, orders, and reviews — while maintaining proper relationships between tables using **SQLAlchemy ORM**.

---

## 🗂️ Clone the Repository
```bash
git clone https://github.com/daveadane/PIA25_Individuell_Dawit_Adane.git
cd PIA25_Individuell_Dawit_Adane

⚙️ Installation 
1️⃣ Create and Activate Virtual Environment
# Windows
python -m venv venv
venv\Scripts\activate

# Mac/Linux
source venv/bin/activate

2️⃣ Install Dependencies
pip install -r requirements.txt


Required packages:

SQLAlchemy

psycopg2-binary

python-dotenv

tabulate

greenlet

typing-extensions

🧱 Database Setup
CREATE DATABASE electronics_db;

🧩 Features

Includes error handling and session management

Supports .env environment variables for secure configuration

🔍 Queries

Uses parameterized ORM queries for security

Demonstrates one-to-many and many-to-many relationships

Includes filtering, grouping, joining, and aggregation queries

📊 Advanced Queries

The file queries_advanced.sql includes more complex SQL examples such as:

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