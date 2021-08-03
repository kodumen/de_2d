extends Node2D

# This class can have no other child except RayCast2Ds.
class_name Sightline


export(int) var sight_range = 400
export(int, LAYERS_2D_PHYSICS) var view_mask
export(int, 1, 10) var ray_count = 3
export(float, 30, 180) var fov = 45 


func _ready():
	var starting_angle = -(fov / 2.0)
	var angle_per_ray = fov / max(float(ray_count - 1), 1)
	for i in range(ray_count):
		var ray = RayCast2D.new()
		ray.enabled = true
		ray.collision_mask = view_mask
		ray.cast_to = Vector2(sight_range, 0)
		
		add_child(ray)
		
		ray.rotation_degrees = starting_angle + (i * angle_per_ray)
		
	for child in get_children():
		assert(child is RayCast2D)
		

func is_clear() -> bool:
	for ray in get_children():
		if ray.is_colliding():
			return false
	return true
