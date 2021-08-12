class_name Shotgun


extends BaseWeapon


func check_fire() -> bool:
	return Input.is_action_just_pressed("player_primary")


func fire():
	.fire()
	for ray_cast in ray_casts:
		create_trail(ray_cast)
		check_hit(ray_cast)
