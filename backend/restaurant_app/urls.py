from django.urls import path
from .views import RestaurantViewSet

urlpatterns = [
    path('', RestaurantViewSet.as_view(), name='Restaurant-list'),  # POST (Create) and GET (Search for list)
    path('<pk>', RestaurantViewSet.as_view(), name='Restaurant-detail'),  # GET (By ID), PUT (Update), DELETE
]