extends Node

@export var game_id : int = 1

var star_normal_local : bool
var star_cheat_local : bool
var star_20d_local : bool

@export var star_normal_gfx : TextureRect
@export var star_cheat_gfx : TextureRect
@export var star_20d_gfx : TextureRect

func _ready():
	#StarRankingManager.earned_star(-1, false)
	update_star_state()
	
func update_star_state():
	StarRankingManager.load_data()
	#print_debug("updating star_state")
	match game_id:
		1:
			star_normal_local = StarRankingManager.star_normal
			star_cheat_local = StarRankingManager.star_cheat
			star_20d_local = StarRankingManager.star_20d
		2:
			star_normal_local = StarRankingManager.star_normal_2
			star_cheat_local = StarRankingManager.star_cheat_2
			star_20d_local = StarRankingManager.star_20d_2
	
	star_normal_gfx.visible = star_normal_local
	star_cheat_gfx.visible = star_cheat_local
	star_20d_gfx.visible = star_20d_local
