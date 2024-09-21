extends animatronic

@export var monitor : MonitorScreen

@export var timer_popup : Timer
@export var timer_popup_start_time_over_ai : Curve
@export var timer_popup_start_time_deviation : float
var timer_popup_wait_time : float:
	get: return timer_popup_start_time_over_ai.sample(ai_level / max_ai_level) + randf_range(-timer_popup_start_time_deviation / 2, timer_popup_start_time_deviation / 2) if ai_level > 0 else INF

func set_ai_level(new_ai_level : int): 
	var timer_popup_wait_time_old = timer_popup_wait_time
	super.set_ai_level(new_ai_level)
	var timer_popup_time_left : float = timer_popup_wait_time_old - timer_popup_wait_time
	
	if timer_popup_time_left <= 0: _on_timer_popup_timeout
	else: timer_popup.start(timer_popup_time_left)

func _ready():
	super._ready()
	start_popup_timer()

func start_popup_timer():
	timer_popup.wait_time = timer_popup_wait_time
	timer_popup.start()

func _on_timer_popup_timeout():
	monitor.toggle_popup(animatronic_name)
	start_popup_timer()
