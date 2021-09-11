extends AudioStreamPlayer2D


export(Array, AudioStream) var footsteps_sfx = []


var animated_sprite:AnimatedSprite setget set_animated_sprite
var last_stream:AudioStream = null


func set_animated_sprite(node:AnimatedSprite):
	animated_sprite = node
	animated_sprite.connect("frame_changed", self, "_on_AnimatedSprite_frame_changed")


func _on_AnimatedSprite_frame_changed():
	if animated_sprite.animation == "move" \
	and animated_sprite.frame == 2:
		play_footstep()
		
		
func play_footstep():
	if footsteps_sfx.size() == 0:
		print_debug("No footsteps sfx for %s" % get_parent().name)
		return
		
	if footsteps_sfx.size() == 1:
		stream = footsteps_sfx[0]
	else:
		var new_stream = last_stream
		while new_stream == last_stream:
			new_stream = footsteps_sfx[randi() % footsteps_sfx.size()]
		
		stream = new_stream
		last_stream = stream
		
	play()
		
