extends AnimationTree

@export var player_body : player_fnaf2
@onready var walking_speed : float = 0.1

var is_rolling_animation_played : bool

func _ready():
	self["parameters/conditions/is_rolling"] = false
	#self["parameters/conditions/not_is_rolling"] = true
	
	player_body.is_rolling.connect(func(): 
		self["parameters/conditions/is_rolling"] = true
		#self["parameters/conditions/not_is_rolling"] = false
		)
	player_body.not_is_rolling.connect(func(): 
		self["parameters/conditions/is_rolling"] = false
		is_rolling_animation_played = false
		#self["parameters/conditions/not_is_rolling"] = true
		)

func _process(_delta):
	var relative_player_speed : float = player_body.velocity.x / player_body.top_speed
	
	var is_moving : bool = absf(relative_player_speed) > walking_speed
	self["parameters/conditions/is_moving"] = is_moving
	self["parameters/conditions/not_is_moving"] = !is_moving
	
	if is_moving:
		#var blend_position : float = clampf(relative_player_speed, -1, 1)
		self["parameters/Idle/blend_position"] = relative_player_speed
		self["parameters/Walk/blend_position"] = relative_player_speed
		if not is_rolling_animation_played: self["parameters/Roll/blend_position"] = relative_player_speed
		#print_debug(self["parameters/Roll/blend_position"])
	
	#yes i know this rolling animation code is extremely bizarre and calls every frame which is bad, but life is hard man (っ◞‸◟c)
	if is_rolling_animation_played:
		self["parameters/conditions/is_rolling"] = false
	
	if self["parameters/conditions/is_rolling"]:
		is_rolling_animation_played = true
