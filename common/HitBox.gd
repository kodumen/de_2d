extends Area2D


class_name HitBox


onready var hit_effect_player:HitEffectPlayer = $HitEffectPlayer


var collision_shape:CollisionShape2D


signal hit(damage)


func _ready():
	collision_shape = get_collision_shape()


func hit(damage, hit_position):
	hit_effect_player.play(hit_position)
	emit_signal("hit", damage)


func get_collision_shape():
	for node in get_children():
		if (node is CollisionShape2D):
			return node
	return null

	
func disabled(disable_status):
	collision_shape.set_deferred("disabled", disable_status)
