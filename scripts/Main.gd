extends Node

func _ready():
	get_tree().change_scene("res://scenes/stages/Stage1.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"): get_tree().quit()
