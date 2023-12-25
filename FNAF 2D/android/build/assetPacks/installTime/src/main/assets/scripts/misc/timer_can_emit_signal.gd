extends Timer

@export var can_emit_signal : bool = true

signal timeout_passed_condition

func try_emit_signal():
	if can_emit_signal: 
		timeout_passed_condition.emit()

func set_can_emit_signal(can_emit_state : bool): can_emit_signal = can_emit_state
