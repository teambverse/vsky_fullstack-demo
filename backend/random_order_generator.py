#!/usr/bin/env python3
"""
Random Restaurant Order Generator with MQTT Publishing

This script generates random restaurant orders and publishes them to the
'restaurant/orders' MQTT topic. It follows the current Django backend setup
and integrates with the existing MQTT infrastructure.

Usage:
    python random_order_generator.py [num_orders] [interval_seconds]

Example:
    python random_order_generator.py 10 5  # Generate 10 orders with 5 second intervals

Author: Assistant
"""

import sys
import os
import json
import time
import random
import uuid
from datetime import datetime, timezone

# Add the parent directory to the Python path so we can import our MQTT class
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from mqtt_restaurant_orders import RestaurantOrderMQTT


class RandomOrderGenerator:
    """Generates random restaurant orders and publishes them via MQTT."""

    def __init__(self):
        """Initialize the random order generator with sample data."""
        self.customer_names = [
            "Alice Johnson", "Bob Smith", "Carol Davis", "David Wilson",
            "Emma Brown", "Frank Miller", "Grace Lee", "Henry Taylor",
            "Iris Chen", "Jack Anderson", "Kelly Martinez", "Liam Garcia",
            "Maya Rodriguez", "Noah Hernandez", "Olivia Lopez", "Paul Gonzalez"
        ]

        self.menu_items = [
            {"name": "Margherita Pizza", "price": 12.99, "category": "Pizza"},
            {"name": "Pepperoni Pizza", "price": 14.99, "category": "Pizza"},
            {"name": "BBQ Chicken Pizza", "price": 16.99, "category": "Pizza"},
            {"name": "Caesar Salad", "price": 8.99, "category": "Salad"},
            {"name": "Greek Salad", "price": 9.99, "category": "Salad"},
            {"name": "Chicken Caesar Salad", "price": 11.99, "category": "Salad"},
            {"name": "Classic Burger", "price": 10.99, "category": "Burger"},
            {"name": "Cheese Burger", "price": 11.99, "category": "Burger"},
            {"name": "Bacon Burger", "price": 13.99, "category": "Burger"},
            {"name": "Chicken Burger", "price": 10.99, "category": "Burger"},
            {"name": "Spaghetti Carbonara", "price": 14.99, "category": "Pasta"},
            {"name": "Fettuccine Alfredo", "price": 13.99, "category": "Pasta"},
            {"name": "Penne Arrabbiata", "price": 12.99, "category": "Pasta"},
            {"name": "French Fries", "price": 4.99, "category": "Sides"},
            {"name": "Garlic Bread", "price": 5.99, "category": "Sides"},
            {"name": "Onion Rings", "price": 6.99, "category": "Sides"},
            {"name": "Cola", "price": 2.99, "category": "Drinks"},
            {"name": "Lemonade", "price": 2.99, "category": "Drinks"},
            {"name": "Orange Juice", "price": 3.49, "category": "Drinks"},
            {"name": "Coffee", "price": 2.49, "category": "Drinks"},
            {"name": "Chocolate Cake", "price": 5.99, "category": "Dessert"},
            {"name": "Tiramisu", "price": 6.99, "category": "Dessert"},
            {"name": "Ice Cream", "price": 4.99, "category": "Dessert"}
        ]

        # MQTT client
        self.mqtt_client = RestaurantOrderMQTT()

    def generate_random_order(self) -> dict:
        """
        Generate a random order following the current backend structure.

        Returns:
            dict: A complete order dictionary
        """
        # Random customer selection
        customer_name = random.choice(self.customer_names)

        # Random number of items (1-5)
        num_items = random.randint(1, 5)
        selected_items = random.sample(self.menu_items, num_items)

        # Create order items with random quantities
        items = []
        total_amount = 0.0

        for item in selected_items:
            quantity = random.randint(1, 3)  # 1-3 of each item
            item_total = item["price"] * quantity
            total_amount += item_total

            items.append({
                "name": item["name"],
                "quantity": quantity,
                "price": round(item["price"], 2),
                "category": item["category"]
            })

        # Generate order ID (UUID format like the backend)
        order_id = f"ORD-{str(uuid.uuid4())[:8].upper()}"

        # Current timestamp in ISO format
        timestamp = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

        order = {
            "order_id": order_id,
            "customer_name": customer_name,
            "items": items,
            "total_amount": round(total_amount, 2),
            "timestamp": timestamp,
            "status": "pending",  # Following typical order workflow
            "special_instructions": self._generate_special_instructions()
        }

        return order

    def _generate_special_instructions(self) -> str:
        """Generate random special instructions for orders."""
        instructions = [
            "",  # No special instructions
            "Extra spicy please",
            "No onions",
            "Gluten-free option",
            "Extra cheese",
            "Well done",
            "Quick delivery",
            "Contactless delivery",
            "Birthday celebration - add candles",
            "Food allergy: nuts"
        ]
        return random.choice(instructions)

    def publish_random_order(self) -> bool:
        """
        Generate and publish a random order.

        Returns:
            bool: True if published successfully, False otherwise
        """
        order = self.generate_random_order()

        print("📋 Generated random order:")
        print(f"   Customer: {order['customer_name']}")
        print(f"   Items: {len(order['items'])}")
        print(f"   Total: ${order['total_amount']}")
        print(f"   Instructions: {order['special_instructions'] or 'None'}")

        return self.mqtt_client.publish_order(order)

    def run_generation(self, num_orders: int = 5, interval_seconds: int = 3):
        """
        Generate and publish multiple random orders.

        Args:
            num_orders (int): Number of orders to generate
            interval_seconds (int): Seconds between each order
        """
        print("🍽️  Random Restaurant Order Generator")
        print("=" * 50)
        print(f"📊 Generating {num_orders} random orders with {interval_seconds}s intervals")
        print(f"📡 Publishing to 'restaurant/orders' topic\n")

        # Connect to MQTT broker
        if not self.mqtt_client.connect():
            print("❌ Failed to connect to MQTT broker. Exiting.")
            return

        try:
            for i in range(num_orders):
                print(f"\n🔄 Order {i+1}/{num_orders}")
                print("-" * 30)

                success = self.publish_random_order()
                if success:
                    print("✅ Order published successfully!")
                else:
                    print("❌ Failed to publish order.")

                if i < num_orders - 1:  # Don't wait after the last order
                    print(f"⏱️  Waiting {interval_seconds} seconds...")
                    time.sleep(interval_seconds)

        except KeyboardInterrupt:
            print("\n🛑 Generation interrupted by user.")
        finally:
            self.mqtt_client.disconnect()
            print("\n🔌 Disconnected from MQTT broker.")


def main():
    """Main function to parse arguments and run the generator."""
    # Parse command line arguments
    num_orders = 5  # Default
    interval_seconds = 3  # Default

    if len(sys.argv) > 1:
        try:
            num_orders = int(sys.argv[1])
        except ValueError:
            print("❌ Invalid number of orders. Using default: 5")

    if len(sys.argv) > 2:
        try:
            interval_seconds = int(sys.argv[2])
        except ValueError:
            print("❌ Invalid interval. Using default: 3 seconds")

    # Validate arguments
    if num_orders <= 0:
        print("❌ Number of orders must be positive.")
        return

    if interval_seconds < 1:
        print("❌ Interval must be at least 1 second.")
        return

    # Create and run the generator
    generator = RandomOrderGenerator()
    generator.run_generation(num_orders, interval_seconds)


if __name__ == "__main__":
    main()
