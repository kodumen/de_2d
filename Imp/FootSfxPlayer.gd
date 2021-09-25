extends EnemyAudioStreamPlayer2D


export(Array, AudioStream) var foot_sfx = []

func get_stream_set() -> Array:
	return foot_sfx
