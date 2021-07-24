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
onready var attackTimer = $AttackTimer

var target

signal zombie_idle
signal zombie_hit
signal zombie_motion(velocity)
signal zombie_attack(target)
signal zombie_dead

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

func hit(damage):
	armor -= damage
	
	if (armor < 0):
		health -= abs(armor)
		health = max(health, 0)
		armor = 0
	
	emit_signal("zombie_hit")
	
	if (health == 0):
		state = STATE.DEAD
		emit_signal("zombie_dead")

func _on_AttackZone_body_entered(body: Node2D):
	if (body.is_in_group("Player")):
		print_debug(name + " attacks!")
		state = STATE.ATTACKING
		emit_signal("zombie_attack", body)

func _on_AttackZone_body_exited(body):
	if (body.is_in_group("Player")):
		print_debug(name + " stops attacking!")
		state = STATE.MOVING

func _on_Player_player_dead():
	state = STATE.IDLE
	emit_signal("zombie_idle")


func _on_Zombie_zombie_dead():
	$MovementCollision.set_deferred("disabled", true)
