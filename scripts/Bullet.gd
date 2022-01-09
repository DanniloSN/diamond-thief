extends Area2D

export var SPEED = 1500

var dead = false

func _physics_process(delta):
	global_position -= Vector2.LEFT.rotated(rotation) * SPEED * delta

func _on_Bullet_body_entered(body):
	if dead: return
	dead = true
	if body.is_in_group(Globals.PLAYER_GROUP): Globals._game_over()
	queue_free()

func _on_LifeTime_timeout():
	if dead: return
	dead = true
	queue_free()
