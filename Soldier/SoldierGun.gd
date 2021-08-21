extends AnimatedSprite


const PROJECTILE = preload("res://Soldier/SoldierGunProjectile.tscn")


onready var muzzle:Node2D = $Muzzle
onready var timer:Timer = $Timer
onready var world:Node2D = DependencyInjector.world


var attack:int = 0


func _on_Soldier_state_attack_ranged(target, attack):
	play("fire")
	timer.start()


func _on_Soldier_state_idle():
	play("default")
	timer.stop()


func _on_Soldier_state_dead():
	visible = false
	timer.stop()

func _on_Soldier_state_moving(velocity):
	play("default")
	timer.stop()


func _on_Timer_timeout():
	var projectile:SoldierGunProjectile = PROJECTILE.instance()
	world.add_child(projectile)
	projectile.attack = attack
	projectile.global_position = muzzle.global_position
	projectile.global_rotation = global_rotation
