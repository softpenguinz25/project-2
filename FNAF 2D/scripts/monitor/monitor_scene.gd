extends Monitor
class_name MonitorScene

@export var cam_scenes : Dictionary
@export var animatronics_on_camera : Dictionary
@export var flash_buttons_dictionary : Dictionary

signal cam_scene_switched(new_cam_scene : String)

var is_cam_scene_switched_first_time : bool = true
signal cam_scene_switched_first_time

func _ready():
	for animatronic_default_sprite in animatronics_on_camera.values():
		get_node(animatronic_default_sprite).visible = true

func switch_cam_scene(new_cam_scene : String):
	for cam_scene_key in cam_scenes: 
		get_node(cam_scenes[cam_scene_key][0]).click_cam_gfx(cam_scene_key == new_cam_scene)
		get_node(cam_scenes[cam_scene_key][1]).visible = cam_scene_key == new_cam_scene
	cam_scene_switched.emit(new_cam_scene)
	
	if is_cam_scene_switched_first_time:
		cam_scene_switched_first_time.emit()
		is_cam_scene_switched_first_time = false
	
func set_animatronic_pos(_animatronic_name : String, _cam_name : String, _num_times_been_to_cam : int = -1):
	if animatronics_on_camera.has(_animatronic_name):
		var old_animatronic_on_camera = animatronics_on_camera[_animatronic_name] if animatronics_on_camera[_animatronic_name] is Object else get_node(animatronics_on_camera[_animatronic_name])
		old_animatronic_on_camera.visible = false
	
	if _cam_name.is_empty(): return
	#print_debug("%s going to %s" % [_animatronic_name, _cam_name]) 
	var animatronic_on_camera = get_node(cam_scenes[_cam_name][2][_animatronic_name]) if _num_times_been_to_cam <= -1 else get_node(cam_scenes[_cam_name][2][_animatronic_name][_num_times_been_to_cam])
	animatronics_on_camera[_animatronic_name] = animatronic_on_camera
	
	if animatronic_on_camera != null: animatronic_on_camera.visible = true

func _on_flash_disabled_set(is_disabled : bool):
	for flash_button_key in flash_buttons_dictionary:
		self.get_node(flash_buttons_dictionary[flash_button_key]).disabled = is_disabled
