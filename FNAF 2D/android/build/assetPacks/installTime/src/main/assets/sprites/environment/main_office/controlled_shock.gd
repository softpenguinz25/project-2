extends Sprite2D

@export var animatronic_to_shock : animatronic_roaming

signal attempt_shock
signal shock_trigger

signal button_enabled(enabled : bool)
signal button_disabled(disabled : bool)

var permanent : bool = false

func shock() -> void:
	attempt_shock.emit()
	
	if animatronic_to_shock.current_cam_index >= 0: return#not in position to be shocked bc still in the cams
	
	shock_trigger.emit()

func change_button_disabled_state(disabled : bool):
	if permanent: return
	
	button_enabled.emit(!disabled)
	button_disabled.emit(disabled)
	
func change_button_disabled_state_permanently(disabled : bool):
	change_button_disabled_state(disabled)
	permanent = true
