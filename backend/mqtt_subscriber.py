#!/usr/bin/env python3
"""
Simple MQTT Subscriber for restaurant orders.

This script demonstrates how to subscribe to the 'restaurant/orders' topic
and display received messages.

Usage:
    python mqtt_subscriber.py

Author: Assistant
"""

import sys
import os

# Add the parent directory to the Python path so we can import our MQTT class
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from mqtt_restaurant_orders import RestaurantOrderMQTT


def main():
    """Main function to run the subscriber."""
    print("🍽️  Restaurant Orders MQTT Subscriber")
    print("=" * 40)
    print("Listening for orders on 'restaurant/orders'...")
    print("Press Ctrl+C to stop.\n")

    # Create and start the subscriber
    subscriber = RestaurantOrderMQTT()
    subscriber.start_subscriber()


if __name__ == "__main__":
    main()
