from rest_framework import serializers
from decimal import Decimal
from .models import (
    OrderItem
)

class OrderItemSerializer(serializers.ModelSerializer):
    """Serializer for order items"""
    menu_item_name = serializers.CharField(source='menu_item.name', read_only=True)
    menu_item_price = serializers.DecimalField(
        source='menu_item.price', max_digits=10, decimal_places=2, read_only=True
    )

    class Meta:
        model = OrderItem
        fields = [
            'id', 'menu_item', 'menu_item_name', 'menu_item_price',
            'quantity', 'price_per_item', 'total_price', 'notes'
        ]
        read_only_fields = ['id', 'total_price']

    def validate_quantity(self, value):
        if value <= 0:
            raise serializers.ValidationError("Quantity must be greater than 0")
        return value

    def validate_price_per_item(self, value):
        if value <= 0:
            raise serializers.ValidationError("Price per item must be greater than 0")
        return value