extends Timer


onready var zombie = get_parent()

var target

func _on_AttackTimer_timeout():
	if (target != null):
		target.hit(zombie.attack_melee)


func stopAttack():
	target = null
	stop()


func _on_Zombie_state_moving(_velocity):
	stopAttack()


func _on_Zombie_state_idle():
	stopAttack()


func _on_Zombie_state_attack_melee(target_node, _attack):
	target = target_node
	start()
