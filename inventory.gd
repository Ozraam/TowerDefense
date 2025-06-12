extends Node


var gold: int = 100

signal gold_changed(new_gold: int)

func add_gold(amount: int) -> void:
    gold += amount
    gold_changed.emit(gold)
    
func remove_gold(amount: int) -> void:
    if gold >= amount:
        gold -= amount
        gold_changed.emit(gold)
    else:
        push_error("Not enough gold to remove: " + str(amount) + ", current gold: " + str(gold))