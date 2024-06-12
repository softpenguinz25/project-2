extends Node

signal scene_switched

func load_scene(next_scene : String):
	scene_switched.emit()
	get_tree().change_scene_to_file(next_scene)
