extends Sprite2D

@export var animatronic_to_shock : animatronic_roaming

signal attempt_shock
signal shock_trigger

func shock() -> void:
	attempt_shock.emit()
	
	if animatronic_to_shock.current_cam_index >= 0: return#not in position to be shocked bc still in the cams
	
	shock_trigger.emit()
