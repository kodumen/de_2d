class_name Pistol


extends BaseWeapon


export(int) var max_shots = 5


onready var timer:Timer = $Timer
onready var shots = max_shots


func check_fire() -> bool:
	return shots > 0 and Input.is_action_just_pressed("player_primary")


func fire():
	.fire()
	
	shots -= 1
	
	if shots == 0:
		timer.start()
	
	for ray_cast in ray_casts:
		create_trail(ray_cast)
		check_hit(ray_cast)


func _on_Timer_timeout():
	shots = max_shots
