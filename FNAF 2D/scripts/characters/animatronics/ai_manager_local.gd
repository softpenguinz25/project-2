extends Node2D

@export var animatronics_to_set : Array[animatronic]

signal using_20d_mode

func _ready():
	for animatronic_to_set in animatronics_to_set:
		var animatronic_script : animatronic = animatronic_to_set
		animatronic_script.use_ai_level_by_hour = not AiManager.use_20d_mode
		if AiManager.use_20d_mode: 
			animatronic_script.set_ai_level(20)
			using_20d_mode.emit()
