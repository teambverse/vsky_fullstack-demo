
def set_unique_ids(objects, model_class, unique_field="uniqueId", start_value=1, padding=6):
    """
    Set unique IDs for a list of objects.

    Args:
        objects: A list of model instances to assign unique IDs.
        model_class: The model class for which the unique IDs are generated.
        unique_field: The field name where the unique ID is stored (default: "uniqueId").
        start_value: The starting value for the unique ID (default: 1).
        padding: The number of digits to pad the unique ID with (default: 6).

    Returns:
        None. The objects are updated in place with unique IDs.
    """
    # Get the last unique ID from the database
    last_instance = model_class.objects.order_by('-id').first()
    last_unique_id = int(getattr(last_instance, unique_field, start_value - 1)) if last_instance else start_value - 1

    # Assign unique IDs to the objects
    for i, obj in enumerate(objects):
        setattr(obj, unique_field, f"{last_unique_id + i + 1:0{padding}d}")


def capitalize_first_letter(s):
    if not s or not isinstance(s, str):
        return ""
    return s[0].upper() + s[1:].lower()
