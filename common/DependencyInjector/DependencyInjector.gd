extends Node2D


var player:Node2D setget , get_player
var nav_2d:Navigation2D setget , get_nav_2d
var world:Node2D setget , get_world


func _ready():
	if ! world:
		# In the absence of a world, create a new one
		# to act as a stand-in. Useful when running a scene in
		# isolation. 
		var stand_in_world = Node2D.new()
		get_tree().root.call_deferred("add_child", stand_in_world)
		world = stand_in_world
		


func get_player() -> Node2D:
	if player:
		return player
	
	var players = get_tree().get_nodes_in_group("Player")
	if (len(players) > 0):
		player = players[0]
	
	return player


func get_nav_2d() -> Navigation2D:
	if nav_2d:
		return nav_2d
		
	var nav_2ds = get_tree().get_nodes_in_group("Navigation")
	if (len(nav_2ds) > 0):
		nav_2d = nav_2ds[0]
		
	return nav_2d


func get_world() -> Node2D:
	if world:
		return world
		
	var worlds = get_tree().get_nodes_in_group("World")
	if (len(worlds) > 0):
		world = worlds[0]

	return world
