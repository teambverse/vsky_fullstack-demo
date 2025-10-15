import redis
import json
import os
import django
from django.conf import settings

# Set up Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mysite.settings')
django.setup()

# Now import Django models
from restaurant_app.models import Restaurant

# Connect to Redis (assuming Redis is running on localhost:6379)
r = redis.Redis(host='localhost', port=6379, db=0)

def get_restaurant_details(restaurant_id):
    """
    Retrieve restaurant details by ID, using Redis for caching.
    If not in cache, fetch from the connected database and store in Redis with expiration.
    """
    cache_key = f'restaurant:{restaurant_id}'
    
    # Check if data is in Redis cache
    cached_data = r.get(cache_key)
    if cached_data:
        print(f"Fetching from cache for restaurant ID: {restaurant_id}")
        return json.loads(cached_data)
    
    # If not in cache, fetch from database
    print(f"Fetching from database for restaurant ID: {restaurant_id}")
    try:
        restaurant = Restaurant.objects.get(id=restaurant_id)
        restaurant_data = {
            'id': str(restaurant.id),
            'name': restaurant.name,
            'address': restaurant.address,
            'phone_number': restaurant.phone_number,
            'rating': float(restaurant.rating) if restaurant.rating else None,
            'is_active': restaurant.is_active,
            'created_at': restaurant.created_at.isoformat() if restaurant.created_at else None,
            'updated_at': restaurant.updated_at.isoformat() if restaurant.updated_at else None,
        }
    except Restaurant.DoesNotExist:
        return None  # Restaurant not found
    
    # Store in Redis with expiration (300 seconds = 5 minutes)
    r.setex(cache_key, 300, json.dumps(restaurant_data))
    return restaurant_data

# Example usage
if __name__ == "__main__":
    # Test the function (replace with actual ID from your database)
    restaurant_id = 'a04de459-55d2-4819-adc3-6086fdda340b'
    details = get_restaurant_details(restaurant_id)
    if details:
        print(f"Restaurant Details: {details}")
    else:
        print("Restaurant not found.")
