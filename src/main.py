
# ===================================================
# Display all database queries 
# ===================================================
from sqlalchemy import func
from tabulate import tabulate
from database import get_session

from queries import (
    get_all_products,
    get_products_over_price,
    get_orders_from_year,
    get_pending_orders,
    get_products_with_brands,
    get_orders_with_customer_names,
    get_customer_purchases,
    get_product_count_per_brand,
    get_top_spending_customers,
    get_products_with_average_rating,
    get_pending_orders_with_customers, 
)



def print_results(title, results):
    """Pretty print query results safely for both ORM and SQLAlchemy Row objects."""
    print(f"\n===== {title} =====")
    if not results:
        print("No results found.")
        return

    first = results[0]

    # Case 1: ORM objects (from mapped models)
    if hasattr(first, "__dict__") and "_sa_instance_state" in first.__dict__:
        data = [r.__dict__.copy() for r in results]
        for d in data:
            d.pop("_sa_instance_state", None)
        print(tabulate(data, headers="keys", tablefmt="fancy_grid"))

    # Case 2: SQLAlchemy Row objects (labelled columns, joins, aggregates)
    elif hasattr(first, "_mapping"):
        data = [dict(r._mapping) for r in results]
        print(tabulate(data, headers="keys", tablefmt="fancy_grid"))

    # Case 3: Simple tuples or lists
    else:
        print(tabulate(results, tablefmt="fancy_grid"))


def main():
    print("\n========= ELECTRONICS SHOP DATABASE (AUTO DISPLAY) =========")

    session = get_session()

    queries = [
        ("1️⃣ All Products", get_all_products(session)),
        ("2️⃣ Products Over 5000", get_products_over_price(session, 5000)),
        ("3️⃣ Orders from 2024", get_orders_from_year(session, 2024)),
        ("4️⃣ Pending Orders", get_pending_orders(session)),
        ("5️⃣ Products with Brand Names", get_products_with_brands(session)),
        ("6️⃣ Orders with Customer Names", get_orders_with_customer_names(session)),
        ("7️⃣ Customer Purchases", get_customer_purchases(session)),
        ("8️⃣ Product Count per Brand", get_product_count_per_brand(session)),
        ("9️⃣ Top Spending Customers", get_top_spending_customers(session)),
        ("🔟 Products with Average Ratings", get_products_with_average_rating(session)),
        ("11️⃣ Pending Orders with Customers", get_pending_orders_with_customers(session)),
    ]

    for title, result in queries:
        print_results(title, result)

    session.close()
    print("\n========= END OF REPORT =========")


if __name__ == "__main__":
    main()

