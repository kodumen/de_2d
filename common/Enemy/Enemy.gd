extends KinematicBody2D


class_name Enemy


enum STATE {
	IDLE,
	MOVING,
	ATTACKING,
	DEAD
}

export(int) var armor = 0
export(int) var health = 100
export(int) var speed = 100
export(int) var attack = 20
export(bool) var target_player = true
export(NodePath) var target_path
export(NodePath) var nav_2d_path

# The enemy's initial state. If a target is set,
# the state changes to MOVING.
export(STATE) var state = STATE.IDLE setget set_state

var target:Node2D setget set_target
var nav_2d:Navigation2D
var animated_sprite:AnimatedSprite
var hit_box:HitBox
var movement_collider:CollisionShape2D
# If a custom hit box is used, default listeners will not
# be connected. You must call the hit() method to deal damage to the
# enemy. You can then ignore the hit_box property. Use this for weakpoints.
var use_custom_hit_box:bool = false
# A Line2D node used to see the enemy's path.
var path_line:Line2D


signal state_idle
signal state_moving(velocity)
# warning-ignore:unused_signal
signal state_attacking(target)
signal state_dead
signal hit(damage)


func _ready():
	_enemy_ready()
	# Set target
	if target_path:
		set_target(get_node(target_path))
	elif target_player:
		set_target(DependencyInjector.player)

	# Set nav 2D
	if nav_2d_path:
		nav_2d = get_node(nav_2d_path)
	else:
		nav_2d = DependencyInjector.nav_2d
		if nav_2d == null:
			print_debug("No Navigation2D found! %s will not move!" % name)

	# Connect animated_sprite listeners
	if animated_sprite:
		var listeners = {
			"state_idle": "_on_Enemy_state_idle",
			"state_moving": "_on_Enemy_state_moving",
			"state_attacking": "_on_Enemy_state_attacking",
			"state_dead": "_on_Enemy_state_dead"
		}
		for enemy_signal in listeners:
			if animated_sprite.has_method(listeners[enemy_signal]):
				# warning-ignore:return_value_discarded
				connect(enemy_signal, animated_sprite, listeners[enemy_signal])
	
	# Configure hit_box
	if ! use_custom_hit_box and hit_box:
		# warning-ignore:return_value_discarded
		hit_box.connect("hit", self, "_on_hit_box_hit")
		
	# Find and configure the movement collider
	if ! movement_collider:
		for child in get_children():
			if child is CollisionShape2D:
				movement_collider = child
				break
		
	# warning-ignore:return_value_discarded
	connect("state_dead", self, "_on_Enemy_state_dead")
		
	# Should we add another ready hook (e.g. _enemy_ready_final())?


# Initializer function for the enemy class. This is called at the very start of
# _ready(). Feel free to override this.
func _enemy_ready():
	pass


func _physics_process(delta):
	if state != STATE.MOVING or target == null or nav_2d == null:
		return
		
	var nearest_stop = find_next_stop(target.global_position)
	
	var velocity = Vector2()
	velocity = position.direction_to(nearest_stop)
	velocity *= speed * delta
	
	if velocity.length() > 0:
		emit_signal("state_moving", velocity)
	else:
		emit_signal("state_idle")
	
	# warning-ignore:return_value_discarded
	move_and_collide(velocity)


func set_target(value:Node2D):
	target = value
	set_state(STATE.MOVING)
	print_debug("%s is targeting %s!" % [name, target.name])
	
	# Hard-code signal bindings to the player for convenience (??).
	if target.is_in_group("Player"):
		# warning-ignore:return_value_discarded
		target.connect("state_dead", self, "_on_target_state_dead")


func set_state(value:int):
	state = value
	if state == STATE.IDLE:
		emit_signal("state_idle")
	if state == STATE.DEAD:
		emit_signal("state_dead")


# Find the path to the target position and return the nearest stop.
func find_next_stop(target_position) -> Vector2:
	var path = nav_2d.get_simple_path(global_position, target_position)
	
	# Draw the path for debugging purposes.
	if path_line:
		var localized_path = PoolVector2Array()
		for path_index in range(path.size()):
			localized_path.append(path[path_index] - global_position)
		path_line.points = localized_path
	
	if path.size() >= 2:
		return path[1]
	
	return global_position
	

func _on_target_state_dead():
	set_state(STATE.IDLE)
	
	
func _on_hit_box_hit(damage):
	hit(damage)


func hit(damage):
	armor -= damage
	
	if armor < 0:
		health -= abs(armor)
		health = max(health, 0)
		armor = 0
	
	emit_signal("hit", damage)
	
	if health == 0:
		set_state(STATE.DEAD)
		

func _on_Enemy_state_dead():
	movement_collider.set_deferred("disabled", true)
	hit_box.disabled(true)
