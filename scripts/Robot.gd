extends KinematicBody2D

const BULLET_NODE = preload("res://scenes/Bullet.tscn")

export var LASER_ENABLED = false
export var ROTATION_ENABLED = false
export var ROUTE_ENABLED = false
export var DESTROY_ROBOTS = false

export var LASER_LENGTH = 200
export var ROTATION_VELOCITY = 120
export var INITIAL_LASER_ROTATION = 0
export var ROTATION_DIRECTION = 1
export var SHOOT_COOLDOWN = .1
export var WALK_SPEED = 50
export(Array, Vector2) var ROUTE_POINTS = []

var route_destiny_index = 0
var aiming_at = null

func _ready():
	add_to_group(Globals.ROBOT_GROUP)
	if LASER_ENABLED: _enable_laser()

func _enable_laser():
	$Laser.enabled = true
	$Laser.rotation_degrees = INITIAL_LASER_ROTATION
	$Laser.set_cast_to(Vector2(LASER_LENGTH, 0))

func _draw():
	if LASER_ENABLED:
		var laser_color = Color(.8, .8, 0) if aiming_at == null else Color(1, 0, 0)
		var laser_width = 3 if aiming_at == null else 1
		draw_line(
			Vector2.ZERO,
			Vector2(LASER_LENGTH, 0).rotated($Laser.rotation),
			laser_color,
			laser_width
		)

func _physics_process(delta):
	if LASER_ENABLED:
		update()
		aiming_at = $Laser.get_collider()
		if aiming_at != null:
			if not DESTROY_ROBOTS and aiming_at.is_in_group(Globals.ROBOT_GROUP): aiming_at = null
			else:
				$Laser.look_at(aiming_at.global_position)
				_shoot()
		if ROTATION_ENABLED and aiming_at == null:
			$Laser.rotation_degrees += ROTATION_DIRECTION * ROTATION_VELOCITY * delta
	if ROUTE_ENABLED and ROUTE_POINTS.size() > 0:
		var actual_destiny = ROUTE_POINTS[route_destiny_index]
		if global_position.distance_to(actual_destiny) < 10:
			if route_destiny_index == ROUTE_POINTS.size() - 1: route_destiny_index = 0
			else: route_destiny_index += 1
		elif aiming_at == null: move_and_slide(global_position.direction_to(actual_destiny) * WALK_SPEED)

func _shoot():
	if $ShootCooldown.time_left > 0: return
	$ShootCooldown.start(SHOOT_COOLDOWN)
	var new_bullet = BULLET_NODE.instance()
	new_bullet.global_position = $Laser/BulletSpawnPoint.global_position
	new_bullet.rotation_degrees = $Laser.rotation_degrees + Globals._random_number(-5, 5)
	$AudioStreamPlayer2D.play()
	get_tree().root.add_child(new_bullet)
