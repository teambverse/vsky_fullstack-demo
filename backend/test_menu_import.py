#!/usr/bin/env python3
"""
Test script for menu import functionality.
"""

import os
import sys
import django
import json

# Add the current directory to the path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

# Set up Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mysite.settings')
django.setup()

from menu_imports.parsers import get_parser
from menu_imports.services import MenuDataValidator, MenuDataNormalizer, MultilingualHandler
from menu_imports.importer import MenuDataImporter
from restaurant_app.models import Restaurant


def test_excel_import():
    """Test importing an Excel file."""
    print("Testing Excel import...")

    # Sample Excel data as bytes (normally would be from file upload)
    # This is a simplified test - in reality, you'd have an actual Excel file
    sample_data = [
        {'name': '10" Pizza', 'price': 12.99, 'category': 'Pizza', 'description': 'Large pizza'},
        {'name': 'Caesar Salad', 'price': 8.99, 'category': 'Salad'},
        {'name': 'Burger', 'price': 10.99, 'category': 'Burger', 'description': 'Beef burger'},
    ]

    # Test parser (normally would use actual file)
    # parser = get_parser('test.xlsx')
    # items = parser.parse(file_content, 'test.xlsx')

    # For testing, use sample data directly
    items = sample_data

    # Test validation
    validator = MenuDataValidator()
    valid_items, errors = validator.validate_items(items)
    print(f"Valid items: {len(valid_items)}, Errors: {len(errors)}")

    # Test normalization
    normalizer = MenuDataNormalizer()
    normalized = normalizer.normalize_items(valid_items, 'test-restaurant-id')
    print(f"Normalized item: {normalized[0] if normalized else 'None'}")

    # Test import
    importer = MenuDataImporter()
    results = importer.import_menu_data(normalized, 'test-restaurant-id')
    print(f"Import results: {results}")


def test_json_import():
    """Test importing JSON data."""
    print("\nTesting JSON import...")

    sample_json = [
        {'name': 'Pasta', 'price': 11.99, 'category': 'Pasta', 'name_es': 'Pasta'},
        {'name': 'Soda', 'price': 2.99, 'category': 'Drink'},
    ]

    # Test multilingual handling
    multilingual = MultilingualHandler()
    processed = multilingual.process_multilingual_data(sample_json)
    print(f"Processed items: {processed}")


if __name__ == '__main__':
    test_excel_import()
    test_json_import()
    print("\n✅ Menu import system tests completed!")
