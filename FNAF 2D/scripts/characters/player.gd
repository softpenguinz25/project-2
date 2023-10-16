extends CharacterBody2D

var last_move_dir : int
@onready var top_speed : float = 600
@onready var acceleration : float = 3600
@onready var acceleration_turn_around_multiplier : float = 2.5

func _process(_delta):
	var move_dir : int = Input.get_axis("move_left", "move_right")
	if absf(move_dir) > 0:
		var acceleration_to_use : float = acceleration if signf(velocity.x) == move_dir else acceleration * acceleration_turn_around_multiplier
		velocity.x += move_dir * acceleration_to_use * _delta
		last_move_dir = move_dir
	elif signf(velocity.x) == last_move_dir:
		velocity.x += -signf(velocity.x) * acceleration * _delta
	else:
		velocity.x = 0
		
	velocity.x = clampf(velocity.x, -top_speed, top_speed)
	move_and_slide()
