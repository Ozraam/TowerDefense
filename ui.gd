extends Control

func _ready() -> void:
    Inventory.game_over.connect(_on_game_over)
    $GameOver.hide()  # Hide the Game Over UI initially

func _on_game_over() -> void:
    $GameOver.show()  # Show the Game Over UI