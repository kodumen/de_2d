extends Enemy


onready var attackTimer = $AttackTimer


func _enemy_ready():
	path_line = $Line2D
	animated_sprite = $AnimatedSprite
	hit_box = $HitBox
	

func _on_AttackZone_body_entered(body: Node2D):
	if (body == target):
		print_debug(name + " attacks!")
		set_state(STATE.ATTACKING)
		emit_signal("state_attacking", body)

func _on_AttackZone_body_exited(body):
	if (body == target):
		print_debug(name + " stops attacking!")
		state = STATE.MOVING

func _on_Zombie_zombie_dead():
	$MovementCollision.set_deferred("disabled", true)
	$HitBox.disabled(true)

