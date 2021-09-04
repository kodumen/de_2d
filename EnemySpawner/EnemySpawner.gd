class_name EnemySpawner


extends Node2D


const FIRE = preload("res://EnemySpawner/Particles2D.tscn")
const WAIT_TIME = 0.8


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
	var fire = FIRE.instance()
	add_child(fire)
	fire.global_position = global_position
	var timer = Timer.new()
	timer.wait_time = WAIT_TIME
	timer.one_shot = true
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)
	timer.start()


func _on_timer_timeout():
	spawn()
	if oneshot:
		queue_free()	


func spawn():
	var enemy:Enemy = enemy_scene.instance()
	
	world.add_child(enemy)
	
	enemy.global_position = global_position
	
	for group in get_groups():
		enemy.add_to_group(group)
	

