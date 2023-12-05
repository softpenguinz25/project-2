extends Node

@export var mobile_controls : Controls

func _ready():
	if OS.is_debug_build(): return
	mobile_controls.set_active_state(OS.has_feature("mobile"))

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
