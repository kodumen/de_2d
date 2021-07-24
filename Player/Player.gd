extends KinematicBody2D


export var health = 100
export var armor = 50

export var speed = 50

onready var animatedSprite = $AnimatedSprite

signal player_motion(velocity)
signal player_idle

func _process(_delta):
	animatedSprite.flip_h = get_local_mouse_position().x <= 0

func _physics_process(_delta):
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
		emit_signal("player_motion", velocity)
	else:
		emit_signal("player_idle")
	
	move_and_collide(velocity)
		
