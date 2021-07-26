extends "res://common/Enemy/Enemy.gd"


func _enemy_ready():
	path_line = $Line2D
	animated_sprite = $AnimatedSprite
