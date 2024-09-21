extends Monitor

@export var black_eyes : Dictionary

var current_camera_scene : String
#dictionary of [string | camera_scenes : node, dictionary[animatronic_name : string | animatronic_eye : node]

var animatronic_pos : Dictionary

@export var monitor_screen : MonitorScreen
@export var monitor_scene : MonitorScene

func _ready():
	for animatronic_on_cam in monitor_scene.animatronics_on_camera:
		#print_debug(monitor_screen.animatronics_fnaf2.animatronic_dict.size())
		animatronic_pos[animatronic_on_cam] = monitor_screen.animatronics_fnaf2.animatronic_dict[animatronic_on_cam].current_pos
		#print_debug("(black_eyes) starting animatronic: %s at %s" % [animatronic_on_cam, animatronic_pos[animatronic_on_cam]])

func camera_scene_switched(camera_scene : String):
	if black_eyes.has(current_camera_scene): 
		get_node(black_eyes[current_camera_scene][0]).visible = false
	
	current_camera_scene = camera_scene
	
	if black_eyes.has(current_camera_scene): 
		get_node(black_eyes[current_camera_scene][0]).visible = true

func set_animatronic_stalled(_animatronic_name : String, _stalled : bool):
	if not black_eyes.has(animatronic_pos[_animatronic_name]): return
	
	#print_debug("%s is stalled [%s], affecting %s {%s}" % [_animatronic_name, _stalled, get_node(black_eyes[animatronic_pos[_animatronic_name]][1][_animatronic_name]).name, Time.get_ticks_msec() / 1000.0])
	
	if black_eyes[animatronic_pos[_animatronic_name]][1].has(_animatronic_name):
		get_node(black_eyes[animatronic_pos[_animatronic_name]][1][_animatronic_name]).visible = not _stalled

func animatronic_moved_from(_animatronic_name : String, _cam_name_from : String):
	if not black_eyes.has(_cam_name_from): return
	if not black_eyes[_cam_name_from][1].has(_animatronic_name): return
	
	#print_debug("%s moved from %s, disabling %s {%s}" % [_animatronic_name, _cam_name_from, get_node(black_eyes[_cam_name_from][1][_animatronic_name]).name, Time.get_ticks_msec() / 1000.0])
	get_node(black_eyes[_cam_name_from][1][_animatronic_name]).visible = false

func set_animatronic_pos(_animatronic_name : String, _cam_name : String, _num_times_been_to_cam : int = -1):
	animatronic_pos[_animatronic_name] = _cam_name
	
	if not black_eyes.has(_cam_name): return
	if not black_eyes[_cam_name][1].has(_animatronic_name): return
	
	#print_debug("%s moved to %s, enabling %s {%s}" % [_animatronic_name, _cam_name, get_node(black_eyes[_cam_name][1][_animatronic_name]).name, Time.get_ticks_msec() / 1000.0])
	get_node(black_eyes[_cam_name][1][_animatronic_name]).visible = true
