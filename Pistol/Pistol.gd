class_name Pistol


extends BaseWeapon


onready var timer:Timer = $Timer


func check_fire() -> bool:
	return Input.is_action_just_pressed("player_primary")


func fire():
	.fire()
	for ray_cast in ray_casts:
		create_trail(ray_cast)
		check_hit(ray_cast)
		
	if ammo == 0:
		# Timer wait time can be configured in the Timer node.
		timer.start()


func _on_Timer_timeout():
	set_ammo(max_ammo)
