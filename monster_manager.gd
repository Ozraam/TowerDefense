extends Node2D

var monsterScene = preload("res://monster.tscn")
@export_node_path("Control") var setupUiPath
@export_node_path("Control") var coinsPocketPath
var coinsPocket : Control
var setupUi : Control

var coinScene = preload("res://coin.tscn")

var alive_monsters = 0

@export var wave : PackedInt32Array = [
	5,
	10,
	10
]
var current_wave = 0
var current_wave_monster

func _ready() -> void:
	setupUi = get_node(setupUiPath)
	coinsPocket = get_node(coinsPocketPath)

func start_wave():
	if current_wave >= wave.size():
		return
	setupUi.hide()
	$Timer.start()
	current_wave_monster = wave[current_wave]
	alive_monsters = current_wave_monster
	current_wave += 1

func _on_timer_timeout() -> void:
	var m : Monster = monsterScene.instantiate()
	m.position = Vector2(1000,9000)
	m.followedPathNode = "../../Path/PathFollow2D"
	m.monster_died.connect(_on_monster_died)
	m.speed = 0.01 + (current_wave - 1) * 0.005
	m.health = 20 + (current_wave - 1) * 10
	m.damage = 10 + (current_wave - 1) * 2
	current_wave_monster -= 1
	$Monsters.add_child(m)
	if current_wave_monster == 0:
		$Timer.stop()

func _on_monster_died(monster: Monster) -> void:
	alive_monsters -= 1
	monster.monster_died.disconnect(_on_monster_died)

	var coin = coinScene.instantiate()
	coin.position = monster.position
	coin.value = (25 + (current_wave - 1) * 5) * monster.is_not_dead_by_end
	coin.pocket = coinsPocket
	$Golds.add_child(coin)


	if alive_monsters <= 0:
		print("Wave completed!")
		setupUi.show()
		for child in $Golds.get_children():
			child.pocket = coinsPocket
			child.goto_pocket()
