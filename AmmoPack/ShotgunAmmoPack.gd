extends Item


class_name ShotgunAmmoPack


func player_can_pick(player:Player) -> bool:
	return player.shells < player.max_shells


func player_effect(player:Player):
	player.shells += amount
	player.shells = min(player.shells, player.max_shells)
