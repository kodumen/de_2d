class_name Player


extends KinematicBody2D


enum STATE {
	IDLE
	MOVING
	DEAD
	EXITING
}


export(int) var health = 100
export(int) var max_health = 100
export(int) var armor = 50

export(int) var speed = 50

export(int) var shells = 0
export(int) var max_shells = 8
export(int) var cells = 0
export(int) var max_cells = 200
export(NodePath) var active_weapon_path
export(NodePath) var weapon_1_path
export(NodePath) var weapon_2_path


onready var animated_sprite = $AnimatedSprite
onready var weapon_switch_animation = $WeaponSwitchAnimation


var state = STATE.IDLE
var active_weapon:BaseWeapon
var weapon_ready = true
var weapon_1:BaseWeapon
var weapon_2:BaseWeapon
var weapon_queue_lift


signal state_motion(velocity)
signal state_idle
signal state_dead
signal state_exiting
signal hit
# warning-ignore:unused_signal
signal item_pickup(item)
signal ammo_count_changed


func _ready():
	if active_weapon_path:
		active_weapon = get_node(active_weapon_path)
		active_weapon.visible = true
		
	if weapon_1_path:
		weapon_1 = get_node(weapon_1_path)
		print_debug("%s set as weapon 1!" % weapon_1.name)
	
	if weapon_2_path:
		weapon_2 = get_node(weapon_2_path)
		
	# warning-ignore:return_value_discarded
	EventBus.connect("player_entered_exit", self, "_on_Player_entered_exit")


func _process(_delta):
	if state == STATE.DEAD:
		return

	animated_sprite.flip_h = get_local_mouse_position().x <= 0
	
	if active_weapon:
		aim(get_global_mouse_position())


func _physics_process(_delta):
	if state == STATE.DEAD or state == STATE.EXITING:
		return
	
	move(read_direction())

	if can_fire() and active_weapon.check_fire():
		fire()


func _input(event:InputEvent):
	if state == STATE.DEAD or state == STATE.EXITING:
		return
		
	if weapon_1 and event.is_action_pressed("player_weapon_1"):
		switch_weapon(weapon_1)
	elif weapon_2 and event.is_action_pressed("player_weapon_2"):
		switch_weapon(weapon_2)


func read_direction() -> Vector2:
	var direction = Vector2()
	
	if (Input.is_action_pressed("player_move_up")):
		direction.y = -1
	elif (Input.is_action_pressed("player_move_down")):
		direction.y = 1
		
	if (Input.is_action_pressed("player_move_left")):
		direction.x = -1
	elif (Input.is_action_pressed("player_move_right")):
		direction.x = 1
		
	direction = direction.normalized()
	
	return direction


func move(direction:Vector2):
	direction *= speed
	
	if (direction.length() > 0):
		state = STATE.MOVING
		emit_signal("state_motion", direction)
	else:
		state = STATE.IDLE
		emit_signal("state_idle")
	
	# warning-ignore:return_value_discarded
	move_and_slide(direction)


# Aim to a specified global position.
func aim(target_position:Vector2):
	active_weapon.look_at(target_position)
	if target_position.x < global_position.x:
		active_weapon.scale.y = -1
	else:
		active_weapon.scale.y = 1


func hit(damage):
	armor -= damage
	
	if (armor < 0):
		health -= abs(armor)
		health = max(health, 0)
		armor = 0
	
	emit_signal("hit")
	
	if (health == 0):
		print_debug("%s is dead!" % name)
		state = STATE.DEAD
		emit_signal("state_dead")


func is_max_health() -> bool:
	return health >= max_health


func can_fire() -> bool:
	return active_weapon \
	and weapon_ready \
	and active_weapon.is_idle \
	and weapon_has_ammo()


func fire():
	# Scan for hits, create projectiles, etc.
	active_weapon.fire()
	
	# Decrease ammo
	match active_weapon.ammo_type:
		BaseWeapon.AMMO_TYPE.SHELLS:
			shells -= active_weapon.ammo_per_shot
		BaseWeapon.AMMO_TYPE.CELLS:
			cells -= active_weapon.ammo_per_shot
		BaseWeapon.AMMO_TYPE.INFINITE:
			pass
	
	emit_signal("ammo_count_changed")
	
	if ! weapon_has_ammo() and active_weapon.prev_weapon:
		switch_weapon(active_weapon.prev_weapon)
	
	
func weapon_has_ammo() -> bool:
	if ! active_weapon:
		return false
	
	var ammo_count = 0
	match active_weapon.ammo_type:
		BaseWeapon.AMMO_TYPE.SHELLS:
			ammo_count = shells
		BaseWeapon.AMMO_TYPE.INFINITE:
			ammo_count = INF
		BaseWeapon.AMMO_TYPE.CELLS, _:
			ammo_count = cells

	return ammo_count >= active_weapon.ammo_per_shot


func switch_weapon(next_weapon:BaseWeapon):
	if active_weapon == next_weapon:
		return
		
	if ! weapon_ready:
		weapon_queue_lift = next_weapon
	else:
		weapon_switch_animation.lower_weapon = active_weapon
		weapon_switch_animation.lift_weapon = next_weapon
		weapon_switch_animation.begin()
		weapon_ready = false
		weapon_queue_lift = null


func _on_WeaponSwitchAnimation_weapon_ready(weapon:BaseWeapon):
	active_weapon = weapon
	weapon_ready = true
	if weapon_queue_lift:
		call_deferred("switch_weapon", weapon_queue_lift)


func _on_Player_state_dead():
	active_weapon.visible = false


func _on_Player_entered_exit():
	state = STATE.EXITING
	emit_signal("state_exiting")
