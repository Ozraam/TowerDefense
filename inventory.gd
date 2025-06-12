extends Node


var gold: int = 100
var health: int = 100

signal gold_changed(new_gold: int)
signal health_changed(new_health: int)
signal game_over()

func add_gold(amount: int) -> void:
    gold += amount
    gold_changed.emit(gold)
    
func remove_gold(amount: int) -> void:
    if gold >= amount:
        gold -= amount
        gold_changed.emit(gold)
    else:
        push_error("Not enough gold to remove: " + str(amount) + ", current gold: " + str(gold))
    
func can_buy(amount: int) -> bool:
    return gold >= amount

func remove_health(amount: int) -> void:
    health -= amount
    health_changed.emit(health)
    if health <= 0:
        health = 0
        game_over.emit()
        print("Game Over! You have no health left.")
    else:
        print("Health reduced by " + str(amount) + ", current health: " + str(health))