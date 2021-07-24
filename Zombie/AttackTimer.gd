extends Timer


onready var zombie = $"./../"

var target

func _on_Zombie_zombie_attack(target):
	self.target = target
	start()

func _on_AttackTimer_timeout():
	if (target != null):
		target.hit(zombie.attack)

func _on_Zombie_zombie_motion(velocity):
	stopAttack()

func _on_Zombie_zombie_idle():
	stopAttack()

func stopAttack():
	target = null
	stop()
