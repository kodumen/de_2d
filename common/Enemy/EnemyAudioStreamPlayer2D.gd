class_name EnemyAudioStreamPlayer2D
# This node is perfect for continuous playback of random sfx.
# Extend this node and override get_stream_set().
# In the Enemy node, remember to call connect_node() to connect
# listeners.


extends AudioStreamPlayer2D


# Duration until we check whether the audio should played.
export(float) var audio_tick = 0.5
export(int, 0, 100) var play_probability = 10


var timer:Timer


func _ready():
	timer = Timer.new()
	timer.one_shot = false
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)
	
	timer.wait_time = audio_tick
	timer.start()


func _on_timer_timeout():
	if playing or ! should_play():
		return
		
	AudioPlayerUtil.play_random(self, get_stream_set())


func should_play() -> bool:
	return randi() % 100 < play_probability


func get_stream_set() -> Array:
	# Return the streams to choose from.
	# This method is polled. Not a replacement for signals.
	return []
	
	
func _on_Enemy_state_dead():
	timer.stop()
	stop()
