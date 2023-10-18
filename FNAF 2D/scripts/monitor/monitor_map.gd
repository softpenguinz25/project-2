extends Monitor

@export var monitor_scene : Monitor
@export var animatronic_placeholder : Dictionary

func set_animatronic_pos(_animatronic_name : String, _cam_name : String):
	var placeholder_animatronic = get_node(animatronic_placeholder[_animatronic_name])
	if(_animatronic_name == "" or _cam_name == ""):
		placeholder_animatronic.self_modulate = Color.RED
		return
	
	placeholder_animatronic.self_modulate = Color.WHITE
	var placeholder_animatronic_tween : Tween = create_tween()
	placeholder_animatronic_tween.tween_property(placeholder_animatronic, "position", get_node(monitor_scene.cam_scenes[_cam_name][0]).position + Vector2(randf_range(-20, 20), randf_range(-10, 10)), .33).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	pass
