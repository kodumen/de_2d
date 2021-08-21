class_name Soldier


extends Enemy


onready var sightline:Sightline = $Sightline
onready var soldier_gun:AnimatedSprite = $SoldierGun


var is_point_blank = false
var is_target_in_range = false
var aim_speed = 2


func _enemy_ready():
	animated_sprite = $AnimatedSprite
	hit_box = $HitBox


func _ready():
	soldier_gun.attack = attack_ranged


func _physics_process(delta):
	if state == STATE.DEAD or state == STATE.IDLE:
		return
	
	if target and state == STATE.MOVING or state == STATE.ATTACK_RANGED:
		sightline.look_at(target.global_position)
		aim(target.global_position)
		
	if state != STATE.ATTACK_RANGED and can_shoot_target():
		set_state(STATE.ATTACK_RANGED)
		return
		
	if state == STATE.ATTACK_RANGED and ! can_shoot_target():
		set_state(STATE.MOVING)


func aim(target_position:Vector2):
	soldier_gun.rotation = lerp_angle(
		soldier_gun.rotation, 
		get_angle_to(target_position), 
		get_physics_process_delta_time() * aim_speed
	)
	if target_position.x < global_position.x:
		soldier_gun.scale.y = -1
	else:
		soldier_gun.scale.y = 1


func can_shoot_target() -> bool:
	return target \
	and (is_target_in_range and sightline.is_clear()) \
	or is_point_blank


func _on_ChaseZone_body_entered(body):
	if state != STATE.DEAD and body == target:
		set_state(STATE.MOVING)
	

func _on_ChaseZone_body_exited(body):
	if state != STATE.DEAD and body == target:
		set_state(STATE.IDLE)


func _on_RangedAttackZone_body_entered(body):
	if state != STATE.DEAD and body == target:
		is_target_in_range = true


func _on_RangedAttackZone_body_exited(body):
	if state != STATE.DEAD and body == target:
		is_target_in_range = false
		
		
func _on_Enemy_state_dead():
	._on_Enemy_state_dead()
	$RangedAttackZone/CollisionShape2D.set_deferred("disabled", true)
	$ChaseZone/CollisionShape2D.set_deferred("disabled", true)


func _on_PointBlankZone_body_entered(body):
	if state != STATE.DEAD and body == target:
		is_point_blank = true


func _on_PointBlankZone_body_exited(body):
	if state != STATE.DEAD and body == target:
		is_point_blank = false
