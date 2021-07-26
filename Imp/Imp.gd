extends Enemy


func _enemy_ready():
	path_line = $Line2D
	animated_sprite = $AnimatedSprite
	hit_box = $HitBox
