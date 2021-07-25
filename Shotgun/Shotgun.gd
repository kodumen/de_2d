extends AnimatedSprite

onready var timer = $Timer
onready var rayCast = $RayCast2D

export(int) var damage = 50
export(float) var fire_cooldown = 1

var can_fire = true

func fire():
	if (! can_fire):
		return
	
	var collider = rayCast.get_collider()
	if (collider):
		print_debug(name + " hit " + collider.name)
		if (collider.has_method("hit")):
			collider.hit(damage, rayCast.get_collision_point())
	else:
		print_debug(name + " did not hit anything")
		
	can_fire = false
	timer.start(fire_cooldown)

func _on_Timer_timeout():
	can_fire = true
