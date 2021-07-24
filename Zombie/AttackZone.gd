extends Area2D

onready var collisionShape = $CollisionShape2D


func _on_Zombie_zombie_dead():
	# Queue disable until after the physics update
	collisionShape.set_deferred("disabled", true)
