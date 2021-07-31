extends Node2D


const FIREBALL = preload("res://common/Fireball/Fireball.tscn")
const FIREBALL_SCALE = Vector2.ONE * 0.75

onready var animated_sprite:AnimatedSprite = $"../AnimatedSprite"
onready var world:Node2D = DependencyInjector.world


var target:Node2D


func _process(_delta):
	if target:
		look_at(target.global_position)


func _on_AnimatedSprite_frame_changed():
	if target \
	and animated_sprite.animation == "attack" \
	and animated_sprite.frame == 4:
		var fireball = FIREBALL.instance()
		world.add_child(fireball)
		
		# Configure the fireball
		fireball.damage = get_parent().attack
		fireball.thrower = get_parent()
		fireball.global_transform = global_transform
		fireball.global_scale = FIREBALL_SCALE


func _on_Imp_state_attacking(target_node):
	target = target_node
