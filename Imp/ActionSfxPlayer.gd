extends AudioStreamPlayer2D


export(Array, AudioStream) var foot_sfx = []


var animated_sprite:AnimatedSprite setget set_animated_sprite


func set_animated_sprite(sprite:AnimatedSprite):
	animated_sprite = sprite
	animated_sprite.connect("frame_changed", self, "_on_animated_sprite_frame_changed")
	
	
func _on_animated_sprite_frame_changed():
	if animated_sprite.animation == "move" \
	and [1, 3].has(animated_sprite.frame):
		AudioPlayerUtil.play_random(self, foot_sfx)
