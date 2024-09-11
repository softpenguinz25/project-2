extends Node

var is_player_in_mask_old : bool

@export var player : player_fnaf2

@export_subgroup("Functionality")
@export var node_left : Node2D
@export var node_right : Node2D

@export_subgroup("GFX")
var mask_overlay_color_tween : Tween
@export var mask_overlay : CanvasItem
@export var mask_overlay_enabled_color : Color = Color(1,1,1,.5)
@export var mask_overlay_color_tween_duration : float = .3

func _ready():
	is_player_in_mask_old = is_player_in_mask(player)
	
	mask_overlay.visible = true
	mask_overlay.self_modulate = Color.TRANSPARENT

func _process(delta):
	var is_player_in_mask : bool = is_player_in_mask(player)
	if not is_player_in_mask_old == is_player_in_mask:
		handle_func(is_player_in_mask)
		handle_gfx(is_player_in_mask)
		
		is_player_in_mask_old = is_player_in_mask

func is_player_in_mask(player : Node2D) -> bool:
	return player.global_position.x >= node_left.global_position.x and player.global_position.x <= node_right.global_position.x 

func handle_func(player_in_mask : bool):
	player.set_mask_state(player_in_mask)

func handle_gfx(player_in_mask : bool):
	if not mask_overlay_color_tween == null: mask_overlay_color_tween.kill()
	
	mask_overlay_color_tween = create_tween()
	mask_overlay_color_tween.tween_property(mask_overlay, "self_modulate", Color.TRANSPARENT if not player_in_mask else mask_overlay_enabled_color, mask_overlay_color_tween_duration)
