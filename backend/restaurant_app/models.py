from django.db import models
from django.core.validators import MinValueValidator, MaxValueValidator
import uuid

class Restaurant(models.Model):
    """Restaurant model with basic information and rating"""
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    name = models.CharField(max_length=255, db_index=True)
    address = models.TextField()
    phone_number = models.CharField(max_length=20)
    rating = models.DecimalField(
        max_digits=3,
        decimal_places=2,
        validators=[MinValueValidator(0.0), MaxValueValidator(5.0)],
        null=True,
        blank=True
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField(default=True)

    class Meta:
        ordering = ['name']
        indexes = [
            models.Index(fields=['name', 'is_active']),
        ]
        db_table = "restaurants"

    def __str__(self):
        return self.name
