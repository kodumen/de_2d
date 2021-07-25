extends Area2D


export(PackedScene) var hit_effect

var collision_shape:CollisionShape2D

signal hitbox_hit(damage)

func _ready():
	collision_shape = get_collision_shape()

func hit(damage, hit_position):
	create_hit_effect(hit_position)
	emit_signal("hitbox_hit", damage)

func create_hit_effect(hit_position):
	var effect = hit_effect.instance()
	add_child(effect)
	effect.global_position = hit_position

func get_collision_shape():
	for node in get_children():
		if (node is CollisionShape2D):
			return node
	return null
	
func disabled(disable_status):
	collision_shape.set_deferred("disabled", disable_status)
