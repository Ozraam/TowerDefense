extends Node2D

var monster = preload("res://monster.tscn")
@export_node_path("Control") var setupUiPath
var setupUi : Control

var alive_monsters = 0

var wave = [
	5,
	10,
]
var current_wave = 0
var current_wave_monster

func _ready() -> void:
	setupUi = get_node(setupUiPath)

func start_wave():
	if current_wave >= wave.size():
		return
	setupUi.hide()
	$Timer.start()
	current_wave_monster = wave[current_wave]
	alive_monsters = current_wave_monster
	current_wave += 1

func _on_timer_timeout() -> void:
	var m : Monster = monster.instantiate()
	m.position = Vector2(1000,9000)
	m.followedPathNode = "../../Path/PathFollow2D"
	$Monsters.add_child(m)
	m.monster_died.connect(_on_monster_died)
	m.speed = 0.01 + (current_wave - 1) * 0.005
	m.health = 20 + (current_wave - 1) * 10
	m.damage = 10 + (current_wave - 1) * 2
	current_wave_monster -= 1
	if current_wave_monster == 0:
		$Timer.stop()

func _on_monster_died(_monster: Monster) -> void:
	alive_monsters -= 1
	if alive_monsters <= 0:
		print("Wave completed!")
		setupUi.show()