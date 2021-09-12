extends AudioStreamPlayer


export(Array, AudioStream) var footstep_sfx = []


var animated_sprite:AnimatedSprite setget set_animated_sprite


func set_animated_sprite(node:AnimatedSprite):
	animated_sprite = node
	animated_sprite.connect("frame_changed", self, "_on_AnimatedSprite_frame_changed")
	
	
func _on_AnimatedSprite_frame_changed():
	if ["move", "move_reversed"].has(animated_sprite.animation) \
	and animated_sprite.frame == 1:
		AudioPlayerUtil.play_random(self, footstep_sfx)
