# database.py
# ============================================
# Database connection setup using SQLAlchemy ORM
# ============================================

from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker, declarative_base
from dotenv import load_dotenv
from sqlalchemy.exc import SQLAlchemyError
import os
#load environmental variables from a .env file
load_dotenv()

# Get the database URL from environment variables

DB_NAME = os.getenv('DB_NAME', 'electronics_db')
DB_USER = os.getenv('DB_USER', 'postgres')
DB_PASSWORD = os.getenv('DB_PASSWORD', 'postgres')
DB_HOST = os.getenv('DB_HOST', 'localhost')
DB_PORT = os.getenv('DB_PORT', '5432')



# Create the database string using the environment variables
DATABASE_URL = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
try:
    engine = create_engine(DATABASE_URL, echo=False)
    SessionLocal = sessionmaker(bind=engine)
    Base = declarative_base()
    print("✅ Database connection configured successfully.")
except SQLAlchemyError as e:
    print("❌ Database connection configuration failed!")
    print(f"Error: {e}")
    raise


def get_session():  
    """Return a new SQLAlchemy session."""
    return SessionLocal()
