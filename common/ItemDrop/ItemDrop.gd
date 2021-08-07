extends Node


class_name ItemDrop


const HEALTH_PACK = preload("res://HealthPack/HealthPack.tscn")
const SHOTGUN_AMMO_PACK = preload("res://AmmoPack/ShotgunAmmoPack.tscn")


export(int, 0, 100) var health_drop_chance = 50
export(int, 0, 100) var armor_drop_chance = 50
export(int, 0, 100) var shotgun_ammo_drop_chance = 50
export(int) var item_count = 1


onready var world:Node2D = DependencyInjector.world


var dropped = false


func _ready():
	# Allow only Enemies to own this node. For now.
	assert(get_parent() is Enemy)
	# warning-ignore:return_value_discarded
	get_parent().connect("state_dead", self, "drop")
	
	
func drop():
	if dropped:
		queue_free()
		return
		
	roll(health_drop_chance, HEALTH_PACK)
	roll(shotgun_ammo_drop_chance, SHOTGUN_AMMO_PACK)
	dropped = true

	
func roll(chance:int, item_scene:PackedScene):
	print_debug("Rolling for %s!" % item_scene.resource_path)
	if (randi() % chance) >= chance:
		print_debug("Too bad.")
	else:
		print_debug("Spawning %s!" % item_scene.resource_path)
		for i in range(item_count):
			var item = item_scene.instance()
			get_parent().add_child(item)
			item.global_position = get_parent().global_position
