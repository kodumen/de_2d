extends EnemyAudioStreamPlayer2D


export(Array, AudioStream) var growl_sfx = []


func get_stream_set() -> Array:
	return growl_sfx


func _on_Enemy_target(_target):
	AudioPlayerUtil.play_random(self, get_stream_set())
