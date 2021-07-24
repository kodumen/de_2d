extends KinematicBody2D

export(NodePath) var target_path

# TODO: Group exports
export var speed = 5

func _physics_process(_delta):
	var velocity = Vector2()
	
	if (target_path):
		var target = get_node(target_path)
		
		if (target == null):
			return
			
		velocity = position.direction_to(target.global_position)
		velocity *= speed
		
		move_and_collide(velocity)
