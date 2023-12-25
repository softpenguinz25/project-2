extends Monitor
class_name MonitorScreen

var is_focused : bool = false

signal monitor_focus
signal monitor_unfocus

var current_cam_scene : String

var active_state_permanent : bool = false

signal camera_scene_switched_no_params
signal camera_scene_switched

@export var monitor_focus_button : Button

@export var monitor_scripts : Array[Monitor]

@export var nodes_to_set_active : Array[Node]
signal active_state_on
signal active_state_off

signal animatronic_moved_out_of_camera_queue
signal animatronic_moved_in_camera_queue

@export var monitor_map : TextureRect
signal map_toggled(toggle_state : bool)
@export var exit_camera_button : Button
signal exit_camera_button_toggled(toggle_state : bool)

func set_active_state(active_state : bool):
	if active_state_permanent: return
	
	if active_state: active_state_on.emit()
	else: active_state_off.emit()
#	for child in nodes_to_set_active:
#		child.set_process(active_state)
#		child.visible = active_state

func set_active_state_permanently(active_state : bool): 
	set_active_state(active_state)
	active_state_permanent = true

func set_monitor_focus(focus : bool):
	if focus == is_focused:
		return
		
	is_focused = focus
	
	monitor_focus_button.visible = !is_focused
	if is_focused:
		monitor_focus.emit()
	else:
		monitor_unfocus.emit()

func set_current_camera_scene(camera_scene : String): 
	camera_scene_switched_no_params.emit()
	if current_cam_scene == camera_scene: return
	
	current_cam_scene = camera_scene
	camera_scene_switched.emit(camera_scene)

func set_animatronic_pos(_animatronic_name : String, _cam_name : String, _num_times_been_to_cam : int = -1):
	#if _animatronic_name.is_empty() or _cam_name.is_empty(): return
	for monitor_script in monitor_scripts:
		monitor_script.set_animatronic_pos(_animatronic_name, _cam_name, _num_times_been_to_cam)

func animatronic_moved_from(_animatronic_name : String, _cam_name_from : String):
	if !is_focused: return
	if _cam_name_from == current_cam_scene: animatronic_moved_out_of_camera_queue.emit()
	
func animatronic_moved_to(_animatronic_name : String, _cam_name_to : String, _num_times_to_thing : int = -1):
	if !is_focused: return
	if _cam_name_to == current_cam_scene: animatronic_moved_in_camera_queue.emit()

func toggle_map():
	map_toggled.emit(!monitor_map.is_visible_in_tree())

func toggle_exit_cam_button():
	exit_camera_button_toggled.emit(!exit_camera_button.is_visible_in_tree())
