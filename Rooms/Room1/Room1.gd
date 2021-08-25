extends Node2D


onready var door:Wall = $Door


func _ready():
	EventBus.connect("enemy_state_dead", self, "_on_enemy_state_dead")
	
	
func _on_enemy_state_dead(_enemy):
	var living = living_enemies()
	print_debug("%d enemies remaining." % living)
	if living_enemies() == 0:
		door.disable()
		
		
func living_enemies():
	var count = 0
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if enemy.state != Enemy.STATE.DEAD \
		and is_a_parent_of(enemy):
			count += 1
	
	return count
