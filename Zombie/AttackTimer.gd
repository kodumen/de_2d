extends Timer


onready var zombie = get_parent()

var target

func _on_AttackTimer_timeout():
	if (target != null):
		target.hit(zombie.attack)


func stopAttack():
	target = null
	stop()


func _on_Zombie_state_attacking(target_node):
	target = target_node
	start()


func _on_Zombie_state_moving(_velocity):
	stopAttack()


func _on_Zombie_state_idle():
	stopAttack()
