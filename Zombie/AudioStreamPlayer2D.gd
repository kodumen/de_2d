extends EnemyAudioStreamPlayer2D


export(Array, AudioStream) var idle_sfx = []
export(Array, AudioStream) var dead_sfx = []


func _on_Enemy_state_dead():
	._on_Enemy_state_dead()
	AudioPlayerUtil.play_random(self, dead_sfx)	


func get_stream_set() -> Array:
	return idle_sfx
