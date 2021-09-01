class_name Exit


extends Area2D


export(PackedScene) var next_room:PackedScene


func _ready():
	assert(next_room != null)
	# warning-ignore:return_value_discarded
	connect("body_entered", self, "_on_body_entered")
	
	
func _on_body_entered(_body:Node2D):
	EventBus.emit_signal("player_entered_exit")
	# warning-ignore:return_value_discarded
	start_exit_sequence()
	
	
func start_exit_sequence():
	var timer:Timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 1.5
	timer.connect("timeout", self, "_on_exit_sequence_end")
	
	add_child(timer)
	timer.start()
	
	
func _on_exit_sequence_end():
	get_tree().change_scene_to(next_room)
