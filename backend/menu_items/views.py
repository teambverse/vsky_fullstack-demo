from rest_framework import status
from rest_framework.views import APIView
from .serializers import MenuItemDetailSerializer, MenuItemSerializer, MenuItemTranslationSerializer
from .models import MenuItem
from common.exception_handler import ApiError
from django.db.models import Q
from common.response_handler import (
    data_response,
    paginated_response,
)

class MenuItemViewSet(APIView):
    def post(self, request):
        
        serializer = MenuItemSerializer(data=request.data, partial=True)
        if serializer.is_valid():
            entity = serializer.save()
            return data_response(
                MenuItemDetailSerializer(entity).data,
                "Menu Item created successfully",
                status.HTTP_201_CREATED,
            )
        raise ApiError(serializer.errors, status.HTTP_400_BAD_REQUEST)
    
    def put(self, request, pk):
        try:
            entity = MenuItem.objects.get(pk=pk)
        except MenuItem.DoesNotExist:
            raise ApiError("Menu Item not found", status.HTTP_404_NOT_FOUND)

        serializer = MenuItemSerializer(entity, data=request.data, partial=True)
        if serializer.is_valid():
            updated_entity = serializer.save()
            return data_response(
                MenuItemDetailSerializer(updated_entity).data,
                "Menu Item updated successfully",
                status.HTTP_200_OK,
            )
        raise ApiError(serializer.errors, status.HTTP_400_BAD_REQUEST)
    
    def get(self, request, pk=None):
        if pk:
            try:
                entity = MenuItem.objects.get(pk=pk)
                return data_response(
                    MenuItemDetailSerializer(entity).data,
                    "Menu Item retrieved successfully",
                    status.HTTP_200_OK,
                )
            except MenuItem.DoesNotExist:
                raise ApiError("Menu Item not found", status.HTTP_404_NOT_FOUND)
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
            items = MenuItem.objects.filter(filters).order_by(sort)
            total = items.count()
            paginated_items = items[offset : offset + page_size]

            serialized_items = MenuItemDetailSerializer(paginated_items, many=True).data

            return paginated_response(
                items=serialized_items,
                total=total,
                page_size=page_size,
                page_no=page_no,
                message="Menu Item retrieved successfully",
            )
            
class MenuItemTranslationViewSet(APIView):
    def post(self, request):
        serializer = MenuItemTranslationSerializer(data=request.data, partial=True)
        if serializer.is_valid():
            entity = serializer.save()
            return data_response(
                MenuItemTranslationSerializer(entity).data,
                "Menu Item Translation created successfully",
                status.HTTP_201_CREATED,
            )
        raise ApiError(serializer.errors, status.HTTP_400_BAD_REQUEST)