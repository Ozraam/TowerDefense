extends Area2D
class_name SimpleGun

@export var shoot_timeout: float = 1.0
@export var shoot_damage: int = 10
@export var price : int = 100
@export var drop = 50

var bullet = preload("res://bullet.tscn")




func _ready() -> void:
    toogle_shoot_range()
    # draw a circle around the gun
    var surface_tool = SurfaceTool.new()
    surface_tool.begin(Mesh.PRIMITIVE_LINES)
    var radius = 150.0  # Radius of the circle
    var segments = 128  # Number of segments in the circle
    for i in range(segments + 1):
        var angle = i * (2.0 * PI / segments)
        var x = radius * cos(angle)
        var y = radius * sin(angle)
        surface_tool.add_vertex(Vector3(x, y, 0))  # Circle vertices
    surface_tool.add_vertex(Vector3(radius, 0, 0))  # Close the circle
    var mesh = surface_tool.commit()
    $Shootrange.mesh = mesh

func toogle_shoot_range() -> void:
    $Shootrange.visible = not $Shootrange.visible

func show_range() -> void:
    $Shootrange.visible = true

func hide_range() -> void:
    $Shootrange.visible = false


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
    
