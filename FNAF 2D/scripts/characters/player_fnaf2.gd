extends CharacterBody2D
class_name player_fnaf2

var can_move : bool = true

@export_subgroup("Run")
var last_move_dir : int
@onready var top_speed : float = 600
@onready var acceleration : float = 3600
@onready var acceleration_turn_around_multiplier : float = 2.5

@export_subgroup("Jump")
@export var gravity_in_px : float = 64
@export var jump_velocity = 1000

@export_subgroup("Roll")
var in_roll : bool = false
@export var roll_time : float = 1
@export var roll_speed_curve : Curve
var current_roll_multiplier_time : float = 0
@export var roll_cooldown_time : float = 1.5
var current_roll_cooldown_time : float = 0
var is_roll_cooling_down : bool = false
@export var roll_speed_epsilon : float = 100
@export var roll_idle_initial_speed : float = 100

@export_subgroup("Mask")
var is_wearing_mask : bool
@export var mask_gfx : Node2D
var can_take_off : bool = true

@export_subgroup("Interact")
@export var interact_area : Area2D

@export_subgroup("GFX")
@export var player_footsteps : String = "res://sounds/player/player_footsteps.wav"
@export var muffled_player_footsteps : String = "res://sounds/player/player_footsteps_muffled.wav"
var player_footsteps_to_play : String = player_footsteps

var emited_is_moving_signal : bool
signal is_moving
signal not_is_moving
signal is_rolling
signal not_is_rolling
signal set_active
signal not_set_active

signal mask_state_changed(is_wearing_mask : bool)
signal not_mask_state_changed(not_is_wearing_mask : bool)
signal mask_on
signal mask_off

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
	get_velocity_x(_delta)
	
	get_velocity_y(_delta)

func get_velocity_x(_delta : float) -> void:
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
	
	if Input.is_action_pressed("roll") and not is_roll_cooling_down:
		in_roll = true
		is_rolling.emit()
		
		current_roll_multiplier_time = 0
		
		current_roll_cooldown_time = roll_cooldown_time
		is_roll_cooling_down = true
		
		if velocity.x == 0 or velocity.x <= roll_speed_epsilon:
			velocity.x = last_move_dir * roll_idle_initial_speed
	
	if in_roll:
		current_roll_multiplier_time += _delta / roll_time
		velocity.x *= roll_speed_curve.sample(current_roll_multiplier_time)
		#print("vel x mult: " + str(roll_speed_curve.sample(current_roll_multiplier_time)))
		
		if current_roll_multiplier_time >= 1:
			in_roll = false
			not_is_rolling.emit()
	
	if is_roll_cooling_down:
		current_roll_cooldown_time -= _delta
		if current_roll_cooldown_time <= 0:
			is_roll_cooling_down = false
	

func get_velocity_y(_delta : float) -> void:
	if not is_on_floor():
		velocity.y += gravity_in_px
	else:
		if Input.is_action_pressed("jump"):
			velocity.y = -jump_velocity

func interact_with_interactables(area_2d : Area2D, interact_state : bool) -> void:
	if !area_2d.is_in_group("interactable"): return
	
	var interactable_node : interactable = area_2d.get_parent()
	interactable_node.set_interact_state(interact_state)
	#$interact_area.scale = new_scale

func set_mask_state(mask_state : bool):
	if not mask_state and not can_take_off: return
	
	is_wearing_mask = mask_state
	#mask_gfx.visible = mask_state
	mask_state_changed.emit(mask_state)
	not_mask_state_changed.emit(not mask_state)
	if mask_state: mask_on.emit()
	else: mask_off.emit()

func set_can_take_off(can_take_off : bool):
	self.can_take_off = can_take_off

func set_interact_area_scale(new_scale : Vector2):
	interact_area.scale = new_scale
