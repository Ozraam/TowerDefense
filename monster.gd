extends Area2D
class_name Monster
@export var speed = 0.01
@export_node_path("PathFollow2D") var followedPathNode
var pathfollow : PathFollow2D
var progress = 0

func _ready() -> void:
	pathfollow = get_node(followedPathNode)

func _process(delta: float) -> void:
	progress += speed * delta
	pathfollow.progress_ratio = progress
	position = pathfollow.global_position
	if progress > 1:
		queue_free()
