extends Control

@onready var goldlabel = $GoldLabel
@export_node_path("TowerManager") var towerManagerPath
var towerManager: TowerManager = null

var available_towers = [
	{scene = preload("res://simple_gun.tscn"), name = "Simple Gun", cost = 100, btn = null},
]

func _ready() -> void:
	# Initialize the shop UI, e.g., load items, set up buttons, etc.
	Inventory.gold_changed.connect(update_gold_label)
	update_gold_label(Inventory.gold)
	setup_towers_buttons()
	towerManager = get_node(towerManagerPath)

func update_gold_label(new_gold) -> void:
	# Update the gold label with the current amount of gold
	goldlabel.text = str(new_gold) + " Gold"
	for tower in available_towers:
		if tower.btn:
			tower.btn.disabled = Inventory.gold < tower.cost


func setup_towers_buttons() -> void:
	# This function can be used to set up buttons for each tower in the shop
	for tower in available_towers:
		var button = Button.new()
		button.text = tower.name + " - " + str(tower.cost) + " Gold"
		$TowerButtons.add_child(button)
		tower.btn = button
		button.connect("pressed", func() : buy_tower(tower))

func buy_tower(tower) -> void:
	if Inventory.can_buy(tower.cost):
		print("Buying tower: " + tower.name)
		towerManager.place_tower(tower.scene, tower.cost)
	else:
		push_error("Not enough gold to buy " + tower.name)
