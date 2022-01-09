extends Node

const PLAYER_GROUP = "PLAYER"
const ROBOT_GROUP = "ROBOT"
const DIAMOND_GROUP = "DIAMOND"

signal GAME_OVER

func _game_over():
	emit_signal("GAME_OVER")

func _random_number(to: float, from = 0):
	return rand_range(from, to)
