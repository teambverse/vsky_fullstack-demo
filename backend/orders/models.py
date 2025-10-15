from django.db import models
from menu_items.models import MenuItem
from django.core.validators import MinValueValidator


class OrderItem(models.Model):
    """Individual items within an order"""

    menu_item = models.ForeignKey(MenuItem, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(validators=[MinValueValidator(1)])
    price_per_item = models.DecimalField(max_digits=10, decimal_places=2)
    total_price = models.DecimalField(max_digits=10, decimal_places=2)

    # Special instructions
    notes = models.TextField(blank=True)

    class Meta:
        db_table = "orders"

    def save(self, *args, **kwargs):
        self.total_price = self.quantity * self.price_per_item
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.quantity}x {self.menu_item.name}"
