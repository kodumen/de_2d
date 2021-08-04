extends AnimatedSprite


var target = null


func _on_Enemy_state_moving(velocity):
	flip_h = velocity.x < 0
	play("move")


func _on_Enemy_state_attack_melee(target_node, _attack):
	target = target_node
	play("attack_melee")
	
	
func _on_Enemy_state_attack_ranged(target_node, _attack):
	target = target_node
	play("attack_ranged")


func _on_Enemy_state_idle():
	play("default")
	

func _on_Enemy_state_dead():
	play("dead")


func _process(_delta):
	if target and (animation == "attack_melee" or animation == "attack_ranged"):
		flip_h =  target.global_position.x < global_position.x
	else:
		target = null
