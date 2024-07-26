extends Node2D

@export var mask_overlay_gfx : CanvasLayer

func set_mask_state(on : bool):
	mask_overlay_gfx.visible = on
