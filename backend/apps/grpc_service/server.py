from concurrent import futures
import grpc
from django.conf import settings
from apps.grpc_service import restaurant_pb2, restaurant_pb2_grpc
from restaurant_app.models import Restaurant  # Your Django model

class RestaurantServiceServicer(restaurant_pb2_grpc.RestaurantServiceServicer):
    def GetRestaurant(self, request, context):
        try:
            r = Restaurant.objects.get(id=request.id)
        except Restaurant.DoesNotExist:
            context.abort(grpc.StatusCode.NOT_FOUND, "Not found")
        return restaurant_pb2.RestaurantDetails(
            id=str(r.id),
            name=r.name,
            address=r.address,
            phone_number=r.phone_number,
            rating=float(r.rating or 0),
        )

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    restaurant_pb2_grpc.add_RestaurantServiceServicer_to_server(
        RestaurantServiceServicer(), server
    )
    server.add_insecure_port(f"[::]:{settings.GRPC_PORT}")
    server.start()
    server.wait_for_termination()