extends EnemyAudioStreamPlayer2D


export(Array, AudioStream) var growl_sfx = []
export(Array, AudioStream) var death_sfx = []


func get_stream_set() -> Array:
	return growl_sfx


func _on_Enemy_target(_target):
	AudioPlayerUtil.play_random(self, get_stream_set())
	
	
func _on_Enemy_state_dead():
	._on_Enemy_state_dead()
	AudioPlayerUtil.play_random(self, death_sfx)
	
