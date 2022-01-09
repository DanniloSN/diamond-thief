extends Node

const PLAYER_GROUP = "PLAYER"
const ROBOT_GROUP = "ROBOT"
const DIAMOND_GROUP = "DIAMOND"

signal GAME_OVER

var current_stage_index = 0
var stages = [
	{ # 1
		"stage": "res://scenes/stages/Stage1.tscn",
		"message": "Automatic Security System. Initial Test"
	},
	{ # 2
		"stage": "res://scenes/stages/Stage2.tscn",
		"message": "If he could move, he would be more efficient"
	},
	{ # 3
		"stage": "res://scenes/stages/Stage3.tscn",
		"message": "A little better, but need one more"
	},
	{ # 4
		"stage": "res://scenes/stages/Stage4.tscn",
		"message": "Why the hell did they shoot themselves? Disable the movement! And add more units!"
	},
	{ # 5
		"stage": "res://scenes/stages/Stage5.tscn",
		"message": "Don't let the him get the Diamond!"
	},
	{ # 6
		"stage": "res://scenes/stages/Stage5.tscn",
		"message": "You and your little crap robot are fired! We gonna need another model"
	}
]

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"): get_tree().quit()
	if Input.is_action_just_pressed("previous_stage"): _change_stage(-1)
	if Input.is_action_just_pressed("next_stage"): _change_stage(1)

func _change_stage(direction = 1):
	if direction < 0 and current_stage_index == 0: return
	elif direction > 0 and current_stage_index == stages.size() - 1: return
	else:
		current_stage_index += direction
		get_tree().change_scene("res://scenes/stages/SplashStage.tscn")

func _game_over():
	emit_signal("GAME_OVER")

func _random_number(to: float, from = 0):
	return rand_range(from, to)
