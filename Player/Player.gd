class_name Player


extends KinematicBody2D


enum STATE {
	IDLE
	MOVING
	DEAD
}


export(int) var health = 100
export(int) var max_health = 100
export(int) var armor = 50

export(int) var speed = 50

export(int) var shells = 0
export(int) var max_shells = 8
export(int) var clips = 0
export(int) var max_clips = 5
export(int) var cells = 0
export(int) var max_cells = 200
export(NodePath) var active_weapon_path


onready var animated_sprite = $AnimatedSprite


var state = STATE.IDLE
var active_weapon:BaseWeapon


signal state_motion(velocity)
signal state_idle
signal state_dead
signal hit
# warning-ignore:unused_signal
signal item_pickup(item)
signal ammo_count_changed


func _ready():
	if active_weapon_path:
		active_weapon = get_node(active_weapon_path)
		active_weapon.visible = true


func _process(_delta):
	if state == STATE.DEAD:
		return

	animated_sprite.flip_h = get_local_mouse_position().x <= 0
	
	if active_weapon:
		aim(get_global_mouse_position())


func _physics_process(_delta):
	if (state == STATE.DEAD):
		return
	
	move(read_direction())

	if can_fire() and active_weapon.check_fire():
		fire()


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
	active_weapon.flip_v = target_position.x < global_position.x


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
	return active_weapon and active_weapon.is_idle and weapon_has_ammo()


func fire():
	active_weapon.fire()
	match active_weapon.ammo_type:
		BaseWeapon.AMMO_TYPE.SHELLS:
			shells -= active_weapon.ammo_per_shot
		BaseWeapon.AMMO_TYPE.CLIPS:
			clips -= active_weapon.ammo_per_shot
	
	emit_signal("ammo_count_changed")
	
	
func weapon_has_ammo() -> bool:
	if ! active_weapon:
		return false
	
	var ammo_count = 0
	match active_weapon.ammo_type:
		BaseWeapon.AMMO_TYPE.SHELLS:
			ammo_count = shells
		BaseWeapon.AMMO_TYPE.CLIPS:
			ammo_count = clips
		BaseWeapon.AMMO_TYPE.CELLS, _:
			ammo_count = 0

	return ammo_count >= active_weapon.ammo_per_shot
