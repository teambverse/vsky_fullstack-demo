from django.urls import path
from .views import MenuItemViewSet, MenuItemTranslationViewSet

urlpatterns = [
    path('', MenuItemViewSet.as_view(), name='MenuItem-list'),  # POST (Create) and GET (Search for list)
    path('<int:pk>', MenuItemViewSet.as_view(), name='MenuItem-detail'),  # GET (By ID), PUT (Update), DELETE
    path('translations', MenuItemTranslationViewSet.as_view(), name='MenuItem-translation-list'),  # POST for creating translations
]