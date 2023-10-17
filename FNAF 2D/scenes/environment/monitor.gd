extends Sprite2D

var is_focused : bool = false

signal monitor_focus
signal monitor_unfocus

@export var monitor_focus_button : Button

func set_monitor_focus(focus : bool):
	if focus == is_focused:
		return
		
	is_focused = focus
	
	monitor_focus_button.visible = !is_focused
	if is_focused:
		monitor_focus.emit()
	else:
		monitor_unfocus.emit()
