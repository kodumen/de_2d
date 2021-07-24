extends AnimatedSprite

onready var PROJECTILE = preload("res://Shotgun/ShotgunProjectile.tscn")
onready var world = $"/root".get_child(0).get_node("World")
onready var muzzle = $Muzzle


func fire():
	if (world != null):
		var projectile = PROJECTILE.instance()
		world.add_child(projectile)
		var projectileScale = projectile.scale
		projectile.transform = muzzle.global_transform
		projectile.scale = projectileScale
