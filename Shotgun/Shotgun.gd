extends BaseWeapon


class_name Shotgun


export(PackedScene) var trail

var ray_casts:Array


func _ready():
	for child in get_children():
		if (child is RayCast2D):
			ray_casts.append(child)


func check_input() -> bool:
	return Input.is_action_just_pressed("player_primary")


func fire():
	.fire()
	for rayCast in ray_casts:
		create_trail(rayCast)
		check_hit(rayCast)


func create_trail(rayCast: RayCast2D):
	var trail_node:Node2D = trail.instance()
	world.add_child(trail_node)
	trail_node.global_transform = rayCast.global_transform


func check_hit(ray_cast: RayCast2D):
	var collider = ray_cast.get_collider()
	if (collider):
		print_debug(ray_cast.name + " hit " + collider.name)
		if (collider.has_method("hit")):
			var ray_damage = ceil(damage / floor(len(ray_casts)))
			collider.hit(ray_damage, ray_cast.get_collision_point())
			print_debug(ray_cast.name + " dealt " + str(ray_damage) + " DMG!")
	else:
		print_debug(ray_cast.name + " did not hit anything")
