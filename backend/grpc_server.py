#!/usr/bin/env python3
"""
gRPC Server for Restaurant Service

This server implements the RestaurantService defined in restaurant.proto,
providing restaurant details using the Django Restaurant model.

Usage:
    python grpc_server.py

Author: Assistant
"""

import os
import sys
import django
from concurrent import futures
import grpc
import time
from datetime import datetime

# Add the current directory to the path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# Set up Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mysite.settings')
django.setup()

# Import generated gRPC code
import restaurant_pb2
import restaurant_pb2_grpc

# Import Django model
from restaurant_app.models import Restaurant


class RestaurantServiceServicer(restaurant_pb2_grpc.RestaurantServiceServicer):
    """gRPC servicer for RestaurantService."""

    def GetRestaurant(self, request, context):
        """
        Get restaurant details by ID.

        Args:
            request: GetRestaurantRequest with restaurant_id
            context: gRPC context

        Returns:
            GetRestaurantResponse with restaurant details
        """
        try:
            # Get restaurant from database
            restaurant = Restaurant.objects.get(id=request.restaurant_id, is_active=True)

            # Convert Django model to protobuf message
            restaurant_proto = restaurant_pb2.Restaurant(
                id=str(restaurant.id),
                name=restaurant.name,
                address=restaurant.address,
                phone_number=restaurant.phone_number,
                rating=float(restaurant.rating) if restaurant.rating else 0.0,
                created_at=restaurant.created_at.isoformat() if restaurant.created_at else "",
                updated_at=restaurant.updated_at.isoformat() if restaurant.updated_at else "",
                is_active=restaurant.is_active
            )

            return restaurant_pb2.GetRestaurantResponse(restaurant=restaurant_proto)

        except Restaurant.DoesNotExist:
            # Restaurant not found
            context.set_code(grpc.StatusCode.NOT_FOUND)
            context.set_details(f"Restaurant with ID {request.restaurant_id} not found")
            return restaurant_pb2.GetRestaurantResponse()

        except Exception as e:
            # Internal server error
            context.set_code(grpc.StatusCode.INTERNAL)
            context.set_details(f"Internal server error: {str(e)}")
            return restaurant_pb2.GetRestaurantResponse()


def serve():
    """Start the gRPC server."""
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    restaurant_pb2_grpc.add_RestaurantServiceServicer_to_server(
        RestaurantServiceServicer(), server
    )

    # Use an insecure port (for development only)
    port = '50051'
    server.add_insecure_port(f'[::]:{port}')

    print("🚀 Starting gRPC server on port 50051...")
    server.start()

    try:
        while True:
            time.sleep(86400)  # Keep server running
    except KeyboardInterrupt:
        print("\n🛑 Shutting down gRPC server...")
        server.stop(0)


if __name__ == '__main__':
    serve()
