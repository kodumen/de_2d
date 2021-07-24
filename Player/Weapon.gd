extends Node2D

onready var SHOTGUN = $Shotgun

var activeWeapon

func _ready():
	activeWeapon = SHOTGUN

func _process(_delta):
	if (! visible):
		return

	look_at(get_global_mouse_position())
	
	if (get_global_mouse_position().x < global_position.x):
		scale.y = -abs(scale.y)
	else:
		scale.y = abs(scale.y)
		
		
func _physics_process(_delta):
	if (! visible):
		return
	
	if (Input.is_action_just_pressed("player_primary")):
		activeWeapon.fire()


func _on_Player_player_dead():
	visible = false
