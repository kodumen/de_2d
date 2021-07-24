extends KinematicBody2D

export(NodePath) var target_path

export var speed = 5

onready var sprite = $Sprite

func _physics_process(_delta):
	var velocity = Vector2()
	
	if (target_path):
		var target = get_node(target_path)
		
		if (target == null):
			return
			
		velocity = position.direction_to(target.global_position)
		velocity *= speed
		
		# sprite direction
		sprite.flip_h = target.global_position.x < global_position.x
		
		move_and_collide(velocity)


func _on_AttackZone_body_entered(body: Node2D):
	if (body.get_groups().has("Player")):
		print(name + " attacks!")
