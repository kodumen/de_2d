extends AnimatedSprite


var target = null


func _on_Enemy_state_moving(velocity):
	flip_h = velocity.x < 0
	play("move")


func _on_Enemy_state_attacking(_target):
	target = _target
	play("attack")


func _on_Enemy_state_idle():
	play("default")
	

func _on_Enemy_state_dead():
	play("dead")


func _process(_delta):
	if animation == "attack" and target:
		flip_h =  target.global_position.x < global_position.x
	else:
		target = null
