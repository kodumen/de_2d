class_name EnemySpawner


extends Node2D


export(PackedScene) var enemy_scene
export(bool) var oneshot = true
export(NodePath) var spawn_on_death_of_enemy_path


onready var world:Node2D = DependencyInjector.world


var spawn_on_death_of_enemy:Enemy


func _ready():	
	if spawn_on_death_of_enemy_path:
		spawn_on_death_of_enemy = get_node(spawn_on_death_of_enemy_path)
		spawn_on_death_of_enemy.connect("state_dead", self, "_on_enemy_state_dead")
	
	
func _on_enemy_state_dead():
	print_debug("%s is dead! Spawning!" % spawn_on_death_of_enemy.name)
	spawn()
	if oneshot:
		queue_free()	



func spawn():
	var enemy:Enemy = enemy_scene.instance()
	
	world.add_child(enemy)
	
	enemy.global_position = global_position
	
	for group in get_groups():
		enemy.add_to_group(group)
	

