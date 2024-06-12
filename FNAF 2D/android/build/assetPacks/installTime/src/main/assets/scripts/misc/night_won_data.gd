extends Node

func _ready():
	var star_state_earned : int
	star_state_earned = 1 if AiManager.use_cheat_mode else 2 if AiManager.use_20d_mode else 0
	StarRankingManager.earned_star(star_state_earned, true)
	
	if AiManager.use_20d_mode: BestTimeManager.set_time_in_s(360.70)#6:00.69 lol
