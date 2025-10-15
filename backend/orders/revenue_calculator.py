def calculate_total_revenue(orders):
    """
    Calculate the total revenue from a list of orders.

    Each order is a dictionary with keys: 'item_name', 'quantity', 'price_per_item'.

    Args:
        orders (list): List of order dictionaries.

    Returns:
        float: Total revenue.

    Raises:
        ValueError: If input is invalid or contains negative values.
    """
    if not isinstance(orders, list):
        raise ValueError("Input must be a list of orders.")

    total_revenue = 0.0

    for order in orders:
        if not isinstance(order, dict):
            raise ValueError("Each order must be a dictionary.")

        # Check for required keys
        required_keys = {'item_name', 'quantity', 'price_per_item'}
        if not required_keys.issubset(order.keys()):
            raise ValueError(f"Order missing required keys: {required_keys - set(order.keys())}")

        quantity = order['quantity']
        price_per_item = order['price_per_item']

        # Validate types and values
        if not isinstance(quantity, int) or quantity <= 0:
            raise ValueError("Quantity must be a positive integer.")
        if not isinstance(price_per_item, (int, float)) or price_per_item < 0:
            raise ValueError("Price per item must be a non-negative number.")

        # Calculate revenue for this order
        total_revenue += quantity * price_per_item

    return total_revenue

# Example usage
if __name__ == "__main__":
    orders = [
        {'item_name': 'Pizza', 'quantity': 2, 'price_per_item': 15.50},
        {'item_name': 'Burger', 'quantity': 1, 'price_per_item': 10.00},
        {'item_name': 'Salad', 'quantity': 3, 'price_per_item': 8.75}
    ]

    total = calculate_total_revenue(orders)
    print(f"Total Revenue: ${total:.2f}")

    # Test edge cases
    print(calculate_total_revenue([]))  # Should be 0.0
