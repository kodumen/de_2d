extends KinematicBody2D


enum STATE {
	IDLE,
	MOVING,
	ATTACKING,
	DEAD
}

export(NodePath) var target_path

export var armor = 0
export var health = 100
export var speed = 0.25
export var attack = 10
export(STATE) var state = STATE.IDLE

onready var animatedSprite = $AnimatedSprite

var target

signal imp_idle
signal imp_hit
signal imp_motion(velocity)
signal imp_attack(target)
signal imp_dead

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
		emit_signal("imp_motion", velocity)
	else:
		emit_signal("imp_idle")
	
	move_and_collide(velocity)


func _on_RangedAttackZone_body_entered(body: Node2D):
	if (body.is_in_group("Player")):
		state = STATE.IDLE
		emit_signal("imp_idle")


func _on_RangedAttackZone_body_exited(body: Node2D):
	if (body.is_in_group("Player")):
		state = STATE.MOVING
