extends Enemy


onready var attackTimer = $AttackTimer


func _enemy_ready():
	path_line = $Line2D
	animated_sprite = $AnimatedSprite
	hit_box = $HitBox
	
	connect_node($VoiceSfxPlayer)
	
	$FootstepSfxPlayer.animated_sprite = animated_sprite
	

func _on_AttackZone_body_entered(body: Node2D):
	if body == target:
		print_debug(name + " attacks!")
		set_state(STATE.ATTACK_MELEE)

func _on_AttackZone_body_exited(body):
	if body == target:
		print_debug(name + " stops attacking!")
		state = STATE.MOVING
