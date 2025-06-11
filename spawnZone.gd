extends Area2D

var is_mouse_in = false

var mouse_pos = Vector2()


func _on_mouse_entered() -> void:
	is_mouse_in = true


func _on_mouse_exited() -> void:
	is_mouse_in = false


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseMotion:
		mouse_pos = to_local(get_global_mouse_position())
		
