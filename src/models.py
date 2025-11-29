# models.py
# ============================================
# SQLAlchemy ORM models for Electronics Shop
# ============================================

from sqlalchemy import Column, Integer, String, DECIMAL, Text, ForeignKey, Date, TIMESTAMP, CheckConstraint
from sqlalchemy.orm import relationship
from  database import Base


# -----------------------
# Brand Model
# -----------------------
class Brand(Base):
    __tablename__ = 'brands'

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    country = Column(String)
    founded_year = Column(Integer)
    description = Column(Text)
    created_at = Column(TIMESTAMP)

    # Relationship to products
    products = relationship("Product", back_populates="brand", cascade="all, delete")

    def __repr__(self):
        return f"<Brand(name='{self.name}', country='{self.country}')>"


# -----------------------
# Product Model
# -----------------------
class Product(Base):
    __tablename__ = 'products'

    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    brand_id = Column(Integer, ForeignKey('brands.id', ondelete='CASCADE'), nullable=False)
    sku = Column(String, unique=True)
    release_year = Column(Integer)
    price = Column(DECIMAL, nullable=False)
    warranty_months = Column(Integer)
    category = Column(String)
    stock_quantity = Column(Integer, default=0)
    created_at = Column(TIMESTAMP)

    # Constraints
    __table_args__ = (
        CheckConstraint('price > 0', name='check_price_positive'),
        CheckConstraint('stock_quantity >= 0', name='check_stock_nonnegative'),
    )

    # Relationship to brand
    brand = relationship("Brand", back_populates="products")

    # Relationship to reviews and order items
    reviews = relationship("Review", back_populates="product", cascade="all, delete")
    order_items = relationship("OrderItem", back_populates="product", cascade="all, delete")

    def __repr__(self):
        return f"<Product(name='{self.name}', price={self.price})>"


# -----------------------
# Customer Model
# -----------------------
class Customer(Base):
    __tablename__ = 'customers'

    id = Column(Integer, primary_key=True)
    first_name = Column(String, nullable=False)
    last_name = Column(String, nullable=False)
    email = Column(String, unique=True, nullable=False)
    phone = Column(String)
    city = Column(String)
    registration_date = Column(Date)
    created_at = Column(TIMESTAMP)

    # Relationship to orders and reviews
    orders = relationship("Order", back_populates="customer", cascade="all, delete")
    reviews = relationship("Review", back_populates="customer", cascade="all, delete")

    def __repr__(self):
        return f"<Customer(name='{self.first_name} {self.last_name}')>"


# -----------------------
# Order Model
# -----------------------
class Order(Base):
    __tablename__ = 'orders'

    id = Column(Integer, primary_key=True)
    customer_id = Column(Integer, ForeignKey('customers.id', ondelete='CASCADE'), nullable=False)
    order_date = Column(Date)
    delivery_date = Column(Date, nullable=True)
    total_amount = Column(DECIMAL)
    status = Column(String, default='pending')
    shipping_city = Column(String)
    created_at = Column(TIMESTAMP)

    # Relationship to customer and order items
    customer = relationship("Customer", back_populates="orders")
    order_items = relationship("OrderItem", back_populates="order", cascade="all, delete")

    def __repr__(self):
        return f"<Order(id={self.id}, status='{self.status}', total={self.total_amount})>"


# -----------------------
# OrderItem Model
# -----------------------
class OrderItem(Base):
    __tablename__ = 'order_items'

    id = Column(Integer, primary_key=True)
    order_id = Column(Integer, ForeignKey('orders.id', ondelete='CASCADE'), nullable=False)
    product_id = Column(Integer, ForeignKey('products.id', ondelete='CASCADE'), nullable=False)
    quantity = Column(Integer, nullable=False)
    unit_price = Column(DECIMAL, nullable=False)
    created_at = Column(TIMESTAMP)

    # Constraints
    __table_args__ = (
        CheckConstraint('quantity > 0', name='check_quantity_positive'),
        CheckConstraint('unit_price > 0', name='check_unit_price_positive'),
    )

    # Relationships
    order = relationship("Order", back_populates="order_items")
    product = relationship("Product", back_populates="order_items")

    def __repr__(self):
        return f"<OrderItem(order_id={self.order_id}, product_id={self.product_id}, qty={self.quantity})>"


# -----------------------
# Review Model
# -----------------------
class Review(Base):
    __tablename__ = 'reviews'

    id = Column(Integer, primary_key=True)
    product_id = Column(Integer, ForeignKey('products.id', ondelete='CASCADE'), nullable=False)
    customer_id = Column(Integer, ForeignKey('customers.id', ondelete='CASCADE'), nullable=False)
    rating = Column(Integer)
    comment = Column(Text)
    review_date = Column(Date)
    created_at = Column(TIMESTAMP)

    # Constraints
    __table_args__ = (
        CheckConstraint('rating >= 1 AND rating <= 5', name='check_rating_range'),
    )

    # Relationships
    product = relationship("Product", back_populates="reviews")
    customer = relationship("Customer", back_populates="reviews")

    def __repr__(self):
        return f"<Review(product_id={self.product_id}, rating={self.rating})>"
