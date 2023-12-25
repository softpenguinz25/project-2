extends Node

func _ready():
	var star_state_earned : int
	star_state_earned = 2 if AiManager.use_20d_mode else 1
	StarRankingManager.earned_star(star_state_earned)
