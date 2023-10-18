extends Monitor

@export var monitor_scene : Monitor
@export var animatronic_placeholder : Dictionary

func set_animatronic_pos(animatronic_name : String, cam_name : String):
	var placeholder_animatronic = get_node(animatronic_placeholder[animatronic_name])
	if(animatronic_name == "" or cam_name == ""):
		placeholder_animatronic.visible = false
		return
	
	placeholder_animatronic.visible = true
	
	super.set_animatronic_pos(animatronic_name, cam_name)
	placeholder_animatronic.position = get_node(monitor_scene.cam_scenes[cam_name][0]).position
	pass
