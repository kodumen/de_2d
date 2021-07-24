extends Area2D


onready var blood = $Blood

var collisionShape:CollisionShape2D

signal hitbox_hit(damage)

func _ready():
	collisionShape = get_collision_shape()

func hit(damage):
	emit_signal("hitbox_hit", damage)

func clash(clash_position):
	blood.create_effect(clash_position)

func get_collision_shape():
	for node in get_children():
		if (node is CollisionShape2D):
			return node
	return null
	
func disabled(disable_status):
	collisionShape.set_deferred("disabled", disable_status)
