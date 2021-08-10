extends Node2D


onready var SHOTGUN = $Shotgun


var active_weapon:BaseWeapon
var ammo setget , get_ammo


signal fire


func _ready():
	active_weapon = SHOTGUN


func _process(_delta):
	if ! visible:
		return

	look_at(get_global_mouse_position())
	
	if get_global_mouse_position().x < global_position.x:
		scale.y = -abs(scale.y)
	else:
		scale.y = abs(scale.y)
		
		
func _physics_process(_delta):
	if ! visible:
		return
	
	if active_weapon.can_fire() and active_weapon.check_input():
		active_weapon.fire()
		emit_signal("fire")


func _on_Player_state_dead():
	visible = false
	
	
func get_ammo() -> int:
	assert("ammo" in active_weapon)
	return active_weapon.ammo
