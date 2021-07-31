extends Area2D


export var speed = 900
export var damage = 0


# Who threw this fireball?
var thrower:Node2D


func _physics_process(delta):
	var velocity = Vector2(speed, 0) * delta
	velocity = velocity.rotated(global_rotation)
	
	translate(velocity)
	


func _on_Fireball_body_entered(body:Node2D):
	if body == thrower:
		return
		
	if body.has_method("hit"):
		if body.is_in_group("Player"):
			body.hit(damage)
		else:
			body.hit(damage, global_position)
	
	queue_free()


func _on_Fireball_area_entered(area:Node2D):
	if thrower and (area == thrower or thrower.is_a_parent_of(area)):
		return
	
	print_debug("%s hit $%s!" % [name, area.name])
	
	if area.has_method("hit"):
		area.hit(damage, global_position)
		
	queue_free()
