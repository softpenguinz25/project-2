extends animatronic
class_name animatronic_roaming_fnaf2

var can_move : bool = true

var ai_level_property : float:
	get:
		return ai_level

@export var movement_timer : Timer
@export var min_move_time : float = 4.75
@export var max_move_time : float = 5.25
@export var cam_path : Array[Array]
var cam_path_num : int
var current_cam_index : int
var current_cam_index_property:##-1 = not on camera
	get:
		return current_cam_index
	set(value):
		var cam_name : String = cam_path[cam_path_num][current_cam_index_property] if current_cam_index_property >= 0 else ""
		animatronic_moved_from.emit(animatronic_name, cam_name)
		
		current_cam_index = value
		cam_name = cam_path[cam_path_num][current_cam_index_property] if current_cam_index_property >= 0 else ""
		
		animatronic_moved.emit(animatronic_name, cam_name)
		
		if current_cam_index_property < 0:
			animatronic_path_ran_out.emit()

var current_pos:
	get:
		return cam_path[cam_path_num][current_cam_index_property]

@export_range(0, 1) var move_backward_probability : float = .25

@export var early_camera_nums : int = 1##first X cameras in camera path that animatronic can go to after being reset from door

signal animatronic_moved(animatronic_name : String, cam_name : String)
signal animatronic_moved_from(animatronic_name : String, cam_name_from : String)

signal animatronic_stalled(animatronic_name : String, is_stalled : bool)

signal animatronic_path_ran_out

var current_monitor_cam : String = "no camera has been set yet, also subscribe to jujuprodgames"
@export var looking_at_animatronic_move_probability_multiplier : float = .5
var can_pause_animatronic : bool = true
@export var pause_animatronic_timer : Timer
@export var pause_animatronic_timer_cooldown : Timer

@export var monitor_screen : MonitorScreen
@export_range(0, 1) var movement_cue_probability : float = .05
signal movement_cue

func set_ai_level(new_ai_level : int): super(new_ai_level)

func _ready():
	super()
	cam_path_num = randi_range(0, cam_path.size() - 1)

func movement_opportunity() -> void:
	regenerate_movement_timer()
	if randi_range(1, max_ai_level) <= ai_level_property and can_move:
		move()

func regenerate_movement_timer() -> void:
	movement_timer.wait_time = randf_range(min_move_time, max_move_time)

func move() -> void:
	var move_forward : bool = randf() > move_backward_probability
	
	if move_forward: current_cam_index_property += 1 if current_cam_index_property < cam_path[cam_path_num].size() - 1 else -current_cam_index_property - 1
	else: current_cam_index_property -= 1 if current_cam_index_property > 0 else 0
	
	if randf() <= movement_cue_probability: movement_cue.emit() 

func reset_pos() -> void:
	current_cam_index_property = randi_range(0, early_camera_nums - 1)
	cam_path_num = randi_range(0, cam_path.size() - 1)

func set_current_monitor_cam(monitor_cam : String, cam_is_flashed : bool):
	if cam_is_flashed and monitor_cam == current_pos and can_pause_animatronic:
		pause_animatronic(true)

func pause_animatronic(do_pause : bool):
	movement_timer.paused = do_pause
	animatronic_stalled.emit(animatronic_name, do_pause)
	
	if not do_pause: return
	
	pause_animatronic_timer.start()
	
	set_can_pause(false)
	pause_animatronic_timer_cooldown.start()

func set_can_pause(can_pause : bool):
	can_pause_animatronic = can_pause

func set_can_move(can_move : bool):
	self.can_move = can_move
	
	movement_timer.paused = not can_move
	if not can_move:
		regenerate_movement_timer()
