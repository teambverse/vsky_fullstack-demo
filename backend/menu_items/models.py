from django.db import models
from django.core.validators import MinValueValidator
import uuid
from restaurant_app.models import Restaurant

class MenuItem(models.Model):
    """Menu items with normalization and validation"""
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    restaurant = models.ForeignKey(Restaurant, on_delete=models.CASCADE, related_name='menu_items')
    category = models.CharField(max_length=100, db_index=True)

    # Core item data
    name = models.CharField(max_length=255, db_index=True)
    description = models.TextField(blank=True)
    price = models.DecimalField(max_digits=10, decimal_places=2, validators=[MinValueValidator(0)])

    is_available = models.BooleanField(default=True)

    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "menu_items"

    def __str__(self):
        return f"{self.restaurant.name} - {self.name}"


class MenuItemTranslation(models.Model):
    """Multilingual support for menu items"""
    LANGUAGE_CHOICES = [
        ('en', 'English'),
        ('es', 'Spanish'),
        ('fr', 'French'),
        ('de', 'German'),
        ('zh', 'Chinese'),
        ('ar', 'Arabic'),
        ('hi', 'Hindi'),
    ]

    menu_item = models.ForeignKey(MenuItem, on_delete=models.CASCADE, related_name='translations')
    language = models.CharField(max_length=5, choices=LANGUAGE_CHOICES)
    name = models.CharField(max_length=255)
    description = models.TextField(blank=True)

    class Meta:
        unique_together = ['menu_item', 'language']
        indexes = [
            models.Index(fields=['language']),
        ]
        db_table = "menu_item_translations"

    def __str__(self):
        return f"{self.menu_item.name} ({self.get_language_display()})"