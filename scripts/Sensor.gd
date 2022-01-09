extends KinematicBody2D

const WAVE_NODE = preload("res://scenes/SensorWave.tscn")

func _ready():
	_spawn_wave()

func _spawn_wave():
	var new_wave = WAVE_NODE.instance()
	new_wave.connect("enemy_found", self, "_enemy_found")
	add_child(new_wave)

func _enemy_found(body):
	$Robot.LASER_ENABLED = true
	$Robot.ROTATION_ENABLED = true
	$Robot._enable_laser()
