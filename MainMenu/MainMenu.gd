extends CanvasLayer


export(PackedScene) var room1


func _ready():
	# Ensure that the scene will run after returning from pause menu.
	get_tree().paused = false


func _on_QuitButton_button_up():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_NewGameButton_button_up():
	assert(room1 != null)
	get_tree().change_scene_to(room1)
