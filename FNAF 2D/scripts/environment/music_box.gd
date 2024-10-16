extends animatronic

#i know i can use godot timers, by i wrote this 2 months ago and im too lazy to fix the heinous monstrosity that is this code (mostly cuz of the lerp thing that is probably really easy to fix but aslkhjsdahjlksdfahjlk) ¯\_(ツ)_/¯

@export_subgroup("Music Box")
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

@export_subgroup("Jumpscare")
@export var jumpscare_timer : Timer
@export var jumpscare_time_per_sec_over_ai : Curve
@export var jumpscare_time_deviance : float = 5

signal music_box_ratio_remaining(ratio_remanining : float)
signal cranked
signal crank_sequence_started
signal crank_sequence_ended
signal jumpscare_timer_started
signal jumpscare(animatronic_name : String)

@export_subgroup("Debug")
@export var debug_decrease_speed : float = 5

func _ready():
	super._ready()
	music_box_target_time_in_sec = music_box_max_time_in_sec
	music_box_current_time_in_sec = music_box_target_time_in_sec

func set_ai_level(new_ai_level : int):
	super.set_ai_level(new_ai_level)
	decrease_per_sec = decrease_per_sec_over_ai.sample((float)(ai_level) / max_ai_level)
	#print_debug("new ai lvl: %s | decrease per sec: %s" % [new_ai_level, decrease_per_sec])

func _process(delta):
	if music_box_timed_out: 
		#print_debug("jumpscare")
		return
	
	music_box_target_time_in_sec -= delta * (decrease_per_sec if not debug_ai else debug_decrease_speed)
	
	if current_crank_delay_in_sec > 0:
		current_crank_delay_in_sec -= delta
	
	if current_music_box_state and current_crank_delay_in_sec <= 0:
		increase_music_box_time(crank_amount_in_sec)
		current_crank_delay_in_sec = crank_delay_in_sec
		
		cranked.emit()
		
	music_box_current_time_in_sec = lerp(music_box_current_time_in_sec, music_box_target_time_in_sec, music_box_current_time_easing)
	
	music_box_ratio_remaining.emit(music_box_current_time_in_sec / music_box_max_time_in_sec)
	
	if music_box_target_time_in_sec <= 0:
		music_box_timed_out = true
		
		jumpscare_timer.wait_time = jumpscare_time_per_sec_over_ai.sample((float)(ai_level) / max_ai_level) + randf_range(-jumpscare_time_deviance * .5, jumpscare_time_deviance * .5)
		jumpscare_timer.start()
		
		jumpscare_timer_started.emit()

func increase_music_box_time(amount_to_increase : float):
	music_box_target_time_in_sec = clamp(music_box_target_time_in_sec + amount_to_increase, 0, music_box_max_time_in_sec)

func toggle_music_box(state : bool):
	#current_crank_delay_in_sec = 0
	current_music_box_state = state
	
	if current_music_box_state: crank_sequence_started.emit()
	else: crank_sequence_ended.emit()

func emit_jumpscare():
	jumpscare.emit(animatronic_name)
