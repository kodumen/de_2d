extends AudioStreamPlayer2D


export(Array, AudioStream) var idle_sfx = []
export(float) var idle_tick = 0.1

export(Array, AudioStream) var dead_sfx = []


var timer:Timer
var last_stream:AudioStream = null


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
	var new_stream = last_stream
	if idle_sfx.size() > 1:
		while new_stream == last_stream:
			new_stream = idle_sfx[randi() % idle_sfx.size()]
	else:
		new_stream = idle_sfx[0]

	stream = new_stream
	last_stream = stream
	play()


func play_dead():
	if dead_sfx.empty():
		print_debug("Dead SFX of %s is empty!" % get_parent().name)
		return
		
	stream = dead_sfx[randi() % dead_sfx.size()]
	play()


func _on_timer_timeout():
	if idle_sfx.empty():
		print_debug("Idle SFX of %s is empty!" % get_parent().name)
		return
		
	if playing or ! should_play():
		return
		
	play_idle()


func should_play():
	# Randomly determine if the sound should play.
	return randi() % 100 < 10
