extends Node

@export var music_box_max_time_in_sec : float = 8
var music_box_target_time_in_sec : float
var music_box_current_time_in_sec : float
@export_range(0, 1) var music_box_current_time_easing : float = .2

var music_box_timed_out : bool

var current_music_box_state : bool

@export var crank_delay_in_sec : float = .5
var current_crank_delay_in_sec : float
@export var crank_amount_in_sec : float = .5

signal music_box_ratio_remaining(ratio_remanining : float)
signal music_box_time_out

func _ready():
	music_box_target_time_in_sec = music_box_max_time_in_sec
	music_box_current_time_in_sec = music_box_target_time_in_sec

func _process(delta):
	if music_box_timed_out: 
		print_debug("jumpscare")
		return
	
	music_box_target_time_in_sec -= delta
	
	if current_music_box_state:
		if current_crank_delay_in_sec <= 0:
			increase_music_box_time(crank_amount_in_sec)
			current_crank_delay_in_sec = crank_delay_in_sec
		else:
			current_crank_delay_in_sec -= delta
	
	music_box_current_time_in_sec = lerp(music_box_current_time_in_sec, music_box_target_time_in_sec, music_box_current_time_easing)
	
	music_box_ratio_remaining.emit(music_box_current_time_in_sec / music_box_max_time_in_sec)
	
	if music_box_target_time_in_sec <= 0:
		music_box_time_out.emit()
		music_box_timed_out = true

func increase_music_box_time(amount_to_increase : float):
	music_box_target_time_in_sec = clamp(music_box_target_time_in_sec + amount_to_increase, 0, music_box_max_time_in_sec)

func toggle_music_box(state : bool):
	current_crank_delay_in_sec = 0
	current_music_box_state = state
