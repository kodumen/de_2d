extends AnimatedSprite


func _on_Imp_imp_motion(_velocity):
	play("move")


func _on_Imp_imp_idle():
	play("default")
