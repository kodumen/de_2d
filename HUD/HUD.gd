extends Node


export(NodePath) var player_path

var player:Player

onready var health_label = $MarginContainer/HSplitContainer/VBoxContainer/HSplitContainer2/HealthLabel
onready var armor_label = $MarginContainer/HSplitContainer/VBoxContainer/HSplitContainer/ArmorLabel
onready var shell_label = $MarginContainer/HSplitContainer/VBoxContainer2/ShellLabel
onready var clip_label = $MarginContainer/HSplitContainer/VBoxContainer2/ClipLabel
onready var cell_label = $MarginContainer/HSplitContainer/VBoxContainer2/CellLabel
onready var game_over = $GameOver
onready var no_ammo = $NoAmmo

func _ready():
	if (player_path):
		player = get_node(player_path)
	else:
		player = DependencyInjector.player
		
	if player != null:
		_update_hud()
		# warning-ignore:return_value_discarded
		player.connect("state_dead", self, "_on_Player_state_dead")
		# warning-ignore:return_value_discarded
		player.connect("hit", self, "_on_Player_hit")
		# warning-ignore:return_value_discarded
		player.connect("item_pickup", self, "_on_Player_item_pickup")
		player.connect("ammo_count_changed", self, "_on_Player_ammo_count_changed")


func _on_Player_hit():
	_update_hud()
	
	
func _on_Player_fire():
	_update_hud()
	
	
func _on_Player_item_pickup(_item):
	_update_hud()
	
func _on_Player_ammo_count_changed():
	_update_hud()


func _update_hud():
	health_label.text = "Health: %d" % player.health
	armor_label.text = "Armor: %d" % player.armor
	
	shell_label.text = "Shells: %d" % player.shells
	clip_label.text = "Infinite: %d" % INF
	cell_label.text = "Cells: %d" % player.cells
	
	no_ammo.visible = ! player.weapon_has_ammo()


func _on_Player_state_dead():
	game_over.visible = true
