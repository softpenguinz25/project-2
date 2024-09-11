extends Node2D
class_name player_mask

var is_on : bool
var can_take_off : bool = true

@export var mask_overlay_gfx : Node2D #prototype 1 was a canvas layer

signal mask_state_changed(is_on)

@export var mask_exit_button : Button

func set_mask_state(on : bool):
	if not on and not can_take_off: return
	
	is_on = on
	
	handle_gfx(on)
	
	mask_state_changed.emit(on)

func set_can_take_off(can_take_off : bool):
	self.can_take_off = can_take_off
	
	mask_exit_button.disabled = not can_take_off

func handle_gfx(on : bool):
	mask_overlay_gfx.visible = on
