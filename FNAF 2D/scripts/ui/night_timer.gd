extends Timer

@export var win_scene : StringName = "res://scenes/cutscenes/scene_night_win.tscn"

func night_won():
	#why tf did i not use scene_loader i am gud coder gamer :DDDddd
	get_tree().change_scene_to_file(win_scene)
