extends Node2D

class_name Coin
var value: int = 10
var pocket: Control

var move = false

var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	$AnimationPlayer.play("idle")

func goto_pocket() -> void:
	move = true
	$AnimationPlayer.play("move")
	
func _process(delta: float) -> void:
	if move:
		var direction = (pocket.global_position - global_position).normalized()
		velocity += direction * 100 # Adjust speed as needed
		velocity = velocity.lerp(Vector2.ZERO, 0.1) # Dampen the velocity
		global_position += velocity * delta # Move towards the pocket
		if global_position.distance_to(pocket.global_position) < 10: # Close enough to sto
			move = false
			$AnimationPlayer.play("idle")
			Inventory.add_gold(value) # Add coin value to inventory
			queue_free() # remove from scene tree after reaching pocket
