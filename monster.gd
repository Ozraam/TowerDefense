extends Area2D
class_name Monster
@export var speed = 0.01
@export_node_path("PathFollow2D") var followedPathNode
var pathfollow : PathFollow2D
var progress = 0

@export var health: int = 100
@export var damage: int = 10

func _ready() -> void:
	pathfollow = get_node(followedPathNode)

func _process(delta: float) -> void:
	progress += speed * delta
	pathfollow.progress_ratio = progress
	position = pathfollow.global_position
	if progress > 1:
		queue_free()

func get_progress() -> float:
	return progress

func shoot(damage_amount: int) -> void:
	health -= damage_amount
	$AnimationPlayer.play("ouch")
	if health <= 0:
		$AnimationPlayer.play("die")

func is_alive() -> bool:
	return health > 0
