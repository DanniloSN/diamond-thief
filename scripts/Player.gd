extends KinematicBody2D

export var WALK_SPEED = 200
export var WALK_SPEED_HOLDING = 125
export var CAST_SIZE = 50

var direction = Vector2.ZERO
var movement = Vector2.ZERO
var holding = null

func _ready():
	add_to_group(Globals.PLAYER_GROUP)
	_set_animation("idle")

func _process(delta):
	direction = Vector2.ZERO
	direction.y -= int(Input.is_action_pressed("ui_up"))
	direction.y += int(Input.is_action_pressed("ui_down"))
	direction.x -= int(Input.is_action_pressed("ui_left"))
	direction.x += int(Input.is_action_pressed("ui_right"))
	if Input.is_action_just_pressed("ui_select"): _grab()

func _physics_process(delta):
	var speed_aux = WALK_SPEED_HOLDING if holding != null else WALK_SPEED
	movement = direction.normalized() * speed_aux
	move_and_slide(movement)
	if direction != Vector2.ZERO:
		$GrabItem.set_cast_to(direction * CAST_SIZE)
		if holding == null: $Sprites.rotation = direction.angle()
	if holding != null: holding.move_and_slide(movement)

func _grab():
	if holding != null: holding = null
	else:
		$GrabItem.enabled = true
		yield(get_tree().create_timer(0.1), "timeout")
		holding = $GrabItem.get_collider()
		$GrabItem.enabled = false

func _set_animation(animation):
	if $Sprites.animation == animation: return
	$Sprites.play(animation)
