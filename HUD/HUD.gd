extends Node


export(NodePath) var player_path

var player

onready var healthLabel = $MarginContainer/VBoxContainer/HealthLabel
onready var armorLabel = $MarginContainer/VBoxContainer/ArmorLabel
onready var gameOver = $GameOver

func _ready():
	if (player_path):
		player = get_node(player_path)
	else:
		player = DependencyInjector.player
		
	if player:
		_update_hud()
		player.connect("state_dead", self, "_on_Player_state_dead")
		player.connect("hit", self, "_on_Player_hit")


func _on_Player_hit():
	_update_hud()


func _update_hud():
	healthLabel.text = "Health: " + str(player.health)
	armorLabel.text = "Armor: " + str(player.armor)


func _on_Player_state_dead():
	gameOver.visible = true
