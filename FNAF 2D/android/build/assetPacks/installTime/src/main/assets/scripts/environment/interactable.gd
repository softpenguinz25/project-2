extends Node
class_name interactable

var is_interacting : bool
var is_disabled : bool

signal changed_interact_state(interact_state : bool)
signal changed_enabled_state(disabled_state : bool)

func set_interact_state(interact_state : bool):
	is_interacting = interact_state
	changed_interact_state.emit(is_interacting)

func set_button_disabled_state(state : bool):
	is_disabled = state
	changed_enabled_state.emit(!is_disabled)
