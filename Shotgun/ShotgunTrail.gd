extends Line2D


onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("default")


func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
