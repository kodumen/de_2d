# Base classs for projectile and hitscan weapons.
# This class contains functions and properties useful for
# hitscan, projectile, or both.
class_name BaseWeapon


extends AnimatedSprite


enum AMMO_TYPE {
	SHELLS,
	CELLS,
	INFINITE
}


export(int) var damage = 50
export(AMMO_TYPE) var ammo_type
export(int) var ammo_per_shot = 1
export(PackedScene) var hitscan_trail
# This property does not have a setter. Call set_next_weapon() instead.
export(NodePath) var next_weapon_path
export(float) var lower_speed = 1
export(float) var lift_speed = 1


# A reference to the world for a better DX.
onready var world:Node2D = DependencyInjector.world


var is_idle = true
var ray_casts:Array = []
var audio_stream:AudioStreamPlayer

# Can't typehint the class here because of cyclic dependency.
# I also don't want to inherit from another base class so
# let's just forget it.
var prev_weapon
var next_weapon


signal ammo_count_changed(count)


func _ready():
	# warning-ignore:return_value_discarded
	connect("animation_finished", self, "_on_animation_finished")
	
	# In case the weapon use any rays (as with hitscan weapons),
	# collect them for easy access.
	for child in get_children():
		if child is RayCast2D:
			ray_casts.append(child)
			
	if next_weapon_path:
		set_next_weapon(get_node(next_weapon_path))
		
	var default_audio_stream_path = "./AudioStreamPlayer"
	if has_node(default_audio_stream_path):
		audio_stream = get_node(default_audio_stream_path)
		if !audio_stream:
			print_debug("No audio stream found for %s!" % name)
	

# Check whether the weapon is fired.
# Override this depending on how the weapon should behave.
func check_fire() -> bool:
	return false
	

# Do the fire action.
# Override this depending on how the weapon should behave.
# Make sure to call the parent fire() method.
func fire():
	play("fire")
	if audio_stream:
		audio_stream.play()
	is_idle = false


func _on_animation_finished():
	if animation == "fire":
		play("default")
		is_idle = true
		

# Create a trail for hitscan weapons.
# You are not required to use this.
func create_trail(ray_cast:RayCast2D):
	assert(hitscan_trail != null)
	var trail_node:Node2D = hitscan_trail.instance()
	world.add_child(trail_node)
	trail_node.global_transform = ray_cast.global_transform


# Scan for hits and deal damage.
# You are not required to use this.
func check_hit(ray_cast: RayCast2D):
	var collider = ray_cast.get_collider()
	if (collider):
		print_debug(ray_cast.name + " hit " + collider.name)
		if (collider.has_method("hit")):
			var ray_damage = ceil(damage / floor(len(ray_casts)))
			collider.hit(ray_damage, ray_cast.get_collision_point())
			print_debug(ray_cast.name + " dealt " + str(ray_damage) + " DMG!")
	else:
		print_debug(ray_cast.name + " did not hit anything")
	

func set_next_weapon(weapon_node):
	assert(weapon_node != null)	
	# In the absence of typehinting, check if the properties
	# for weapon switching are defined.
	assert("prev_weapon" in weapon_node)
	assert("next_weapon" in weapon_node)
	
	next_weapon = weapon_node
	weapon_node.prev_weapon = self
