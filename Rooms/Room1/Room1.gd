extends Node2D


const CURSOR = preload("res://Player/cursor_default.png")

onready var door:Wall = $Door


func _ready():
	set_mouse_cursor()
	EventBus.connect("enemy_state_dead", self, "_on_enemy_state_dead")
	EventBus.connect("game_resumed", self, "_on_game_resumed")
	
	
func _on_enemy_state_dead(_enemy):
	var living = living_enemies("Wave 1")
	print_debug("%d enemies remaining." % living)
	if living == 0:
		door.disable()
		
		
func living_enemies(group):
	var count = 0
	for enemy in get_tree().get_nodes_in_group(group):
		if enemy is Enemy \
		and enemy.state != Enemy.STATE.DEAD \
		and is_a_parent_of(enemy):
			count += 1
	
	return count


func set_mouse_cursor():
	Input.set_custom_mouse_cursor(CURSOR, Input.CURSOR_ARROW, Vector2(30, 30))


func _on_game_resumed():
	set_mouse_cursor()
