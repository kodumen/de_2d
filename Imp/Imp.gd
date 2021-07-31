extends Enemy


var ranged_attack_zone_collider: CollisionShape2D


func _enemy_ready():
	path_line = $Line2D
	animated_sprite = $AnimatedSprite
	hit_box = $HitBox
	ranged_attack_zone_collider = $RangedAttackZone/CollisionShape2D


func _on_RangedAttackZone_body_entered(body):
	if body == target and state != STATE.DEAD:
		set_state(STATE.ATTACKING)


func _on_RangedAttackZone_body_exited(body):
	if body == target and state != STATE.DEAD:
		set_state(STATE.MOVING)


func _on_Enemy_state_dead():
	._on_Enemy_state_dead()
	ranged_attack_zone_collider.set_deferred("disabled", true)
