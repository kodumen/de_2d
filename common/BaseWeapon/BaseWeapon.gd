extends AnimatedSprite


class_name BaseWeapon


export(int) var damage = 50
export(int) var max_ammo = 8
export(int) var ammo = 8


# A reference to the world for a better DX.
onready var world:Node2D = DependencyInjector.world


var is_idle = true


func _ready():
	# warning-ignore:return_value_discarded
	connect("animation_finished", self, "_on_animation_finished")


# Check whether the weapon is fired.
# Override this depending on how the weapon should behave.
func check_fire() -> bool:
	return false
	

# Do the fire action.
# Override this depending on how the weapon should behave.
# Make sure to call the parent fire() method.
func fire():
	ammo -= 1
	play("fire")
	is_idle = false


func is_max_ammo() -> bool:
	return ammo >= max_ammo
	

# Check ammo and state
func can_fire() -> bool:
	return ammo > 0 and is_idle


func _on_animation_finished():
	if animation == "fire":
		play("default")
		is_idle = true
