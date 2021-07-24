extends Node


export(NodePath) var player_path

var player

onready var healthLabel = $MarginContainer/VBoxContainer/HealthLabel
onready var armorLabel = $MarginContainer/VBoxContainer/ArmorLabel

func _ready():
	if (player_path):
		player = get_node(player_path)
		healthLabel.text = "Health: " + str(player.health)
		armorLabel.text = "Armor: " + str(player.armor)
