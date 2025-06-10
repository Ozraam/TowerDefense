extends Node2D

var monster = preload("res://monster.tscn")
@export_node_path("Button") var start
var startBut : Button

var wave = [
	5
]
var current_wave = 0
var current_wave_monster

func _ready() -> void:
	startBut = get_node(start)

func start_wave():
	if current_wave >= wave.size():
		return
	startBut.hide()
	$Timer.start()
	current_wave_monster = wave[current_wave]
	current_wave += 1

func _on_timer_timeout() -> void:
	var m : Monster = monster.instantiate()
	m.position = Vector2(1000,9000)
	m.followedPathNode = "../../Path/PathFollow2D"
	$Monsters.add_child(m)
	current_wave_monster -= 1
	if current_wave_monster == 0:
		$Timer.stop()
		if current_wave < wave.size():
			startBut.show()
