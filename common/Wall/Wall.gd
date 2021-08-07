extends StaticBody2D


class_name Wall


var hit_effect_player:HitEffectPlayer


func _ready():
	hit_effect_player = find_hit_effect_player()
	assert(hit_effect_player != null)
	
	
func find_hit_effect_player() -> HitEffectPlayer:
	for child in get_children():
		if child is HitEffectPlayer:
			return child
	return null


func hit(_attack, hit_position):
	hit_effect_player.play(hit_position)
