from rest_framework import status
from rest_framework.views import APIView
from .serializers import OrderItemSerializer
from .models import OrderItem
from common.exception_handler import ApiError
from django.db.models import Q
from common.response_handler import (
    data_response,
    paginated_response,
)

class OrderItemViewSet(APIView):
    def post(self, request):
        
        serializer = OrderItemSerializer(data=request.data, partial=True)
        if serializer.is_valid():
            entity = serializer.save()
            return data_response(
                OrderItemSerializer(entity).data,
                "Order created successfully",
                status.HTTP_201_CREATED,
            )
        raise ApiError(serializer.errors, status.HTTP_400_BAD_REQUEST)
    
    def put(self, request, pk):
        try:
            entity = OrderItem.objects.get(pk=pk)
        except OrderItem.DoesNotExist:
            raise ApiError("Order not found", status.HTTP_404_NOT_FOUND)

        serializer = OrderItemSerializer(entity, data=request.data, partial=True)
        if serializer.is_valid():
            updated_entity = serializer.save()
            return data_response(
                OrderItemSerializer(updated_entity).data,
                "Order updated successfully",
                status.HTTP_200_OK,
            )
        raise ApiError(serializer.errors, status.HTTP_400_BAD_REQUEST)
    
    def get(self, request, pk=None):
        if pk:
            try:
                entity = OrderItem.objects.get(pk=pk)
                return data_response(
                    OrderItemSerializer(entity).data,
                    "Order retrieved successfully",
                    status.HTTP_200_OK,
                )
            except OrderItem.DoesNotExist:
                raise ApiError("Order not found", status.HTTP_404_NOT_FOUND)
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
            items = OrderItem.objects.filter(filters).order_by(sort)
            total = items.count()
            paginated_items = items[offset : offset + page_size]

            serialized_items = OrderItemSerializer(paginated_items, many=True).data

            return paginated_response(
                items=serialized_items,
                total=total,
                page_size=page_size,
                page_no=page_no,
                message="Order retrieved successfully",
            )
