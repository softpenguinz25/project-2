extends Node
class_name interactable

var is_interacting : bool

signal changed_interact_state(interact_state : bool)

func set_interact_state(interact_state : bool):
	is_interacting = interact_state
	changed_interact_state.emit(is_interacting)
