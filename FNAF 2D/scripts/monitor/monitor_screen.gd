extends Monitor
class_name MonitorScreen

var is_focused : bool = false

signal monitor_focus
signal monitor_unfocus

var current_cam_scene : String

var active_state_permanent : bool = false

signal camera_scene_switched_no_params
signal camera_scene_switched
signal camera_scene_flash_set
signal camera_scene_flashed_on
signal camera_scene_flashed_off

@export var monitor_focus_button : Button

@export var monitor_scripts : Array[Monitor]

@export var nodes_to_set_active : Array[Node]
signal active_state_on
signal active_state_off

signal animatronic_moved_from_cam

signal animatronic_moved_out_of_camera_queue
signal animatronic_moved_in_camera_queue

@export var monitor_map : TextureRect
signal map_toggled(toggle_state : bool)
@export var exit_camera_button : Button
signal exit_camera_button_toggled(toggle_state : bool)

signal cheat_mode_on
signal cheat_mode_off

signal hall_light_state_set(state : bool)

signal popup_toggled(popup_name : String)

signal jumpscare(animatronic_name : String)

signal flash_disabled_set(is_disabled : bool)

@export var animatronics_fnaf2 : animatronics_fnaf2

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

func set_current_camera_flashed(camera_scene : String, flash_on : bool):
	camera_scene_flash_set.emit(camera_scene, flash_on)
	
	if flash_on: 
		camera_scene_flashed_on.emit()
	else: 
		camera_scene_flashed_off.emit()

func animatronic_moved_from(_animatronic_name : String, _cam_name_from : String):
	#print_debug("(ms) %s moved from %s {%s}" % [_animatronic_name, _cam_name_from, Time.get_ticks_msec() / 1000.0])
	
	animatronic_moved_from_cam.emit(_animatronic_name, _cam_name_from)
	if !is_focused: return
	if _cam_name_from == current_cam_scene: animatronic_moved_out_of_camera_queue.emit()
	
func animatronic_moved_to(_animatronic_name : String, _cam_name_to : String, _num_times_been_to_cam : int = -1):
	#print_debug("(ms) %s moved to %s {%s}" % [_animatronic_name, _cam_name_to, Time.get_ticks_msec() / 1000.0])
	for monitor_script in monitor_scripts:
		monitor_script.set_animatronic_pos(_animatronic_name, _cam_name_to, _num_times_been_to_cam)
	
	if !is_focused: return
	if _cam_name_to == current_cam_scene: animatronic_moved_in_camera_queue.emit()

func set_animatronic_stalled(_animatronic_name : String, _stalled : bool):
	for monitor_script in monitor_scripts:
		monitor_script.set_animatronic_stalled(_animatronic_name, _stalled)

func toggle_map():
	map_toggled.emit(!monitor_map.is_visible_in_tree())

func toggle_exit_cam_button():
	exit_camera_button_toggled.emit(!exit_camera_button.is_visible_in_tree())

func set_cheat_mode(use : bool):
	if use: cheat_mode_on.emit()
	else: cheat_mode_off.emit()

func set_hall_light_state(state : bool):
	hall_light_state_set.emit(state)

func toggle_popup(popup_name : String):
	popup_toggled.emit(popup_name)

func emit_jumpscare(animatronic_name : String):
	jumpscare.emit(animatronic_name)

func set_flash_disable(is_disabled : bool):
	flash_disabled_set.emit(is_disabled)
