from rest_framework import serializers
from decimal import Decimal
from .models import (
    MenuItem,MenuItemTranslation
)

class MenuItemTranslationSerializer(serializers.ModelSerializer):
    """Serializer for menu item translations"""
    class Meta:
        model = MenuItemTranslation
        fields = ['menu_item', 'language', 'name', 'description']

class MenuItemSerializer(serializers.ModelSerializer):
    """Serializer for menu items with translations"""
    translations = MenuItemTranslationSerializer(many=True, read_only=True)

    class Meta:
        model = MenuItem
        fields = [
            'id', 'restaurant', 'name', 'description', 'category', 'price',
            'is_available', 'translations', 'created_at', 'updated_at'
        ]
        read_only_fields = ['id', 'created_at', 'updated_at']

    def validate_price(self, value):
        if value <= 0:
            raise serializers.ValidationError("Price must be greater than 0")
        return value

class MenuItemDetailSerializer(MenuItemSerializer):
    """Detailed serializer for menu items including restaurant info"""
    restaurant_name = serializers.CharField(source='restaurant.name', read_only=True)

    class Meta(MenuItemSerializer.Meta):
        fields = MenuItemSerializer.Meta.fields + ['restaurant_name']