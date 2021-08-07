extends KinematicBody2D


class_name Player


enum STATE {
	IDLE
	MOVING
	DEAD
}

export var health = 100
export var armor = 50

export var speed = 50

onready var animated_sprite = $AnimatedSprite
onready var weapon = $Weapon

var state = STATE.IDLE
var ammo setget , get_ammo

signal state_motion(velocity)
signal state_idle
signal state_dead
signal hit
signal fire

func _process(_delta):
	if state == STATE.DEAD:
		return

	animated_sprite.flip_h = get_local_mouse_position().x <= 0


func _physics_process(_delta):
	if (state == STATE.DEAD):
		return
	
	var velocity = Vector2()
	
	# Movement
	if (Input.is_action_pressed("player_move_up")):
		velocity.y = -1
	elif (Input.is_action_pressed("player_move_down")):
		velocity.y = 1
		
	if (Input.is_action_pressed("player_move_left")):
		velocity.x = -1
	elif (Input.is_action_pressed("player_move_right")):
		velocity.x = 1
		
	velocity = velocity.normalized()
	velocity *= speed
	
	if (velocity.length() > 0):
		state = STATE.MOVING
		emit_signal("state_motion", velocity)
	else:
		state = STATE.IDLE
		emit_signal("state_idle")
	
	# warning-ignore:return_value_discarded
	move_and_slide(velocity)


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
		
		
func get_ammo() -> int:
	return weapon.ammo


func _on_Weapon_fire():
	emit_signal("fire")
