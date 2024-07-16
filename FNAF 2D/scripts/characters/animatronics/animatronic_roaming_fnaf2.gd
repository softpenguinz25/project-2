extends animatronic
class_name animatronic_roaming_fnaf2

var can_move : bool = true

var ai_level_property : float:
	get:
		return ai_level
#		return float(ai_level) if not current_pos == current_monitor_cam else ai_level * looking_at_animatronic_move_probability_multiplier

@export var movement_timer : Timer
@export var min_move_time : float = 4.75
@export var max_move_time : float = 5.25
@export var cam_path : Array[Array]
var cam_path_num : int
var current_cam_index : int
var current_cam_index_property:
	get:
		return current_cam_index
	set(value):
		animatronic_moved_from.emit(animatronic_name, cam_path[cam_path_num][current_cam_index_property] if current_cam_index_property >= 0 else "")
		current_cam_index = value
		var cam_name : String = cam_path[cam_path_num][current_cam_index_property] if current_cam_index_property >= 0 else ""
		#print("animatronic: " + name + " moved to " + cam_name + "(cam index: " + str(current_cam_index) + ")")
		animatronic_moved.emit(animatronic_name, cam_name, -1 if animatronic_name != "foxy" else current_cam_index_property)
		animatronic_in_office.set_office_appearance_state(current_cam_index_property < 0) #-1 means at yo door
		if current_cam_index_property < 0 and not is_in_office: 
			if (monitor_screen == null or not monitor_screen.is_focused): 
				in_office_cue.emit()
				in_office_cue_played = true
			is_in_office = true
		elif is_in_office:
			out_office.emit()
			is_in_office = false
			in_office_cue_played = false
			in_office_cue_flashed_played = false

var current_pos:
	get:
		return cam_path[cam_path_num][current_cam_index_property]

@export_range(0, 1) var move_backward_probability : float = .25

@export var animatronic_in_office : animatronic_in_office_fnaf2

@export var early_camera_nums : int = 2##first X cameras in camera path that animatronic can go to after being reset from door

signal animatronic_moved(animatronic_name : String, cam_name : String)
signal animatronic_moved_from(animatronic_name : String, cam_name_from : String)

signal animatronic_stalled(animatronic_name : String, is_stalled : bool)

var is_in_office : bool
signal in_office_cue
@export var in_office_cue_played : bool
@export var in_office_cue_flashed_played : bool
signal in_office_flashed
signal out_office

#var current_monitor_cam : String = "no camera has been set yet, also subscribe to jujuprodgames"
#@export var looking_at_animatronic_move_probability_multiplier : float = .5
var can_pause_animatronic : bool = true
@export var pause_animatronic_timer : Timer
@export var pause_animatronic_timer_cooldown : Timer

signal animatronic_jumpscare(animatronic_name : String)

@export var monitor_screen : MonitorScreen
@export_range(0, 1) var movement_cue_probability : float = .05
signal movement_cue

func set_ai_level(new_ai_level : int): super(new_ai_level)

func _ready():
	super()
	print_debug("fnaf 2 ready")
	cam_path_num = randi_range(0, cam_path.size() - 1)

func movement_opportunity() -> void:
	print_debug("fnaf 2 movement opp at ai lvl: " + str(ai_level_property))
	print_debug("ai_level at hr 12: " + str(ai_level_by_hour[12]))
	movement_timer.wait_time = randf_range(min_move_time, max_move_time)
	if randi_range(1, max_ai_level) <= ai_level_property and can_move:
		move()

func move() -> void:
	print_debug("fnaf 2 move")
	
	if animatronic_in_office.is_in_office:
		attack_opportunity()
		return
	
	var move_forward : bool = randf() > move_backward_probability
	if move_forward:
		current_cam_index_property += 1 if current_cam_index_property < cam_path[cam_path_num].size() - 1 else -current_cam_index_property - 1
		if randf() <= movement_cue_probability: movement_cue.emit() 
	else:
		current_cam_index_property -= 1 if current_cam_index_property > 0 else 0

func attack_opportunity() -> void:
	#if not wearing mask
		animatronic_jumpscare.emit(animatronic_name)
	#else:
		#reset_pos()

func reset_pos() -> void:
	cam_path_num = randi_range(0, cam_path.size() - 1)
	current_cam_index_property = randi_range(0, early_camera_nums - 1)

func set_current_motitor_cam(monitor_cam : String):
	if monitor_cam == current_pos and can_pause_animatronic:
		pause_animatronic(true)
		pause_animatronic_timer.start()
		
		can_pause_animatronic = false
		pause_animatronic_timer_cooldown.start()

func pause_animatronic(do_pause : bool):
	movement_timer.paused = do_pause
	animatronic_stalled.emit(animatronic_name, do_pause)

func set_can_pause(can_pause : bool):
	can_pause_animatronic = can_pause

func attempt_flash():
#	if is_in_office and not in_office_cue_played:
	if is_in_office and not in_office_cue_flashed_played:
		in_office_flashed.emit()
		in_office_cue_flashed_played = true
