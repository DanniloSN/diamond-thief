extends Area2D

func _ready():
	pass

func _on_StageStart_body_entered(body):
	if body.is_in_group(Globals.DIAMOND_GROUP) or \
		body.is_in_group(Globals.PLAYER_GROUP) and \
		body.holding != null and\
		body.holding.is_in_group(Globals.DIAMOND_GROUP):
			Globals._change_stage(1)
