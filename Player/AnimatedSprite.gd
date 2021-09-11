extends AnimatedSprite


const FOOTSTEPS = [
	preload("res://Player/player_footstep_1.wav"),
	preload("res://Player/player_footstep_2.wav"),
	preload("res://Player/player_footstep_3.wav"),
	preload("res://Player/player_footstep_4.wav"),
	preload("res://Player/player_footstep_5.wav")
]


onready var footstep_player:AudioStreamPlayer = $FootstepPlayer


var last_footstep = null


func _on_Player_state_dead():
	play("dead")


func _on_Player_state_idle():
	play("default")


func _on_Player_state_motion(velocity):
	if (velocity.x > 0 and not flip_h) or (velocity.x < 0 and flip_h):
		play("move")
	elif (velocity.x < 0 and not flip_h) or (velocity.x > 0 and flip_h):
		play("move_reversed")
	elif (velocity.y != 0):
		play("move")


func _on_Player_state_exiting():
	play("default")


func _on_AnimatedSprite_frame_changed():
	if animation == "move" or animation == "move_reversed":
		if frame == 1:
			play_footstep()
		

func play_footstep():
	var stream = last_footstep
	while stream == last_footstep:
		stream = FOOTSTEPS[randi() % FOOTSTEPS.size()]
		
	last_footstep = stream
	
	footstep_player.stream = stream
	footstep_player.play()
