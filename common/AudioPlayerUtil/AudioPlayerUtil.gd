# Helper functions for AudioPlayer and AudioPlayer2D

extends Node


func play_random(audio_player, sfx_set:Array):
	# Play a random audio stream from the set.
	# The same stream can't be played consecutively.
	assert(audio_player is AudioStreamPlayer or audio_player is AudioStreamPlayer2D)
	
	if sfx_set.empty():
		print_debug("No sfx.")
		return
		
	if sfx_set.size() == 1:
		audio_player.stream = sfx_set[0]
	else:
		var new_stream = audio_player.stream
		while new_stream == audio_player.stream:
			new_stream = sfx_set[randi() % sfx_set.size()]
			
		audio_player.stream = new_stream
		
	audio_player.play()
	
