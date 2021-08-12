extends Node2D


onready var shotgun:Shotgun = $Shotgun
onready var pistol:Pistol = $Pistol


var active_weapon:BaseWeapon
var ammo setget , get_ammo


signal fire
signal ammo_count_changed(amount)


func _ready():
	active_weapon = pistol
	active_weapon.visible = true
	active_weapon.connect(
		"ammo_count_changed", 
		self,
		"_on_active_weapon_ammo_count_changed"
	)
	


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
	
	if active_weapon.can_fire() and active_weapon.check_fire():
		active_weapon.fire()
		emit_signal("fire")


func _on_Player_state_dead():
	visible = false
	
	
func get_ammo() -> int:
	assert("ammo" in active_weapon)
	return active_weapon.ammo
	
	
func _on_active_weapon_ammo_count_changed(amount):
	emit_signal("ammo_count_changed", amount)
