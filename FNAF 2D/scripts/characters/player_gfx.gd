extends AnimationTree

@export var player_body : CharacterBody2D
@onready var walking_speed : float = 0.1

func _process(_delta):
	var relative_player_speed : float = player_body.velocity.x / player_body.top_speed
	
	var is_moving : bool = absf(relative_player_speed) > walking_speed
	self["parameters/conditions/is_moving"] = is_moving
	self["parameters/conditions/not_is_moving"] = !is_moving
	
	if is_moving:
		self["parameters/Idle/blend_position"] = relative_player_speed
		self["parameters/Walk/blend_position"] = relative_player_speed
