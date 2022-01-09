extends Area2D

export var SPEED = 1000

func _physics_process(delta):
	global_position -= Vector2.LEFT.rotated(rotation) * SPEED * delta

func _on_Bullet_body_entered(body):
	print("Bullet ", name, " hit ", body.name)
	queue_free()
