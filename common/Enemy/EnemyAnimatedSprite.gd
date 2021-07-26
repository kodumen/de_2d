extends AnimatedSprite


func _on_Enemy_state_moving(velocity):
	flip_h = velocity.x < 0
	play("move")


func _on_Enemy_state_attacking(_target):
	flip_h = _target.global_position.x < global_position.x
	play("attack")


func _on_Enemy_state_idle():
	play("default")
	

func _on_Enemy_state_dead():
	play("dead")
