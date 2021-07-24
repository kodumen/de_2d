extends AnimatedSprite
	
	
func _on_Player_player_motion(velocity):
	if (velocity.x > 0 and not flip_h) or (velocity.x < 0 and flip_h):
		play("move")
	elif (velocity.x < 0 and not flip_h) or (velocity.x > 0 and flip_h):
		play("move_reversed")
	elif (velocity.y != 0):
		play("move")


func _on_Player_player_idle():
	play("default")
