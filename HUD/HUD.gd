extends Node


export(NodePath) var player_path

var player

onready var healthLabel = $MarginContainer/VBoxContainer/HealthLabel
onready var armorLabel = $MarginContainer/VBoxContainer/ArmorLabel
onready var gameOver = $GameOver

func _ready():
	if (player_path):
		player = get_node(player_path)
		_update_hud()


func _on_Player_player_hit():
	_update_hud()

func _update_hud():
	healthLabel.text = "Health: " + str(player.health)
	armorLabel.text = "Armor: " + str(player.armor)



func _on_Player_player_dead():
	gameOver.visible = true
