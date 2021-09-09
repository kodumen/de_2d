extends Node


onready var player:Node2D = null setget , get_player
onready var nav_2d:Navigation2D = null setget , get_nav_2d
onready var world:Node2D = null setget , get_world



func get_player() -> Node2D:
#	if player:
#		return player
	
	return get_first_child_of_group("Player")


func get_nav_2d() -> Navigation2D:
#	if nav_2d:
#		return nav_2d
		
	return get_first_child_of_group("Navigation")


func get_world() -> Node2D:
#	if world:
#		return world
		
	world = get_first_child_of_group("World")

	if ! world:
		# In the absence of a world, create a new one
		# to act as a stand-in. Useful when running a scene in
		# isolation. 
		var stand_in_world = Node2D.new()
		get_tree().root.call_deferred("add_child", stand_in_world)
		world = stand_in_world

	return world
	
	
func get_first_child_of_group(group:String):
	var children = get_tree().get_nodes_in_group(group)
	if (len(children) > 0):
		return children[0]
		
	return null
