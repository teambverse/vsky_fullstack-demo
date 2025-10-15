from rest_framework import serializers
from decimal import Decimal
from .models import (
    Restaurant
)

class RestaurantSerializer(serializers.ModelSerializer):
    """Serializer for Restaurant model"""
    menu_items_count = serializers.SerializerMethodField()

    class Meta:
        model = Restaurant
        fields = [
            'id', 'name', 'address', 'phone_number', 'rating',
            'is_active', 'created_at', 'updated_at', 'menu_items_count'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']

    def get_menu_items_count(self, obj):
        return obj.menu_items.filter(is_available=True).count()

    def validate_rating(self, value):
        if value is not None and (value < 0 or value > 5):
            raise serializers.ValidationError("Rating must be between 0 and 5")
        return value

    def validate_phone_number(self, value):
        import re
        if not re.match(r'^\+?[\d\s\-\(\)]{10,20}$', value):
            raise serializers.ValidationError("Invalid phone number format")
        return value

class RestaurantCreateSerializer(serializers.ModelSerializer):
    """Serializer for creating restaurants"""
    class Meta:
        model = Restaurant
        fields = ['name', 'address', 'phone_number', 'rating']