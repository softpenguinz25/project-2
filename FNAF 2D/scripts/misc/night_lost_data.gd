extends Node

@export var game_id : int = 1

func _ready():
	#print_debug("i am %s in scene %s" % [name, get_tree().current_scene.name])
	if AiManager.use_20d_mode: BestTimeManager.set_time_in_ms(360960, game_id)#6:00.69 lol
