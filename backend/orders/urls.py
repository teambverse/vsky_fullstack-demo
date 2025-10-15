from django.urls import path
from .views import OrderItemViewSet

urlpatterns = [
    path('', OrderItemViewSet.as_view(), name='OrderItem-list'),  # POST (Create) and GET (Search for list)
    path('/<int:pk>', OrderItemViewSet.as_view(), name='OrderItem-detail'),  # GET (By ID), PUT (Update), DELETE
]