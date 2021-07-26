extends KinematicBody2D

enum STATE {
	IDLE
	MOVING
	DEAD
}

export var health = 100
export var armor = 50

export var speed = 50

onready var animatedSprite = $AnimatedSprite

var state = STATE.IDLE

signal player_motion(velocity)
signal player_idle
signal player_hit
signal player_dead

func _process(_delta):
	if (state == STATE.DEAD):
		return

	animatedSprite.flip_h = get_local_mouse_position().x <= 0

func _physics_process(delta):
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
	velocity *= speed * delta
	
	if (velocity.length() > 0):
		state = STATE.MOVING
		emit_signal("player_motion", velocity)
	else:
		state = STATE.IDLE
		emit_signal("player_idle")
	
	move_and_collide(velocity)
		
func hit(damage):
	armor -= damage
	
	if (armor < 0):
		health -= abs(armor)
		health = max(health, 0)
		armor = 0
	
	emit_signal("player_hit")
	
	if (health == 0):
		state = STATE.DEAD
		emit_signal("player_dead")
