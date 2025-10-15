#!/usr/bin/env python3
"""
Database importer for menu items with idempotency and transaction safety.
"""

import logging
from typing import List, Dict, Any, Tuple
from django.db import transaction, IntegrityError
from django.core.exceptions import ValidationError

from menu_items.models import MenuItem, MenuItemTranslation
from .services import MenuDataNormalizer

logger = logging.getLogger(__name__)


class MenuDataImporter:
    """Imports menu data into database with deduplication and idempotency."""

    def __init__(self):
        self.normalizer = MenuDataNormalizer()

    def import_menu_data(self, items: List[Dict[str, Any]], restaurant_id: str) -> Dict[str, Any]:
        """Import menu items with full transaction safety."""
        results = {
            'total_items': len(items),
            'imported': 0,
            'updated': 0,
            'skipped': 0,
            'errors': []
        }

        # Normalize items first
        normalized_items = self.normalizer.normalize_items(items, restaurant_id)

        with transaction.atomic():
            for item in normalized_items:
                try:
                    # Try to import individual item
                    success = self._import_single_item(item)
                    if success == 'imported':
                        results['imported'] += 1
                    elif success == 'updated':
                        results['updated'] += 1
                    else:
                        results['skipped'] += 1

                except Exception as e:
                    results['errors'].append(f"Error importing {item.get('name', 'Unknown')}: {str(e)}")
                    logger.error(f"Import error for {item}: {e}")

        return results

    def _import_single_item(self, item: Dict[str, Any]) -> str:
        """Import or update a single menu item."""
        # Check if item already exists by name and category
        existing_item = MenuItem.objects.filter(
            restaurant_id=item['restaurant_id'],
            name=item['name'],
            category=item['category']
        ).first()

        if existing_item:
            # Update existing item
            existing_item.price = item['price']
            existing_item.description = item['description']
            existing_item.save()

            # Update translations
            self._update_translations(existing_item, item.get('translations', {}))

            return 'updated'
        else:
            # Create new item
            new_item = MenuItem.objects.create(
                restaurant_id=item['restaurant_id'],
                name=item['name'],
                category=item['category'],
                price=item['price'],
                description=item['description'],
            )

            # Add translations
            self._add_translations(new_item, item.get('translations', {}))

            return 'imported'

    def _add_translations(self, menu_item: MenuItem, translations: Dict[str, str]):
        """Add multilingual translations for a menu item."""
        for lang_code, name in translations.items():
            if name and name != menu_item.name:  # Avoid duplicate default language
                MenuItemTranslation.objects.get_or_create(
                    menu_item=menu_item,
                    language=lang_code,
                    defaults={
                        'name': name,
                        'description': translations.get(f'description_{lang_code}', '')
                    }
                )

    def _update_translations(self, menu_item: MenuItem, translations: Dict[str, str]):
        """Update existing translations for a menu item."""
        for lang_code, name in translations.items():
            if name:
                translation, created = MenuItemTranslation.objects.get_or_create(
                    menu_item=menu_item,
                    language=lang_code,
                    defaults={'name': name}
                )
                if not created:
                    translation.name = name
                    translation.save()
