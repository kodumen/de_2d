extends AnimatedSprite


class_name HitEffect


export(bool) var randomize_rotation = false


func _ready():
	playing = true
	
	if randomize_rotation:
		rotation_degrees = rand_range(0, 360)
		
	# warning-ignore:return_value_discarded
	connect("animation_finished", self, "_on_animation_finished")


func _on_animation_finished():
	queue_free()
