extends Timer

var win_scene : StringName = "res://scenes/cutscenes/scene_night_win.tscn"

func night_won():
	get_tree().change_scene_to_file(win_scene)
