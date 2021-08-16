extends Node2D



var lower_weapon:BaseWeapon
var lift_weapon:BaseWeapon


onready var animation_player = $AnimationPlayer
onready var remote_weapon = $RemoteWeaponProps


signal weapon_ready(weapon)


func _process(_delta):
	if ! animation_player.is_playing():
		return
		
	lift_weapon.look_at(get_global_mouse_position())
	
	if get_global_mouse_position().x < global_position.x:
		lift_weapon.scale.y = -1
	else:
		lift_weapon.scale.y = 1


func begin():
	remote_weapon.remote_path = lower_weapon.get_path()
	animation_player.play("weapon_lower", -1, 1 / lower_weapon.lower_speed)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "weapon_lower":
		lower_weapon.visible = false
		lift_weapon.visible = true
		
		remote_weapon.remote_path = lift_weapon.get_path()
		animation_player.play("weapon_lift", -1, 1 / lift_weapon.lift_speed)
	else:
		emit_signal("weapon_ready", lift_weapon)
	
