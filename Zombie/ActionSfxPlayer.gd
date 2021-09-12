extends AudioStreamPlayer2D


export(Array, AudioStream) var footsteps_sfx = []
export(Array, AudioStream) var melee_sfx = []


var animated_sprite:AnimatedSprite setget set_animated_sprite


func set_animated_sprite(node:AnimatedSprite):
	animated_sprite = node
	animated_sprite.connect("frame_changed", self, "_on_AnimatedSprite_frame_changed")


func _on_AnimatedSprite_frame_changed():
	if animated_sprite.animation == "move" \
	and animated_sprite.frame == 2:
		AudioPlayerUtil.play_random(self, footsteps_sfx)
		
	elif animated_sprite.animation == "attack_melee" \
	and animated_sprite.frame == 2:
		AudioPlayerUtil.play_random(self, melee_sfx)
