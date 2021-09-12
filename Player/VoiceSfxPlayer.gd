extends AudioStreamPlayer


export(Array, AudioStream) var hit_sfx = []
export(Array, AudioStream) var dead_sfx = []

func _on_Player_hit():
	AudioPlayerUtil.play_random(self, hit_sfx)


func _on_Player_state_dead():
	AudioPlayerUtil.play_random(self, dead_sfx)
