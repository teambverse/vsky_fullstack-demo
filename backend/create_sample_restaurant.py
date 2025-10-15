#!/usr/bin/env python3
"""
Create sample restaurant data for testing gRPC service.

Usage:
    python create_sample_restaurant.py

Author: Assistant
"""

import os
import sys
import django
import uuid

# Add the current directory to the path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# Set up Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mysite.settings')
django.setup()

from restaurant_app.models import Restaurant


def create_sample_restaurant():
    """Create a sample restaurant for testing."""
    # Check if restaurant already exists
    existing = Restaurant.objects.filter(name="Sample Pizza Place").first()
    if existing:
        print(f"🍕 Sample restaurant already exists with ID: {existing.id}")
        return existing

    # Create new restaurant
    restaurant = Restaurant.objects.create(
        id=uuid.uuid4(),
        name="Sample Pizza Place",
        address="123 Main Street, Sample City, SC 12345",
        phone_number="+1-555-PIZZA",
        rating=4.5,
        is_active=True
    )

    print(f"✅ Created sample restaurant with ID: {restaurant.id}")
    return restaurant


if __name__ == '__main__':
    create_sample_restaurant()
