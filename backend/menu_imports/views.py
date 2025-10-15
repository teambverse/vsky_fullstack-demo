#!/usr/bin/env python3
"""
API views for menu import functionality.
"""

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.parsers import MultiPartParser, FormParser
from django.shortcuts import get_object_or_404
import uuid
import os
import logging

from .parsers import get_parser
from .services import MenuDataValidator, MenuDataNormalizer, MultilingualHandler
from .importer import MenuDataImporter
from restaurant_app.models import Restaurant

logger = logging.getLogger(__name__)


class MenuUploadView(APIView):
    """Handle menu file uploads."""
    parser_classes = (MultiPartParser, FormParser)

    def post(self, request):
        """Upload and process menu file."""
        file_obj = request.FILES.get('file')
        restaurant_id = request.data.get('restaurant_id')

        if not file_obj:
            return Response({'error': 'No file provided'}, status=status.HTTP_400_BAD_REQUEST)

        if not restaurant_id:
            return Response({'error': 'Restaurant ID required'}, status=status.HTTP_400_BAD_REQUEST)

        # Validate restaurant exists
        try:
            restaurant = Restaurant.objects.get(id=restaurant_id, is_active=True)
        except Restaurant.DoesNotExist:
            return Response({'error': 'Invalid restaurant ID'}, status=status.HTTP_400_BAD_REQUEST)

        # Validate file size (10MB limit)
        if file_obj.size > 10 * 1024 * 1024:
            return Response({'error': 'File too large (max 10MB)'}, status=status.HTTP_400_BAD_REQUEST)

        # Generate upload ID for tracking
        upload_id = str(uuid.uuid4())

        try:
            # Read file content
            file_content = file_obj.read()

            # Get appropriate parser
            parser = get_parser(file_obj.name)

            # Parse file
            raw_items = parser.parse(file_content, file_obj.name)

            if not raw_items:
                return Response({'error': 'No valid items found in file'}, status=status.HTTP_400_BAD_REQUEST)

            # Validate items
            validator = MenuDataValidator()
            valid_items, errors = validator.validate_items(raw_items)

            if not valid_items:
                return Response({
                    'error': 'No valid items found',
                    'errors': errors
                }, status=status.HTTP_400_BAD_REQUEST)

            # Normalize items
            normalizer = MenuDataNormalizer()
            normalized_items = normalizer.normalize_items(valid_items, restaurant_id)

            # Handle multilingual data
            multilingual_handler = MultilingualHandler()
            processed_items = multilingual_handler.process_multilingual_data(normalized_items)

            # Import to database
            importer = MenuDataImporter()
            import_results = importer.import_menu_data(processed_items, restaurant_id)

            return Response({
                'upload_id': upload_id,
                'message': 'Menu imported successfully',
                'results': import_results,
                'errors': import_results['errors']
            }, status=status.HTTP_201_CREATED)

        except ValueError as e:
            return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            logger.error(f"Upload error for {upload_id}: {e}")
            return Response({'error': 'Internal server error'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class MenuImportStatusView(APIView):
    """Check status of menu imports (placeholder for async processing)."""

    def get(self, request, upload_id):
        """Get status of menu import."""
        # For now, return a placeholder response
        # In a real implementation, this would check async job status
        return Response({
            'upload_id': upload_id,
            'status': 'completed',
            'message': 'Import completed successfully'
        })
