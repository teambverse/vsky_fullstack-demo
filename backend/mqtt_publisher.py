#!/usr/bin/env python3
"""
Simple MQTT Publisher for restaurant orders.

This script demonstrates how to publish messages to the 'restaurant/orders' topic.

Usage:
    python mqtt_publisher.py

Author: Assistant
"""

import sys
import os
import json

# Add the parent directory to the Python path so we can import our MQTT class
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from mqtt_restaurant_orders import RestaurantOrderMQTT


def main():
    """Main function to run the publisher."""
    print("🍽️  Restaurant Orders MQTT Publisher")
    print("=" * 40)

    # Create MQTT client
    publisher = RestaurantOrderMQTT()

    # Sample order to publish
    sample_order = {
        "order_id": "ORD-003",
        "customer_name": "Carol Davis",
        "items": [
            {"name": "Spaghetti Carbonara", "quantity": 1, "price": 14.99},
            {"name": "Garlic Bread", "quantity": 2, "price": 5.99}
        ],
        "total_amount": 26.97,
        "timestamp": "2025-01-14T16:45:00Z"
    }

    # Connect and wait for connection
    if publisher.connect() and publisher.wait_for_connection():
        print("📤 Publishing sample order...")
        success = publisher.publish_order(sample_order)

        if success:
            print("✅ Order published successfully!")
        else:
            print("❌ Failed to publish order.")

        publisher.disconnect()
    else:
        print("❌ Could not connect to MQTT broker.")


if __name__ == "__main__":
    main()
