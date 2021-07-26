extends AnimatedSprite


func _on_Enemy_state_moving(velocity):
	flip_h = velocity.x < 0
	play("move")
