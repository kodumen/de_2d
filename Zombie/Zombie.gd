extends "res://common/Enemy/Enemy.gd"


onready var attackTimer = $AttackTimer


func _enemy_ready():
	path_line = $Line2D
	animated_sprite = $AnimatedSprite

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
	$HitBox.disabled(true)


func _on_HitBox_hitbox_hit(damage):
	hit(damage)
