extends KinematicBody2D

const BULLET_NODE = preload("res://scenes/Bullet.tscn")

export var LASER_ENABLED = false
export var ROTATION_ENABLED = false

export var LASER_LENGTH = 200
export var ROTATION_VELOCITY = 120
export var ROTATION_DIRECTION = 1
export var SHOOT_COOLDOWN = .15

func _ready():
	add_to_group(Globals.ROBOT_GROUP)
	if LASER_ENABLED: $Laser.enabled = true

func _draw():
	if LASER_ENABLED:
		draw_line(Vector2.ZERO, Vector2(LASER_LENGTH, 0).rotated($Laser.rotation), Color(255, 0, 0), 1)

func _physics_process(delta):
	if LASER_ENABLED:
		update()
		var collider = $Laser.get_collider()
		if collider != null and not collider.is_in_group(Globals.PLAYER_GROUP):
			collider = null
		if collider != null:
			$Laser.look_at(collider.global_position)
			_shoot()
		if ROTATION_ENABLED and collider == null:
			$Laser.rotation_degrees += ROTATION_DIRECTION * ROTATION_VELOCITY * delta

func _shoot():
	if $ShootCooldown.time_left > 0: return
	$ShootCooldown.start(SHOOT_COOLDOWN)
	var new_bullet = BULLET_NODE.instance()
	new_bullet.global_position = $Laser/BulletSpawnPoint.global_position
	new_bullet.rotation_degrees = $Laser.rotation_degrees + Globals._random_number(-5, 5)
	get_parent().add_child(new_bullet)
