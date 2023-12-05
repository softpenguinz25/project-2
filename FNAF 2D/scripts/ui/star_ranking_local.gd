extends Node

@export var star_outline : TextureRect
@export var star_full : TextureRect

var star_state_local = 0

func _ready():
	update_star_state()
	
func update_star_state():
	StarRankingManager.load_data()
	
	if star_state_local == StarRankingManager.star_state: return
	star_state_local = StarRankingManager.star_state
	
	match(star_state_local):
		0: 
			star_outline.visible = false
			star_full.visible = false
		1: 
			star_outline.visible = true
			star_full.visible = false
		2: 
			star_outline.visible = false
			star_full.visible = true
