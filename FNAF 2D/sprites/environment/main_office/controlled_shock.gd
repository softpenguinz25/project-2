extends Sprite2D

@export var animatronic_to_shock : animatronic_roaming

signal shock_trigger()

func shock() -> void:
	shock_trigger.emit()
