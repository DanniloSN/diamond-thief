extends Area2D

export var LIFE_TIME = 1
export var GROW_VELOCITY = 30

signal enemy_found

func _physics_process(delta):
	scale += Vector2.ONE * GROW_VELOCITY * delta

func _on_LifeTimer_timeout():
	queue_free()

func _on_SensorWave_body_entered(body):
	if body.is_in_group(Globals.PLAYER_GROUP): emit_signal("enemy_found", body)
