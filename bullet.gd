extends Area2D

var target : Monster = null
var damage : int = 10
var speed : float = 200.0

func _ready() -> void:
    if target:
        target.monster_is_dying.connect(_target_dead)
    else:
        queue_free()  # Remove the bullet if no target is set

func _target_dead(monster: Monster) -> void:
    if target == monster:
        queue_free()  # Remove the bullet if the target is dead
        target = null

func _process(delta: float) -> void:
    if target != null and target.is_inside_tree():
        var direction = (target.position - position).normalized()
        position += direction * speed * delta
        
        if position.distance_to(target.position) < 10.0:  # Close enough to hit
            target.shoot(damage)
            queue_free()  # Remove the bullet after hitting the target
    else:
        queue_free()  # Remove the bullet if no target is set