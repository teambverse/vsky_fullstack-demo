#!/usr/bin/env python3
"""
Menu data validation and normalization services.

Handles data quality checks, normalization, and multilingual support.
"""

import re
import hashlib
from typing import List, Dict, Any, Tuple
import logging

logger = logging.getLogger(__name__)


class MenuDataValidator:
    """Validates menu item data."""

    def validate_items(self, items: List[Dict[str, Any]]) -> Tuple[List[Dict[str, Any]], List[str]]:
        """Validate list of menu items and return valid items + errors."""
        valid_items = []
        errors = []

        for i, item in enumerate(items, 1):
            try:
                if self._validate_item(item):
                    valid_items.append(item)
                else:
                    errors.append(f"Row {i}: Invalid item data")
            except Exception as e:
                errors.append(f"Row {i}: {str(e)}")

        return valid_items, errors

    def _validate_item(self, item: Dict[str, Any]) -> bool:
        """Validate individual menu item."""
        # Required fields
        if not item.get('name') or not item.get('price'):
            return False

        # Data types
        if not isinstance(item['name'], str) or not isinstance(item['price'], (int, float)):
            return False

        # Price validation
        if item['price'] <= 0:
            return False

        # Name length
        if len(item['name']) > 255:
            return False

        # Category validation
        if not item.get('category') or not isinstance(item['category'], str):
            return False

        return True


class MenuDataNormalizer:
    """Normalizes menu item data."""

    def normalize_items(self, items: List[Dict[str, Any]], restaurant_id: str) -> List[Dict[str, Any]]:
        """Normalize menu items and add metadata."""
        normalized = []

        for item in items:
            normalized_item = self._normalize_item(item, restaurant_id)
            if normalized_item:
                normalized.append(normalized_item)

        return normalized

    def _normalize_item(self, item: Dict[str, Any], restaurant_id: str) -> Dict[str, Any]:
        """Normalize individual item."""
        # Normalize name
        normalized_name = self._normalize_name(item['name'])

        # Normalize category
        normalized_category = self._normalize_category(item['category'])

        # Generate unique hash for deduplication
        item_hash = self._generate_item_hash(normalized_name, normalized_category, restaurant_id)

        return {
            'restaurant_id': restaurant_id,
            'name': normalized_name,
            'original_name': item['name'],
            'category': normalized_category,
            'price': item['price'],
            'description': item.get('description', ''),
            'item_hash': item_hash,
        }

    def _normalize_name(self, name: str) -> str:
        """Normalize item name (e.g., '10" Pizza' -> '10 Inch Pizza')."""
        # Handle quotes in names
        name = re.sub(r'(\d+)"', r'\1 Inch', name)

        # Remove extra spaces and special chars
        name = re.sub(r'\s+', ' ', name.strip())

        # Title case
        name = name.title()

        # Handle common abbreviations
        name = re.sub(r'\bPizza\b', 'Pizza', name)

        return name

    def _normalize_category(self, category: str) -> str:
        """Normalize category name."""
        category = category.strip().lower()

        # Map common variations
        category_map = {
            'pizzas': 'Pizza',
            'pizza': 'Pizza',
            'burgers': 'Burger',
            'burger': 'Burger',
            'salads': 'Salad',
            'salad': 'Salad',
            'pasta': 'Pasta',
            'drinks': 'Drink',
            'drink': 'Drink',
            'desserts': 'Dessert',
            'dessert': 'Dessert',
        }

        return category_map.get(category, category.title())

    def _generate_item_hash(self, name: str, category: str, restaurant_id: str) -> str:
        """Generate SHA256 hash for item uniqueness."""
        content = f"{restaurant_id}:{name}:{category}".encode('utf-8')
        return hashlib.sha256(content).hexdigest()


class MultilingualHandler:
    """Handles multilingual menu item names."""

    def process_multilingual_data(self, items: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """Extract and process multilingual names from items."""
        processed = []

        for item in items:
            # Check for multilingual columns (e.g., name_en, name_es)
            translations = {}

            # Default name (usually 'name')
            if 'name' in item:
                translations['en'] = item['name']

            # Look for language-specific columns
            for key, value in item.items():
                if key.startswith('name_') and len(key) == 6:  # name_XX format
                    lang_code = key[5:]  # Extract language code
                    if lang_code in ['en', 'es', 'fr', 'de', 'zh', 'ar', 'hi']:
                        translations[lang_code] = value

            # Update item with translations
            item['translations'] = translations
            processed.append(item)

        return processed
