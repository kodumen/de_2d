extends CanvasLayer


export(PackedScene) var room1


func _on_QuitButton_button_up():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_NewGameButton_button_up():
	assert(room1 != null)
	get_tree().change_scene_to(room1)
