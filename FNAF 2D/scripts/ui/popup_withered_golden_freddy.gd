extends PopupAnimatronic
class_name WitheredGoldenFreddyPopup

var animatronic_roaming_counterpart : animatronic

@export var monitor_screen : MonitorScreen

var is_in_progress : bool

@export var jumpscare_increments : Array[Control]
var current_increment : int

@export var timer_jumpscare_increment : Timer
@export var timer_jumpscare_increment_start_time_over_ai : Curve

@export var pos_bound_topleft : Control
@export var pos_bound_bottomright : Control

signal increments_updated(increments_left : int)
signal popup_resolved

func _ready():
	super._ready()
	handle_gfx(false)
	handle_increment_gfx(jumpscare_increments[0], false)
	
	animatronic_roaming_counterpart = monitor_screen.animatronics_fnaf2.animatronic_dict[animatronic_name]

func _on_popup_on(popup_name : String):
	if is_in_progress: return
	
	if animatronic_name != popup_name: return
	
	handle_func()
	handle_gfx(true)

func handle_func():
	timer_jumpscare_increment.start()
	
	self.position = Vector2(randf_range(pos_bound_topleft.position.x, pos_bound_bottomright.position.x), randf_range(pos_bound_topleft.position.y, pos_bound_bottomright.position.y))
	
	is_in_progress = true

func _on_popup_off():
	timer_jumpscare_increment.stop()
	
	current_increment = 0
	
	handle_gfx(false)
	for jumpscare_increment in jumpscare_increments: handle_increment_gfx(jumpscare_increment, false)
	
	is_in_progress = false
	popup_resolved.emit()

func _on_timer_jumpscare_increment_timeout():
	if current_increment >= jumpscare_increments.size():
		monitor.emit_jumpscare(animatronic_name)
		return
	
	handle_increment_gfx(jumpscare_increments[current_increment], true)
	
	current_increment += 1
	
	increments_updated.emit(jumpscare_increments.size() - current_increment)
	
	#print_debug("golden freddy ai lvl: %s" % animatronic_roaming_counterpart.ai_level)
	timer_jumpscare_increment.wait_time = timer_jumpscare_increment_start_time_over_ai.sample((float)(animatronic_roaming_counterpart.ai_level) / animatronic_roaming_counterpart.max_ai_level)
	#print_debug("golden freddy wait time: %s" % timer_jumpscare_increment.wait_time)
	timer_jumpscare_increment.start()

func handle_gfx(gfx_state : bool):
	self.visible = gfx_state

func handle_increment_gfx(control : Control, gfx_state : bool):
	control.color = Color.RED if gfx_state else Color.BLACK
	
