extends Node

func _ready():
	$Label.text = Globals.stages[Globals.current_stage_index].message

func _on_StartButton_pressed():
	get_tree().change_scene(Globals.stages[Globals.current_stage_index].stage)
