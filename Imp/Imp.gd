extends Enemy


var ranged_attack_zone_collider: CollisionShape2D
var melee_attack_zone_collider: CollisionShape2D
var is_target_in_range = false
var sightline:Sightline

func _enemy_ready():
	path_line = $Line2D
	animated_sprite = $AnimatedSprite
	hit_box = $HitBox
	ranged_attack_zone_collider = $RangedAttackZone/CollisionShape2D
	melee_attack_zone_collider = $MeleeAttackZone/CollisionShape2D
	sightline = $Sightline
	
	connect_node($GrowlSfxPlayer)
	$ActionSfxPlayer.animated_sprite = animated_sprite


func _process(_delta):
	if state == STATE.DEAD:
		return
		
	if target and sightline:
		sightline.look_at(target.global_position)
		
		
func _physics_process(_delta):
	if state == STATE.DEAD or state == STATE.IDLE:
		return

	if state != STATE.ATTACK_MELEE \
	and is_target_in_range \
	and is_sightline_clear():
		set_state(STATE.ATTACK_RANGED)


func _on_RangedAttackZone_body_entered(body):
	if target == body:
		is_target_in_range = true
		if is_sightline_clear():
			set_state(STATE.ATTACK_RANGED)


func _on_RangedAttackZone_body_exited(body):
	if target == body:
		is_target_in_range = false
		if state != STATE.DEAD:
			set_state(STATE.MOVING)


func _on_Enemy_state_dead():
	._on_Enemy_state_dead()
	ranged_attack_zone_collider.set_deferred("disabled", true)
	melee_attack_zone_collider.set_deferred("disabled", true)
	
	
func is_sightline_clear():
	return sightline and sightline.is_clear()


func _on_MeleeAttackZone_body_entered(body):
	if target == body and state != STATE.DEAD:
		set_state(STATE.ATTACK_MELEE)


func _on_MeleeAttackZone_body_exited(body):
	if target == body and state != STATE.DEAD:
		if is_target_in_range and is_sightline_clear():
			set_state(STATE.ATTACK_RANGED)
		else:
			set_state(STATE.MOVING)


func _on_AnimatedSprite_frame_changed():
	if animated_sprite.animation == "attack_melee" \
	and animated_sprite.frame == 2 \
	and target:
		target.hit(attack_melee)
		
