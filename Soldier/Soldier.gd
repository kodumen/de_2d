class_name Soldier


extends Enemy


func _enemy_ready():
	animated_sprite = $AnimatedSprite
	hit_box = $HitBox


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
