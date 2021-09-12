extends AudioStreamPlayer2D


export(Array, AudioStream) var footsteps_sfx = []
export(Array, AudioStream) var melee_sfx = []


var animated_sprite:AnimatedSprite setget set_animated_sprite
var last_stream:AudioStream = null


func set_animated_sprite(node:AnimatedSprite):
	animated_sprite = node
	animated_sprite.connect("frame_changed", self, "_on_AnimatedSprite_frame_changed")


func _on_AnimatedSprite_frame_changed():
	if animated_sprite.animation == "move" \
	and animated_sprite.frame == 2:
		play_random(footsteps_sfx)
		
	elif animated_sprite.animation == "attack_melee" \
	and animated_sprite.frame == 2:
		play_random(melee_sfx)
		
		
func play_random(sfx_set:Array):
	if sfx_set.empty():
		print_debug("No sfx.")
		return
		
	if sfx_set.size() == 1:
		stream = sfx_set[0]
	else:
		var new_stream = last_stream
		while new_stream == last_stream:
			new_stream = sfx_set[randi() % sfx_set.size()]
			
		stream = new_stream
		last_stream = stream
		
	play()
	
