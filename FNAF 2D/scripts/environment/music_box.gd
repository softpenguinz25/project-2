extends animatronic

#i know i can use godot timers, by i wrote this 2 months ago and im too lazy to fix the heinous monstrosity that is this code (mostly cuz of the lerp thing that is probably really easy to fix but aslkhjsdahjlksdfahjlk) ¯\_(ツ)_/¯

@export var music_box_max_time_in_sec : float = 10
var music_box_target_time_in_sec : float
var music_box_current_time_in_sec : float
@export_range(0, 1) var music_box_current_time_easing : float = .2

@export var decrease_per_sec_over_ai : Curve
var decrease_per_sec : float

var music_box_timed_out : bool

var current_music_box_state : bool

@export var crank_delay_in_sec : float = .5
var current_crank_delay_in_sec : float
@export var crank_amount_in_sec : float = .5

signal music_box_ratio_remaining(ratio_remanining : float)
signal jumpscare(animatronic_name : String)

func _ready():
	super._ready()
	music_box_target_time_in_sec = music_box_max_time_in_sec
	music_box_current_time_in_sec = music_box_target_time_in_sec

func set_ai_level(new_ai_level : int):
	super.set_ai_level(new_ai_level)
	decrease_per_sec = decrease_per_sec_over_ai.sample(ai_level / max_ai_level)

func _process(delta):
	if music_box_timed_out: 
		#print_debug("jumpscare")
		return
	
	
	music_box_target_time_in_sec -= delta * decrease_per_sec
	
	if current_crank_delay_in_sec > 0:
		current_crank_delay_in_sec -= delta
	
	if current_music_box_state and current_crank_delay_in_sec <= 0:
		increase_music_box_time(crank_amount_in_sec)
		current_crank_delay_in_sec = crank_delay_in_sec
	
	music_box_current_time_in_sec = lerp(music_box_current_time_in_sec, music_box_target_time_in_sec, music_box_current_time_easing)
	
	music_box_ratio_remaining.emit(music_box_current_time_in_sec / music_box_max_time_in_sec)
	
	if music_box_target_time_in_sec <= 0:
		jumpscare.emit(animatronic_name)
		music_box_timed_out = true

func increase_music_box_time(amount_to_increase : float):
	music_box_target_time_in_sec = clamp(music_box_target_time_in_sec + amount_to_increase, 0, music_box_max_time_in_sec)

func toggle_music_box(state : bool):
	#current_crank_delay_in_sec = 0
	current_music_box_state = state
