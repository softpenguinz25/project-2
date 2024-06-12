extends Node

var star_normal_local : bool
var star_cheat_local : bool
var star_20d_local : bool

@export var star_normal_gfx : TextureRect
@export var star_cheat_gfx : TextureRect
@export var star_20d_gfx : TextureRect

func _ready():
	update_star_state()
	
func update_star_state():
	StarRankingManager.load_data()
	
	star_normal_local = StarRankingManager.star_normal
	star_cheat_local = StarRankingManager.star_cheat
	star_20d_local = StarRankingManager.star_20d
	
	star_normal_gfx.visible = star_normal_local
	star_cheat_gfx.visible = star_cheat_local
	star_20d_gfx.visible = star_20d_local
