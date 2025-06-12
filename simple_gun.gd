extends Area2D

@export var shoot_timeout: float = 1.0
@export var shoot_damage: int = 10

var bullet = preload("res://bullet.tscn")

func get_target_monster() -> Monster:
    var monsters = []

    # Alternatively, if monsters are areas instead of bodies
    var areas = get_overlapping_areas()
    for area in areas:
        if area.is_in_group("monster") and area.has_method("is_alive") and area.is_alive():
            monsters.append(area)

    # Now 'monsters' contains all monster nodes in the area
    if monsters.size() > 0:
        # Get farest monster, with the highest progress
        var farest_monster = null
        var max_progress = -1.0
        for monster in monsters:
            if monster.has_method("get_progress"):
                var progress = monster.get_progress()
                if progress > max_progress:
                    max_progress = progress
                    farest_monster = monster

        return farest_monster

    return null


func _on_shoot_timeout_timeout() -> void:
    var target_monster = get_target_monster()
    if target_monster != null:
        # Call the shoot method on the farest monster
        if target_monster.has_method("shoot"):
            var bullet_instance = bullet.instantiate()
            bullet_instance.target = target_monster
            bullet_instance.damage = shoot_damage
            bullet_instance.position = position # Set bullet's initial position
            get_parent().add_child(bullet_instance) # Add bullet to the scene
        else:
            print("Monster does not have a shoot method.")

func _process(_delta: float) -> void:
    var target_monster = get_target_monster()
    if target_monster != null:
        look_at(target_monster.position)  # Rotate towards the target monster
    
