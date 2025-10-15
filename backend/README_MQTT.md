# MQTT Restaurant Orders System

This directory contains a complete MQTT-based restaurant order management system with random order generation capabilities.

## Files

- `mqtt_restaurant_orders.py` - Main MQTT client class with both publisher and subscriber functionality
- `mqtt_subscriber.py` - Simple subscriber script for listening to orders
- `mqtt_publisher.py` - Simple publisher script for sending orders
- `random_order_generator.py` - **NEW:** Random order generator that creates and publishes realistic orders
- `README_MQTT.md` - This documentation file

## Prerequisites

Install the required dependencies:
```bash
pip install paho-mqtt
```

## 4. Random Order Generator (`random_order_generator.py`) **[NEW]**

Generate and publish random restaurant orders automatically:

```bash
# Generate 5 orders with 3 second intervals
python random_order_generator.py 5 3

# Generate 10 orders with 2 second intervals
python random_order_generator.py 10 2
```

**Features:**
- Generates realistic random orders with customer names, menu items, quantities
- Includes 20+ menu items across categories (Pizza, Salad, Burger, Pasta, Sides, Drinks, Dessert)
- Random special instructions (allergies, preferences, etc.)
- UUID-based order IDs matching the Django backend structure
- Configurable number of orders and time intervals

**Example Output:**
```
🍽️  Random Restaurant Order Generator
==================================================
📊 Generating 3 random orders with 2s intervals
📡 Publishing to 'restaurant/orders' topic

🔄 Order 1/3
------------------------------
📋 Generated random order:
   Customer: Maya Rodriguez
   Items: 3
   Total: $24.96
   Instructions: No onions
✅ Order published successfully!
⏱️  Waiting 2 seconds...
```

## MQTT Broker

The scripts use `broker.emqx.io` as the default MQTT broker (a public test broker). You can change this by modifying the `broker_address` parameter when creating the `RestaurantOrderMQTT` instance:

```python
client = RestaurantOrderMQTT(broker_address="your-broker.com", broker_port=1883)
```

## Message Format

Messages are expected to be JSON objects with the following structure:

```json
{
    "order_id": "ORD-001",
    "customer_name": "John Doe",
    "items": [
        {
            "name": "Item Name",
            "quantity": 1,
            "price": 10.99
        }
    ],
    "total_amount": 10.99,
    "timestamp": "2025-01-14T16:30:00Z"
}
```

## Usage

### 1. Main Client (`mqtt_restaurant_orders.py`)

This script contains a complete MQTT client class that can both publish and subscribe:

```python
from mqtt_restaurant_orders import RestaurantOrderMQTT

# Create client
client = RestaurantOrderMQTT()

# Publish an order
order = {
    "order_id": "ORD-001",
    "customer_name": "John Doe",
    "items": [{"name": "Pizza", "quantity": 1, "price": 12.99}],
    "total_amount": 12.99
}
client.publish_order(order)

# Subscribe to orders (in a separate instance)
client.start_subscriber()
```

### 2. Simple Subscriber (`mqtt_subscriber.py`)

Run this script to listen for incoming orders:

```bash
python mqtt_subscriber.py
```

This will connect to the MQTT broker and display all received orders on the `restaurant/orders` topic.

### 3. Simple Publisher (`mqtt_publisher.py`)

Run this script to publish a sample order:

```bash
python mqtt_publisher.py
```

### 4. Random Order Generator (`random_order_generator.py`)

Generate and publish random restaurant orders automatically:

```bash
# Generate 5 orders with 3 second intervals
python random_order_generator.py 5 3

# Generate 10 orders with 2 second intervals
python random_order_generator.py 10 2
```

**Features:**
- Generates realistic random orders with customer names, menu items, quantities
- Includes 20+ menu items across categories (Pizza, Salad, Burger, Pasta, Sides, Drinks, Dessert)
- Random special instructions (allergies, preferences, etc.)
- UUID-based order IDs matching the Django backend structure
- Configurable number of orders and time intervals

## Integration with Backend

This MQTT system integrates seamlessly with the Django restaurant backend:

- **Order Structure**: Matches the expected JSON format for restaurant orders
- **UUID Order IDs**: Uses UUID format consistent with Django models
- **Restaurant Context**: Orders include customer info, items, pricing, and timestamps
- **Scalability**: Can handle high-frequency order generation for testing

## Example Workflow

1. **Generate Random Orders**: Use `random_order_generator.py` to simulate real restaurant traffic
2. **Publish via MQTT**: Orders are published to `restaurant/orders` topic
3. **Subscribe in Backend**: Django application subscribes to process orders
4. **Store in Database**: Orders saved with proper validation and relationships

This creates a complete testing pipeline for the restaurant order management system.
