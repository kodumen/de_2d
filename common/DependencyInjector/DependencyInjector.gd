extends Node2D


var player:Node2D setget , get_player
var nav_2d:Navigation2D setget, get_nav_2d


func get_player() -> Node2D:
	var players = get_tree().get_nodes_in_group("Player")
	if (len(players) > 0):
		player = players[0]
	
	return player


func get_nav_2d() -> Navigation2D:
	var nav_2ds = get_tree().get_nodes_in_group("Navigation")
	if (len(nav_2ds) > 0):
		nav_2d = nav_2ds[0]
		
	return nav_2d
