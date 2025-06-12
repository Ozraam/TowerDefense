extends ProgressBar

func _ready() -> void:
    Inventory.health_changed.connect(_on_health_changed)
    value = Inventory.health  # Initialize the progress bar with current health
    max_value = Inventory.health  # Assuming max health is constant, adjust if needed

func _on_health_changed(new_health: int) -> void:
    # Update the progress bar value based on the new health
    value = new_health
    