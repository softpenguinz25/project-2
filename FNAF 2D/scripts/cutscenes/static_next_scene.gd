extends Node

@export var game_over_timer : Timer
@export var springtrap_timer : Timer
@export_range(0, 1) var springtrap_scene_probability : float = .1

func _ready():
	var rng = randf()
	if rng <= springtrap_scene_probability: springtrap_timer.start()
	else: game_over_timer.start()
