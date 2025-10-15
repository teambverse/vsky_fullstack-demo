from rest_framework import status
from rest_framework.views import APIView
from .serializers import RestaurantCreateSerializer, RestaurantSerializer
from .models import Restaurant
from common.exception_handler import ApiError
from django.db.models import Q
from common.response_handler import (
    data_response,
    paginated_response,
)
import redis
import json

class RestaurantViewSet(APIView):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.redis_client = redis.Redis(host='localhost', port=6379, db=0)

    def post(self, request):
        
        serializer = RestaurantCreateSerializer(data=request.data, partial=True)
        if serializer.is_valid():
            entity = serializer.save()
            return data_response(
                RestaurantSerializer(entity).data,
                "Restaurant created successfully",
                status.HTTP_201_CREATED,
            )
        raise ApiError(serializer.errors, status.HTTP_400_BAD_REQUEST)
    
    def put(self, request, pk):
        try:
            entity = Restaurant.objects.get(pk=pk)
        except Restaurant.DoesNotExist:
            raise ApiError("Restaurant not found", status.HTTP_404_NOT_FOUND)

        serializer = RestaurantSerializer(entity, data=request.data, partial=True)
        if serializer.is_valid():
            updated_entity = serializer.save()
            return data_response(
                RestaurantSerializer(updated_entity).data,
                "Restaurant updated successfully",
                status.HTTP_200_OK,
            )
        raise ApiError(serializer.errors, status.HTTP_400_BAD_REQUEST)
    
    def get(self, request, pk=None):
        if pk:
            # Check Redis cache first
            cache_key = f'restaurant:{pk}'
            cached_data = self.redis_client.get(cache_key)
            if cached_data:
                print(f"Fetching from Redis cache for restaurant ID: {pk}")
                return data_response(
                    json.loads(cached_data),
                    "Restaurant retrieved successfully (from cache)",
                    status.HTTP_200_OK,
                )

            # Fetch from database if not in cache
            try:
                entity = Restaurant.objects.get(pk=pk)
                serialized_data = RestaurantSerializer(entity).data
                # Store in Redis with expiration (300 seconds = 5 minutes)
                self.redis_client.setex(cache_key, 300, json.dumps(serialized_data))
                # self.redis_client.delete(cache_key)
                return data_response(
                    serialized_data,
                    "Restaurant retrieved successfully",
                    status.HTTP_200_OK,
                )
            except Restaurant.DoesNotExist:
                raise ApiError("Restaurant not found", status.HTTP_404_NOT_FOUND)
        else:
            # Search for list
            query_params = request.query_params
            filters = Q()

            # Add search filter
            search = query_params.get("search", None)
            if search:
                filters |= Q(name__icontains=search) | Q(
                    status__icontains=search
                )  # Adjust fields as needed

            # Pagination and ordering
            page_no = int(query_params.get("pageNo", 1))
            page_size = int(query_params.get("pageSize", 10))
            offset = (page_no - 1) * page_size
            sort = query_params.get(
                "sort", "-created_at"
            )  # Default sorting by created_at descending

            # Apply filters, ordering, and pagination
            items = Restaurant.objects.filter(filters).order_by(sort)
            total = items.count()
            paginated_items = items[offset : offset + page_size]

            serialized_items = RestaurantSerializer(paginated_items, many=True).data

            return paginated_response(
                items=serialized_items,
                total=total,
                page_size=page_size,
                page_no=page_no,
                message="Restaurant retrieved successfully",
            )