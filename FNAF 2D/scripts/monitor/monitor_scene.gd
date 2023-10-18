extends Monitor

@export var cam_scenes : Dictionary

func switch_cam_scene(new_cam_scene : String):
	for cam_scene_key in cam_scenes: 
		get_node(cam_scenes[cam_scene_key][0]).click_cam_gfx(cam_scene_key == new_cam_scene)
		get_node(cam_scenes[cam_scene_key][1]).visible = cam_scene_key == new_cam_scene

func set_animatronic_pos(_animatronic_name : String, _cam_name : String):
	pass
