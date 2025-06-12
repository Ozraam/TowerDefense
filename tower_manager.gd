extends Node2D

class_name TowerManager

var player_want_tower = false
@onready var spawnZone = $SpawnZone
var currentTower : SimpleGun
var showRange = false
var currentTowerCost = 0

func place_tower(tower_scene : PackedScene, tower_cost : int) -> void:
	if player_want_tower:
		print("Already placing a tower, please cancel first.")
		return
	player_want_tower = true
	currentTowerCost = tower_cost
	currentTower = tower_scene.instantiate()
	currentTower.position = spawnZone.mouse_pos
	$Towers.add_child(currentTower)
	currentTower.toogle_shoot_range()

func _process(_delta: float) -> void:
	if currentTower != null:
		currentTower.position = spawnZone.mouse_pos

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and player_want_tower:
		if spawnZone.is_mouse_in and event.button_index == MOUSE_BUTTON_LEFT:
			Inventory.remove_gold(currentTowerCost)
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