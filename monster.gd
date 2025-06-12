extends Area2D
class_name Monster
@export var speed = 0.01
@export_node_path("PathFollow2D") var followedPathNode

@export var health: int = 100
@export var damage: int = 10

@onready var lifeBar = $LifeBar

var pathfollow : PathFollow2D
var progress = 0

var is_not_dead_by_end = 1

var died_once = false


signal monster_died(monster: Monster)
signal monster_is_dying(monster: Monster)


func _ready() -> void:
	pathfollow = get_node(followedPathNode)
	lifeBar.max_value = health
	lifeBar.value = health

func _process(delta: float) -> void:
	progress += speed * delta
	pathfollow.progress_ratio = progress
	position = pathfollow.global_position
	if progress > 1 and is_not_dead_by_end:
		is_not_dead_by_end = 0
		monster_is_dying.emit(self)
		$AnimationPlayer.play("die")
		Inventory.remove_health(damage)

func get_progress() -> float:
	return progress

func shoot(damage_amount: int) -> void:
	health -= damage_amount
	$AnimationPlayer.play("ouch")
	lifeBar.value = health
	if health <= 0 and not died_once:
		died_once = true
		monster_is_dying.emit(self)
		$AnimationPlayer.play("die")

func _on_die() -> void:
	monster_died.emit(self)
	queue_free()

func is_alive() -> bool:
	return health > 0 and progress < 1
