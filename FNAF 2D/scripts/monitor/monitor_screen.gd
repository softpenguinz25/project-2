extends Monitor

var is_focused : bool = false

signal monitor_focus
signal monitor_unfocus

@export var monitor_focus_button : Button

@export var monitor_scripts : Array[Monitor]

func set_monitor_focus(focus : bool):
	if focus == is_focused:
		return
		
	is_focused = focus
	
	monitor_focus_button.visible = !is_focused
	if is_focused:
		monitor_focus.emit()
	else:
		monitor_unfocus.emit()

func set_animatronic_pos(_animatronic_name : String, _cam_name : String):
	for monitor_script in monitor_scripts:
		monitor_script.set_animatronic_pos(_animatronic_name, _cam_name)
