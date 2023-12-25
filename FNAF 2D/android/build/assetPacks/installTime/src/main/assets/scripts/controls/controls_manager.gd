extends Node

signal mobile_controls_toggled(toggle_state : bool)
@export var show_mobile_controls : bool = true

signal map_toggled

func _ready():
	mobile_controls_toggled.emit(show_mobile_controls)

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

func _process(_delta):
	if !OS.has_feature("editor"): return
	if Input.is_action_just_pressed("toggle_map"):
		map_toggled.emit()
