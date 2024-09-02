extends Monitor

@export var monitor_scene : Monitor
@export var animatronic_placeholder : Dictionary

func set_animatronic_pos(_animatronic_name : String, _cam_name : String, _num_times_been_to_cam : int = -1):
	var placeholder_animatronic = get_node(animatronic_placeholder[_animatronic_name])
	if(_animatronic_name == "" or _cam_name == ""):
		placeholder_animatronic.self_modulate = Color.RED
		return
	
	#print_debug("moving placeholder: %s to %s" % [placeholder_animatronic, _cam_name])
	#print_debug("monitor_scene (%s) has %s: %s" % [_cam_name, monitor_scene, monitor_scene.cam_scenes.has(_cam_name)])
	#print_debug("cam_box: %s | cam_box pos: %s" % [monitor_scene.cam_scenes[_cam_name][0], monitor_scene.cam_scenes[_cam_name][0].position])
	#print_debug("cam_box has pos: %s" % monitor_scene.cam_scenes[_cam_name][0].get("position"))
	#print_debug("cam_box path: %s | cam_box node: %s" % [monitor_scene.cam_scenes[_cam_name][0], monitor_scene.get_node(monitor_scene.cam_scenes[_cam_name][0])])
	placeholder_animatronic.self_modulate = Color.WHITE
	var placeholder_animatronic_tween : Tween = create_tween()
	
	placeholder_animatronic_tween.tween_property(placeholder_animatronic, "position", monitor_scene.get_node(monitor_scene.cam_scenes[_cam_name][0]).position + Vector2(randf_range(-20, 20), randf_range(-10, 10)), .33).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
	pass

func set_animatronic_stalled(_animatronic_name : String, _stalled : bool):
	var placeholder_animatronic = get_node(animatronic_placeholder[_animatronic_name])
	placeholder_animatronic.self_modulate = Color.DEEP_SKY_BLUE if _stalled else Color.WHITE
	pass
