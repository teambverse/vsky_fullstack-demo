#!/usr/bin/env python3
"""
Menu data parsers for different file formats.

Supports Excel, CSV, and JSON formats with encoding detection.
"""

import json
import csv
import io
import pandas as pd
from typing import List, Dict, Any
import chardet
import logging

logger = logging.getLogger(__name__)


class MenuDataParser:
    """Base class for menu data parsers."""

    def parse(self, file_content: bytes, filename: str) -> List[Dict[str, Any]]:
        """Parse file content into list of menu items."""
        raise NotImplementedError


class ExcelParser(MenuDataParser):
    """Parser for Excel files (.xlsx, .xls)."""

    def parse(self, file_content: bytes, filename: str) -> List[Dict[str, Any]]:
        try:
            df = pd.read_excel(io.BytesIO(file_content))

            # Normalize column names
            df.columns = [col.lower().strip() for col in df.columns]

            items = []
            for _, row in df.iterrows():
                item = self._row_to_item(row)
                if item:
                    items.append(item)

            return items
        except Exception as e:
            logger.error(f"Error parsing Excel file {filename}: {e}")
            raise ValueError(f"Invalid Excel file format: {str(e)}")

    def _row_to_item(self, row: pd.Series) -> Dict[str, Any]:
        """Convert pandas row to menu item dict."""
        # Map common column names
        name = row.get('name') or row.get('item') or row.get('product')
        price = row.get('price') or row.get('cost') or row.get('amount')
        category = row.get('category') or row.get('type') or row.get('group')
        description = row.get('description') or row.get('desc')

        if not name or not price:
            return None

        try:
            # Convert price to float
            price_float = float(price)
        except (ValueError, TypeError):
            return None

        return {
            'name': str(name).strip(),
            'price': price_float,
            'category': str(category).strip() if category else 'General',
            'description': str(description).strip() if description else '',
        }


class CSVParser(MenuDataParser):
    """Parser for CSV files with encoding detection."""

    def parse(self, file_content: bytes, filename: str) -> List[Dict[str, Any]]:
        try:
            # Detect encoding
            encoding = chardet.detect(file_content)['encoding'] or 'utf-8'

            # Read CSV
            csv_content = file_content.decode(encoding)
            reader = csv.DictReader(io.StringIO(csv_content))

            items = []
            for row in reader:
                item = self._row_to_item(row)
                if item:
                    items.append(item)

            return items
        except Exception as e:
            logger.error(f"Error parsing CSV file {filename}: {e}")
            raise ValueError(f"Invalid CSV file format: {str(e)}")

    def _row_to_item(self, row: Dict[str, str]) -> Dict[str, Any]:
        """Convert CSV row to menu item dict."""
        # Normalize keys
        row = {k.lower().strip(): v.strip() for k, v in row.items()}

        name = row.get('name') or row.get('item') or row.get('product')
        price = row.get('price') or row.get('cost') or row.get('amount')
        category = row.get('category') or row.get('type') or row.get('group')
        description = row.get('description') or row.get('desc')

        if not name or not price:
            return None

        try:
            price_float = float(price.replace('$', '').replace(',', ''))
        except (ValueError, AttributeError):
            return None

        return {
            'name': name,
            'price': price_float,
            'category': category if category else 'General',
            'description': description if description else '',
        }


class JSONParser(MenuDataParser):
    """Parser for JSON files."""

    def parse(self, file_content: bytes, filename: str) -> List[Dict[str, Any]]:
        try:
            data = json.loads(file_content.decode('utf-8'))

            # Handle different JSON structures
            if isinstance(data, list):
                items = data
            elif isinstance(data, dict) and 'items' in data:
                items = data['items']
            else:
                raise ValueError("JSON must be a list or contain 'items' key")

            # Validate and normalize items
            normalized_items = []
            for item in items:
                normalized = self._normalize_item(item)
                if normalized:
                    normalized_items.append(normalized)

            return normalized_items
        except Exception as e:
            logger.error(f"Error parsing JSON file {filename}: {e}")
            raise ValueError(f"Invalid JSON file format: {str(e)}")

    def _normalize_item(self, item: Dict[str, Any]) -> Dict[str, Any]:
        """Normalize JSON item to standard format."""
        if not isinstance(item, dict):
            return None

        name = item.get('name') or item.get('title')
        price = item.get('price')
        category = item.get('category')
        description = item.get('description')

        if not name or not price:
            return None

        try:
            price_float = float(price)
        except (ValueError, TypeError):
            return None

        return {
            'name': str(name).strip(),
            'price': price_float,
            'category': str(category).strip() if category else 'General',
            'description': str(description).strip() if description else '',
        }


def get_parser(filename: str) -> MenuDataParser:
    """Get appropriate parser based on file extension."""
    ext = filename.lower().split('.')[-1]

    if ext in ['xlsx', 'xls']:
        return ExcelParser()
    elif ext == 'csv':
        return CSVParser()
    elif ext == 'json':
        return JSONParser()
    else:
        raise ValueError(f"Unsupported file format: {ext}")
