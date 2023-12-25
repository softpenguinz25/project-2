extends Node

@export var mobile_controls : Node

func _ready():
	pass

func move_player(move_dir : int):
	if move_dir < 0:
		Input.action_press("move_left")
	elif move_dir > 0:
		Input.action_press("move_right")

func stop_player(move_dir : int):
	if move_dir < 0:
		Input.action_release("move_left")
	elif move_dir > 0:
		Input.action_release("move_right")
