extends Area2D


class_name Item


export(int) var amount = 25


var animation_player:AnimationPlayer

func _ready():
	_item_ready()

	# Require an animation player for the drop animations.
	if ! animation_player:
		animation_player = get_node("./ItemDropAnimation")

	assert(animation_player)
	var animations = animation_player.get_animation_list()
	animation_player.play(animations[randi() % animations.size()])
	# warning-ignore:return_value_discarded
	connect("area_entered", self, "_on_area_entered")


# Item initialization. Feel free to override.
func _item_ready():
	pass


func _on_area_entered(area):
	var player = area.get_parent()
	print_debug("%s is near %s" % [player.name, name])
	if player is Player and player_can_pick(player):
		player_effect(player)
		player.emit_signal("item_pickup", self)
		queue_free()


func player_effect(_player:Player):
	pass
	
func player_can_pick(_player:Player) -> bool:
	return true
