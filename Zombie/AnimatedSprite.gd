extends AnimatedSprite



func _on_Zombie_zombie_motion(_velocity):
	play("move")


func _on_Zombie_zombie_idle():
	play("default")


func _on_Zombie_zombie_attack(_target):
	play("attack")


func _on_Zombie_zombie_dead():
	play("dead")
