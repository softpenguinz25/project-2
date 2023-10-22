extends Node

func load_scene(next_scene : String):
	get_tree().change_scene_to_file(next_scene)
