extends Node

@export var camera : Camera2D

func change_camera_pos(pos_name : String):
	for child in get_children():
		if child.name == pos_name:
			camera.position = child.position
