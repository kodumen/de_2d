extends KinematicBody2D

enum STATE {
	IDLE,
	MOVING,
	ATTACKING,
	DEAD
}

export(NodePath) var target_path

export var speed = 0.25
export var attack = 10
export(STATE) var state = STATE.IDLE

onready var animatedSprite = $AnimatedSprite
onready var attackTimer = $AttackTimer

var target

signal zombie_idle
signal zombie_motion(velocity)
signal zombie_attack(target)

func _ready():
	if (target_path):
		target = get_node(target_path)
		state = STATE.MOVING
		

func _physics_process(_delta):
	if (target == null || state != STATE.MOVING):
		return
	
	var velocity = Vector2()
	velocity = position.direction_to(target.global_position)
	velocity *= speed
	
	# sprite direction
	animatedSprite.flip_h = target.global_position.x < global_position.x
	
	if (velocity.length() > 0):
		emit_signal("zombie_motion", velocity)
	else:
		emit_signal("zombie_idle")
	
	move_and_collide(velocity)

func _on_AttackZone_body_entered(body: Node2D):
	if (body.get_groups().has("Player")):
		print_debug(name + " attacks!")
		state = STATE.ATTACKING
		emit_signal("zombie_attack", body)

func _on_AttackZone_body_exited(body):
	if (body.get_groups().has("Player")):
		print_debug(name + " stops attacking!")
		state = STATE.MOVING

func _on_Player_player_dead():
	state = STATE.IDLE
	emit_signal("zombie_idle")
