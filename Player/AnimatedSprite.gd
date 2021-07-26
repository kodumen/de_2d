extends AnimatedSprite


func _on_Player_state_dead():
	play("dead")


func _on_Player_state_idle():
	play("default")


func _on_Player_state_motion(velocity):
	if (velocity.x > 0 and not flip_h) or (velocity.x < 0 and flip_h):
		play("move")
	elif (velocity.x < 0 and not flip_h) or (velocity.x > 0 and flip_h):
		play("move_reversed")
	elif (velocity.y != 0):
		play("move")
