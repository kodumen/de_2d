extends Item


class_name ShotgunAmmoPack


func player_can_pick(player:Player) -> bool:
	var shotgun = player.get_weapon("Shotgun")
	return shotgun and ! shotgun.is_max_ammo()
	


func player_effect(player:Player):
	var shotgun = player.get_weapon("Shotgun")
	shotgun.ammo += amount
	shotgun.ammo = min(shotgun.ammo, shotgun.max_ammo)

