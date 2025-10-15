#!/usr/bin/env python3
"""
MQTT Publisher and Subscriber for restaurant orders topic.

This script demonstrates how to use the paho-mqtt library to:
1. Subscribe to messages on the "restaurant/orders" topic
2. Publish messages to the "restaurant/orders" topic

Usage:
    python mqtt_restaurant_orders.py

Author: Assistant
"""

import paho.mqtt.client as mqtt
import json
import time
import threading
from typing import Dict, Any


class RestaurantOrderMQTT:
    """
    MQTT client for handling restaurant orders.

    This class provides functionality to both publish and subscribe
    to the 'restaurant/orders' topic.
    """

    def __init__(self, broker_address: str = "broker.emqx.io", broker_port: int = 1883):
        """
        Initialize the MQTT client.

        Args:
            broker_address (str): Address of the MQTT broker
            broker_port (int): Port number for the MQTT broker
        """
        self.broker_address = broker_address
        self.broker_port = broker_port
        self.client = mqtt.Client()

        # Set up callbacks
        self.client.on_connect = self.on_connect
        self.client.on_message = self.on_message
        self.client.on_disconnect = self.on_disconnect

        # Flag to track connection status
        self.connected = False

    def on_connect(self, client, userdata, flags, rc):
        """Callback for when the client connects to the broker."""
        if rc == 0:
            print(f"✅ Connected to MQTT broker at {self.broker_address}:{self.broker_port}")
            self.connected = True

            # Subscribe to the restaurant orders topic
            client.subscribe("restaurant/orders")
            print("📡 Subscribed to topic: restaurant/orders")
        else:
            print(f"❌ Failed to connect to MQTT broker. Return code: {rc}")
            self.connected = False

    def on_message(self, client, userdata, msg):
        """Callback for when a message is received."""
        try:
            # Decode the message payload
            payload = msg.payload.decode('utf-8')

            # Try to parse as JSON for better formatting
            try:
                data = json.loads(payload)
                print(f"📨 Received order on {msg.topic}:")
                print(f"   {json.dumps(data, indent=2)}")
            except json.JSONDecodeError:
                print(f"📨 Received message on {msg.topic}: {payload}")

        except Exception as e:
            print(f"❌ Error processing message: {e}")

    def on_disconnect(self, client, userdata, rc):
        """Callback for when the client disconnects from the broker."""
        print(f"🔌 Disconnected from MQTT broker. Return code: {rc}")
        self.connected = False

    def connect(self) -> bool:
        """
        Connect to the MQTT broker.

        Returns:
            bool: True if connection successful, False otherwise
        """
        try:
            print(f"🔗 Connecting to MQTT broker at {self.broker_address}:{self.broker_port}...")
            self.client.connect(self.broker_address, self.broker_port, 60)

            # Start the network loop in a separate thread
            self.client.loop_start()
            return True
        except Exception as e:
            print(f"❌ Error connecting to broker: {e}")
    def wait_for_connection(self, timeout: int = 5) -> bool:
        """
        Wait for MQTT connection to be established.

        Args:
            timeout (int): Maximum time to wait in seconds

        Returns:
            bool: True if connected, False if timeout
        """
        import time
        start_time = time.time()
        while not self.connected and (time.time() - start_time) < timeout:
            time.sleep(0.1)
        return self.connected

    def disconnect(self):
        """Disconnect from the MQTT broker."""
        self.client.loop_stop()
        self.client.disconnect()

    def publish_order(self, order_data: Dict[str, Any]) -> bool:
        """
        Publish an order to the restaurant/orders topic.

        Args:
            order_data (dict): The order data to publish

        Returns:
            bool: True if published successfully, False otherwise
        """
        if not self.connected:
            print("❌ Not connected to broker. Cannot publish message.")
            return False

        try:
            # Convert order data to JSON
            payload = json.dumps(order_data, indent=2)

            # Publish the message
            result = self.client.publish("restaurant/orders", payload)

            if result.rc == mqtt.MQTT_ERR_SUCCESS:
                print("✅ Order published successfully:")
                print(f"   {payload}")
                return True
            else:
                print(f"❌ Failed to publish order. Error code: {result.rc}")
                return False

        except Exception as e:
            print(f"❌ Error publishing order: {e}")
            return False

    def start_subscriber(self):
        """Start the subscriber and listen for messages."""
        if not self.connect():
            return

        print("\n🎧 Listening for orders on 'restaurant/orders'...")
        print("Press Ctrl+C to stop.\n")

        try:
            while True:
                time.sleep(1)
        except KeyboardInterrupt:
            print("\n🛑 Stopping subscriber...")
        finally:
            self.disconnect()


def example_usage():
    """Demonstrate example usage of the MQTT client."""
    print("🚀 MQTT Restaurant Orders Example")
    print("=" * 40)

    # Create MQTT client instance
    mqtt_client = RestaurantOrderMQTT()

    # Example 1: Publishing orders
    print("\n📤 Publishing sample orders...")

    sample_orders = [
        {
            "order_id": "ORD-001",
            "customer_name": "Alice Johnson",
            "items": [
                {"name": "Margherita Pizza", "quantity": 1, "price": 12.99},
                {"name": "Caesar Salad", "quantity": 1, "price": 8.99}
            ],
            "total_amount": 21.98,
            "timestamp": "2025-01-14T16:30:00Z"
        },
        {
            "order_id": "ORD-002",
            "customer_name": "Bob Smith",
            "items": [
                {"name": "Chicken Burger", "quantity": 2, "price": 10.99},
                {"name": "French Fries", "quantity": 1, "price": 4.99}
            ],
            "total_amount": 26.97,
            "timestamp": "2025-01-14T16:35:00Z"
        }
    ]

    # Connect and publish orders
    if mqtt_client.connect() and mqtt_client.wait_for_connection():
        for order in sample_orders:
            mqtt_client.publish_order(order)
            time.sleep(2)  # Wait 2 seconds between orders

        print("✅ All sample orders published.")
        mqtt_client.disconnect()

    # Example 2: Subscribing to orders
    print("\n📡 Starting subscriber (run this in a separate terminal)...")
    print("To run subscriber separately, uncomment the line below:")
    print("# mqtt_client.start_subscriber()")


if __name__ == "__main__":
    example_usage()
