extends AudioStreamPlayer2D


export(Array, AudioStream) var idle_sfx = []
export(float) var idle_tick = 0.1

export(Array, AudioStream) var dead_sfx = []


var timer:Timer


func _ready():
	play_idle()
	begin_timer()


func _on_Enemy_state_idle():
	play_idle()
	begin_timer()
	
	
func _on_Enemy_state_dead():
	play_dead()
	if timer:
		timer.stop()
	

func begin_timer():
	if !timer:
		timer = Timer.new()
		timer.one_shot = false
		timer.connect("timeout", self, "_on_timer_timeout")
		add_child(timer)
	
	timer.wait_time = idle_tick
	timer.start()
	
	
func play_idle():
	AudioPlayerUtil.play_random(self, idle_sfx)


func play_dead():
	AudioPlayerUtil.play_random(self, dead_sfx)


func _on_timer_timeout():
	if playing or ! should_play():
		return
		
	play_idle()


func should_play():
	# Randomly determine if the sound should play.
	return randi() % 100 < 10
