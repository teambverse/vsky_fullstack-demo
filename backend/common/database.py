from django.db import connections
from django.db.utils import OperationalError

def check_db_connection():
    db_conn = connections['default']
    try:
        db_conn.cursor()
        print("✅ Database connected successfully.")
    except OperationalError as e:
        print("❌ Database connection failed.")
        print(f"Error: {e}")