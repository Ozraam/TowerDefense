extends Area2D

@onready var polycoli = $CollisionPolygon2D

func _ready() -> void:
	var arrayMesh = ArrayMesh.new()
	var arrays = []
	var vertices = PackedVector2Array()
	vertices.push_back(Vector2(0, 1))
	vertices.push_back(Vector2(1, 0))
	vertices.push_back(Vector2(0, 0))
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	print(arrays)
	
	
	
	arrayMesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	
