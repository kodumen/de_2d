extends Camera2D


onready var animation_player:AnimationPlayer = $AnimationPlayer


func _on_Player_hit():
	print_debug("The camera is shaking!")
	animation_player.play("shake")
