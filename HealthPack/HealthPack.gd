extends Item


class_name HealthPack


func player_can_pick(player:Player):
	return ! player.is_max_health()


func player_effect(player:Player):
	player.health += amount
	player.health = min(player.health, player.max_health)
