extends Node2D

@export var camera : Camera2D

func _process(delta):
	global_position = camera.get_screen_center_position()
