#!/usr/bin/env python3
"""
gRPC Client for Restaurant Service

This client demonstrates how to call the RestaurantService GetRestaurant method.

Usage:
    python grpc_client.py [restaurant_id]

Example:
    python grpc_client.py 123e4567-e89b-12d3-a456-426614174000

Author: Assistant
"""

import sys
import grpc

# Import generated gRPC code
import restaurant_pb2
import restaurant_pb2_grpc


def get_restaurant(restaurant_id: str) -> restaurant_pb2.Restaurant:
    """
    Get restaurant details using gRPC.

    Args:
        restaurant_id (str): UUID of the restaurant

    Returns:
        Restaurant: Restaurant protobuf message
    """
    # Create gRPC channel
    channel = grpc.insecure_channel('localhost:50051')

    # Create stub
    stub = restaurant_pb2_grpc.RestaurantServiceStub(channel)

    # Create request
    request = restaurant_pb2.GetRestaurantRequest(restaurant_id=restaurant_id)

    try:
        # Call the service
        response = stub.GetRestaurant(request)

        if response.restaurant:
            return response.restaurant
        else:
            print("❌ Restaurant not found")
            return None

    except grpc.RpcError as e:
        print(f"❌ gRPC error: {e.code()} - {e.details()}")
        return None
    except Exception as e:
        print(f"❌ Error: {e}")
        return None


def print_restaurant_details(restaurant: restaurant_pb2.Restaurant):
    """Print restaurant details in a formatted way."""
    if not restaurant:
        return

    print("🍽️  Restaurant Details")
    print("=" * 30)
    print(f"ID: {restaurant.id}")
    print(f"Name: {restaurant.name}")
    print(f"Address: {restaurant.address}")
    print(f"Phone: {restaurant.phone_number}")
    print(f"Rating: {restaurant.rating:.1f}/5.0")
    print(f"Active: {'Yes' if restaurant.is_active else 'No'}")
    print(f"Created: {restaurant.created_at}")
    print(f"Updated: {restaurant.updated_at}")


def main():
    """Main function to run the client."""
    if len(sys.argv) != 2:
        print("Usage: python grpc_client.py <restaurant_id>")
        print("Example: python grpc_client.py 123e4567-e89b-12d3-a456-426614174000")
        sys.exit(1)

    restaurant_id = sys.argv[1]

    print(f"🔍 Getting restaurant details for ID: {restaurant_id}")

    restaurant = get_restaurant(restaurant_id)

    if restaurant:
        print_restaurant_details(restaurant)
        print("✅ Successfully retrieved restaurant details!")
    else:
        print("❌ Failed to retrieve restaurant details.")


if __name__ == '__main__':
    main()
