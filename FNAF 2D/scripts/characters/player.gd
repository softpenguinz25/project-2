extends CharacterBody2D

var can_move : bool = true

@export_category("Movement")
var last_move_dir : int
@onready var top_speed : float = 600
@onready var acceleration : float = 3600
@onready var acceleration_turn_around_multiplier : float = 2.5

@export_category("GFX")
@export var player_footsteps : String = "res://sounds/player/player_footsteps.wav"
@export var muffled_player_footsteps : String = "res://sounds/player/player_footsteps_muffled.wav"
var player_footsteps_to_play : String = player_footsteps

var emited_is_moving_signal : bool
signal is_moving
signal not_is_moving
signal set_active
signal not_set_active

func set_active_state(active_state : bool):
	can_move = active_state
	visible = active_state
	
	if active_state: 
		emited_is_moving_signal = false
		set_active.emit(player_footsteps_to_play)
	else: not_set_active.emit(player_footsteps_to_play)

func _process(_delta):
	if not can_move: return
	
	move_player(_delta)
	
	move_and_slide()

func move_player(_delta) -> void:
	var move_dir : int = int(Input.get_axis("move_left", "move_right"))
	if absf(move_dir) > 0:
		var acceleration_to_use : float = acceleration if signf(velocity.x) == move_dir else acceleration * acceleration_turn_around_multiplier
		velocity.x += move_dir * acceleration_to_use * _delta
		last_move_dir = move_dir
		
		if not emited_is_moving_signal:
			is_moving.emit(player_footsteps_to_play)
			emited_is_moving_signal = true
	elif signf(velocity.x) == last_move_dir:
		velocity.x += -signf(velocity.x) * acceleration * _delta
	else:
		velocity.x = 0
		
		if emited_is_moving_signal:
			not_is_moving.emit(player_footsteps_to_play)
			emited_is_moving_signal = false
		
	velocity.x = clampf(velocity.x, -top_speed, top_speed)

func interact_with_interactables(area_2d : Area2D, interact_state : bool) -> void:
	if !area_2d.is_in_group("interactable"): return
	
	var interactable_node : interactable = area_2d.get_parent()
	interactable_node.set_interact_state(interact_state)

func muffle_footstep_sfx(): player_footsteps_to_play = muffled_player_footsteps

func set_interact_area_scale(new_scale : Vector2):
	$interact_area.scale = new_scale
