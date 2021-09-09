extends CanvasLayer


onready var menu = $MarginContainer


func _ready():
	menu.visible = false


func _unhandled_input(event:InputEvent):
	if event.is_action_pressed("ui_cancel"):
		toggle()


func pause():
	menu.visible = true
	get_tree().paused = true
	Input.set_custom_mouse_cursor(null)
	

func resume():
	menu.visible = false
	get_tree().paused = false
	EventBus.emit_signal("game_resumed")
	
	
func toggle():
	if get_tree().paused:
		resume()
	else:
		pause()


func _on_ResumeButton_button_up():
	resume()


func _on_QuitButton_button_up():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_MainMenuButton_button_up():
	get_tree().change_scene(ProjectSettings.get_setting("application/run/main_scene"))
