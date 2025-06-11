extends Node2D

var player_want_tower = false
@onready var spawnZone = $SpawnZone
var tower : PackedScene = preload("res://simple_gun.tscn")
var currentTower : Area2D

func _on_select_tower_button_up() -> void:
	player_want_tower = true
	currentTower = tower.instantiate()
	currentTower.position = spawnZone.mouse_pos
	$Towers.add_child(currentTower)

func _process(_delta: float) -> void:
	if currentTower != null:
		currentTower.position = spawnZone.mouse_pos

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and player_want_tower:
		if spawnZone.is_mouse_in and event.button_index == MOUSE_BUTTON_LEFT:
			player_want_tower = false
			currentTower = null
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			player_want_tower = false
			if currentTower != null:
				currentTower.queue_free()
				currentTower = null
				print("Tower placement cancelled.")
			else:
				print("No tower to cancel placement for.")
