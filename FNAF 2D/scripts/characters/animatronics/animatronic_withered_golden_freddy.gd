extends animatronic

@export var monitor : MonitorScreen

@export var timer_popup : Timer
@export var timer_popup_start_time_over_ai : Curve
@export var timer_popup_start_time_deviation : float
var timer_popup_wait_time : float:
	get: return timer_popup_start_time_over_ai.sample((float)(ai_level) / max_ai_level) + randf_range(-timer_popup_start_time_deviation / 2, timer_popup_start_time_deviation / 2) if ai_level > 0 else INF

@export var monitor_screen : MonitorScreen
var popup : WitheredGoldenFreddyPopup

signal trigger_popup
signal popup_cleared

var is_in_grace_period : bool = true

func set_ai_level(new_ai_level : int): 
	#var timer_popup_wait_time_old = timer_popup_wait_time
	#super.set_ai_level(new_ai_level)
	#var timer_popup_time_left : float = timer_popup_wait_time_old - timer_popup_wait_time
	#print_debug("popup wait time: %s to %s | time_left: %s" % [timer_popup_wait_time_old, timer_popup_wait_time, timer_popup_time_left])
	#if timer_popup_time_left <= 0: _on_timer_popup_timeout
	#else: timer_popup.start(timer_popup_time_left)
	
	super.set_ai_level(new_ai_level)
	
	#print_debug(timer_popup_wait_time)
	
	timer_popup.wait_time = timer_popup_wait_time
	timer_popup.start()
	#print_debug("ai lvl: %s | popup wait time: %s" % [ai_level, timer_popup.wait_time])
	
	#grace period solution is super hacky but yolo
	if ai_opportunity_passed() and not is_in_grace_period:
		_on_timer_popup_timeout()

func _ready():
	super._ready()
	#print_debug(timer_popup_wait_time)
	start_popup_timer()
	
	popup = monitor_screen.popups.get_node(monitor_screen.popups.popup_dict[animatronic_name])
	popup.popup_resolved.connect(func(): popup_cleared.emit())

func start_popup_timer():
	timer_popup.wait_time = timer_popup_wait_time
	timer_popup.start()
	#print_debug("ai lvl: %s | popup wait time: %s" % [ai_level, timer_popup.wait_time])

func _on_timer_popup_timeout():
	if popup.is_in_progress: return
	
	monitor.toggle_popup(animatronic_name)
	trigger_popup.emit()
	
	start_popup_timer()

func set_grace_period(value : bool):
	is_in_grace_period = value
