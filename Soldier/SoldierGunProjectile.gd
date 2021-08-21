class_name SoldierGunProjectile


extends Area2D


const SPRITES = [
	preload("res://Soldier/bullet-1.png"),
	preload("res://Soldier/bullet-2.png"),
	preload("res://Soldier/bullet-3.png"),
]


onready var sprite:Sprite = $Sprite


var speed = 1000
var attack = 0


func _ready():
	sprite.texture = SPRITES[randi() % SPRITES.size()]


func _physics_process(delta):
	translate((Vector2.RIGHT * speed * delta).rotated(global_rotation))


func _on_SoldierGunProjectile_body_entered(body:Node2D):
	if body.has_method("hit"):
		if body is Player:
			body.hit(attack)
		else:
			body.hit(attack, global_position)
	
	queue_free()
