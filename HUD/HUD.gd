extends Node


export(NodePath) var player_path

var player:Player

onready var health_label = $MarginContainer/VBoxContainer/HSplitContainer2/HealthLabel
onready var armor_label = $MarginContainer/VBoxContainer/HSplitContainer/ArmorLabel
onready var ammo_label = $MarginContainer/VBoxContainer/HSplitContainer/AmmoLabel
onready var game_over = $GameOver
onready var no_ammo = $NoAmmo

func _ready():
	if (player_path):
		player = get_node(player_path)
	else:
		player = DependencyInjector.player
		
	if player:
		_update_hud()
		# warning-ignore:return_value_discarded
		player.connect("state_dead", self, "_on_Player_state_dead")
		# warning-ignore:return_value_discarded
		player.connect("hit", self, "_on_Player_hit")
		# warning-ignore:return_value_discarded
		player.connect("fire", self, "_on_Player_fire")
		# warning-ignore:return_value_discarded
		player.connect("item_pickup", self, "_on_Player_item_pickup")


func _on_Player_hit():
	_update_hud()
	
	
func _on_Player_fire():
	_update_hud()
	
	
func _on_Player_item_pickup(_item):
	_update_hud()


func _update_hud():
	health_label.text = "Health: " + str(player.health)
	armor_label.text = "Armor: " + str(player.armor)
	ammo_label.text = "Ammo: " + str(player.ammo)
	
	no_ammo.visible = player.ammo == 0


func _on_Player_state_dead():
	game_over.visible = true
