extends Node2D

var player_want_tower = false
@onready var spawnZone = $SpawnZone
var tower : PackedScene = preload("res://simple_gun.tscn")
var currentTower : SimpleGun
var showRange = false

func _on_select_tower_button_up() -> void:
	player_want_tower = true
	currentTower = tower.instantiate()
	currentTower.position = spawnZone.mouse_pos
	$Towers.add_child(currentTower)
	currentTower.toogle_shoot_range()

func _process(_delta: float) -> void:
	if currentTower != null:
		currentTower.position = spawnZone.mouse_pos

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and player_want_tower:
		if spawnZone.is_mouse_in and event.button_index == MOUSE_BUTTON_LEFT:
			player_want_tower = false
			if not showRange:
				currentTower.toogle_shoot_range()
			currentTower = null
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			player_want_tower = false
			if currentTower != null:
				currentTower.queue_free()
				currentTower = null
				print("Tower placement cancelled.")
			else:
				print("No tower to cancel placement for.")

func toogle_all_range():
	showRange = not showRange
	for toweri in $Towers.get_children():
		if toweri is SimpleGun:
			toweri.toogle_shoot_range()
	
func show_all_range():
	showRange = true
	for toweri in $Towers.get_children():
		if toweri is SimpleGun:
			toweri.show_range()

func hide_all_range():
	showRange = false
	for toweri in $Towers.get_children():
		if toweri is SimpleGun:
			toweri.hide_range()