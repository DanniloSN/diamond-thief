extends Node

const PLAYER_GROUP = "PLAYER"
const ROBOT_GROUP = "ROBOT"
const DIAMOND_GROUP = "DIAMOND"

var current_stage_index = 0
var stages = [
	{ # 1
		"stage": "res://scenes/stages/Stage1.tscn",
		"message": "Automatic Security System.\nThis thing cannot allow the agent to steal the diamond"
	},
	{ # 2
		"stage": "res://scenes/stages/Stage2.tscn",
		"message": "If he could move, he would be more efficient"
	},
	{ # 3
		"stage": "res://scenes/stages/Stage3.tscn",
		"message": "A little better, but need one more unit"
	},
	{ # 4
		"stage": "res://scenes/stages/Stage4.tscn",
		"message": "Why did they shoot themselves?\nDisable the movement! And add more units!"
	},
	{ # 5
		"stage": "res://scenes/stages/Stage5.tscn",
		"message": "Don't let the him get the Diamond!"
	},
	{ # 6
		"stage": "res://scenes/stages/Stage6.tscn",
		"message": "That sensor won't do the job!\nWe gonna need another model"
	},
	{ # 8
		"stage": "res://scenes/stages/Stage8.tscn",
		"message": "I know what? Forget those things!"
	}
]

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"): _quit()
	if Input.is_action_just_pressed("previous_stage"): _change_stage(-1)
	if Input.is_action_just_pressed("next_stage"): _change_stage(1)

func _change_stage(direction = 1):
	if direction < 0 and current_stage_index == 0: return
	elif direction > 0 and current_stage_index == stages.size() - 1: _quit()
	if direction != 0: current_stage_index += direction
	return get_tree().change_scene("res://scenes/stages/SplashStage.tscn")

func _game_over():
	 _change_stage(0)

func _random_number(to: float, from = 0):
	return rand_range(from, to)

func _quit():
	get_tree().quit()
