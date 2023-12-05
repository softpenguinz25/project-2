extends Node
class_name Controls

signal active_state_set(active_state : bool)

func set_active_state(enabled : bool):
	active_state_set.emit(enabled)
