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

func _ready() -> void:
	# create a array mesh to visualize the spawn zone with the collision polygon
	var collision_polygon = $CollisionPolygon2D
	if collision_polygon:
		var polygon = collision_polygon.polygon
		var mesh = ArrayMesh.new()
		var array = []
		array.resize(Mesh.ARRAY_MAX)
		array[Mesh.ARRAY_VERTEX] = polygon
		mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINE_STRIP, array)
		var mesh_instance = MeshInstance2D.new()
		mesh_instance.mesh = mesh
		add_child(mesh_instance)
	else:
		push_error("CollisionPolygon2D not found in SpawnZone.")
	
	var collision_polygon2 = $CollisionPolygon2D2
	if collision_polygon:
		var polygon = collision_polygon2.polygon
		var mesh = ArrayMesh.new()
		var array = []
		array.resize(Mesh.ARRAY_MAX)
		array[Mesh.ARRAY_VERTEX] = polygon
		mesh.add_surface_from_arrays(Mesh.PRIMITIVE_LINE_STRIP, array)
		var mesh_instance = MeshInstance2D.new()
		mesh_instance.mesh = mesh
		add_child(mesh_instance)
	else:
		push_error("CollisionPolygon2D not found in SpawnZone.")

