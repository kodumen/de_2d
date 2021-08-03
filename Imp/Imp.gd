extends Enemy


var ranged_attack_zone_collider: CollisionShape2D
var is_target_in_range = false
var sightline:Sightline

func _enemy_ready():
	path_line = $Line2D
	animated_sprite = $AnimatedSprite
	hit_box = $HitBox
	ranged_attack_zone_collider = $RangedAttackZone/CollisionShape2D
	sightline = $Sightline


func _process(_delta):
	if state == STATE.DEAD:
		return
		
	if target and sightline:
		sightline.look_at(target.global_position)
		
		
func _physics_process(_delta):
	if state == STATE.DEAD:
		return
		
	if state != STATE.ATTACKING and is_target_in_range and is_sightline_clear():
		set_state(STATE.ATTACKING)


func _on_RangedAttackZone_body_entered(body):
	if target == body:
		is_target_in_range = true
		
	if body == target and state != STATE.DEAD and is_sightline_clear():
		set_state(STATE.ATTACKING)


func _on_RangedAttackZone_body_exited(body):
	if target == body:
		is_target_in_range = false
		
	if body == target and state != STATE.DEAD:
		set_state(STATE.MOVING)


func _on_Enemy_state_dead():
	._on_Enemy_state_dead()
	ranged_attack_zone_collider.set_deferred("disabled", true)
	
	
func is_sightline_clear():
	return sightline and sightline.is_clear()
