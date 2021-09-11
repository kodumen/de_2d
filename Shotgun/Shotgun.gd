class_name Shotgun


extends BaseWeapon


onready var pump_stream:AudioStreamPlayer = $PumpStreamPlayer


func check_fire() -> bool:
	return Input.is_action_just_pressed("player_primary")


func fire():
	.fire()
	for ray_cast in ray_casts:
		create_trail(ray_cast)
		check_hit(ray_cast)


func _on_Shotgun_frame_changed():
	if animation == "fire" and frame == 5:
		pump_stream.play()
