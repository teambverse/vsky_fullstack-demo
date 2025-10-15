#!/usr/bin/env python3
"""
URL patterns for menu imports.
"""

from django.urls import path
from .views import MenuUploadView, MenuImportStatusView

urlpatterns = [
    path('upload/', MenuUploadView.as_view(), name='menu-upload'),
    path('status/<uuid:upload_id>/', MenuImportStatusView.as_view(), name='menu-import-status'),
]
