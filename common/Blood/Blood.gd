extends Node2D


onready var BLOOD_EFFECT = preload("res://common/Blood/BloodEffect.tscn")

func create_effect(effect_position):
	var effect = BLOOD_EFFECT.instance()
	add_child(effect)
	effect.global_position = effect_position
	effect.playing = true
	effect.connect("animation_finished", self, "on_effect_animation_finished", [effect])
	
func on_effect_animation_finished(effect):
	effect.queue_free()
