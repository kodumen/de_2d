extends Node2D


const FIREBALL = preload("res://common/Fireball/Fireball.tscn")
const FIREBALL_SCALE = Vector2.ONE * 0.75

onready var world:Node2D = DependencyInjector.world


func _process(_delta):
	if get_parent().target:
		look_at(get_parent().target.global_position)


func _on_AnimatedSprite_frame_changed():
	if get_parent().target \
	and get_parent().animated_sprite.animation == "attack_ranged" \
	and get_parent().animated_sprite.frame == 4:
		var fireball = FIREBALL.instance()
		world.add_child(fireball)
		
		# Configure the fireball
		fireball.damage = get_parent().attack_ranged
		fireball.thrower = get_parent()
		fireball.global_transform = global_transform
		fireball.global_scale = FIREBALL_SCALE
