extends Area2D


export var speed = 750
export var damage = 50

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_Projectile_body_entered(body: Node2D):
	on_hit(body)


func _on_ShotgunProjectile_area_entered(area: Area2D):
	on_hit(area)


func on_hit(collider):
	print_debug(name + " hit " + str(collider.get_path()))
	if (collider.has_method("hit")):
		collider.hit(damage)
		queue_free()
