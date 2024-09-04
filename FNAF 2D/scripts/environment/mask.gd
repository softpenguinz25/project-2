extends Node2D
class_name player_mask

var is_on : bool

@export var mask_overlay_gfx : CanvasLayer

signal mask_state_changed(is_on)

func set_mask_state(on : bool):
	is_on = on
	
	handle_gfx(on)
	
	mask_state_changed.emit(on)

func handle_gfx(on : bool):
	mask_overlay_gfx.visible = on
