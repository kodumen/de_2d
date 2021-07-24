extends Area2D


export var speed = 750
export var damage = 50

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_Projectile_body_entered(body: Node2D):
	if (body.is_in_group("Enemies")):
		body.hit(damage)
		queue_free()
