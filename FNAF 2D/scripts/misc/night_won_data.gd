extends Node

@export var game_id : int = 1

func _ready():
	var star_state_earned : int
	#10-15-24: i know this code is really hecking bad but thats a problem for future me ¯\_(ツ)_/¯
	match game_id:
		1:
			star_state_earned = 1 if AiManager.use_cheat_mode else 2 if AiManager.use_20d_mode else 0
		2:
			star_state_earned = 4 if AiManager.use_cheat_mode else 5 if AiManager.use_20d_mode else 3
	StarRankingManager.earned_star(star_state_earned, true)
	
	if AiManager.use_20d_mode: BestTimeManager.set_time_in_s(360.70, game_id)#6:00.69 lol
