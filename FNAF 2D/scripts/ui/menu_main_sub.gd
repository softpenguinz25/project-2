extends Control
class_name MenuMainSub

signal active_state_set(state : bool)
signal active_state_set_true
signal active_state_set_false

func set_active_state(state : bool):
	visible = state
	
	active_state_set.emit(state)
	if state: active_state_set_true.emit()
	else: active_state_set_false.emit()
