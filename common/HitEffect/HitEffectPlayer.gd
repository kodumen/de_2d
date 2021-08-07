extends Node2D


class_name HitEffectPlayer


export(PackedScene) var hit_effect


func play(hit_position):
	var effect = hit_effect.instance()
	add_child(effect)
	effect.global_position = hit_position
