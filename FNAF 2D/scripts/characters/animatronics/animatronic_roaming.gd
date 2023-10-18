extends animatronic
class_name animatronic_roaming

var can_move : bool = true

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
		current_cam_index = value
		var cam_name : String = cam_path[cam_path_num][current_cam_index_property] if current_cam_index_property >= 0 else ""
		animatronic_moved.emit(animatronic_name, cam_name)
		animatronic_in_office.set_office_appearance_state(current_cam_index_property < 0) #-1 means at yo door

var current_pos:
	get:
		return cam_path[cam_path_num][current_cam_index_property]

@export_range(0, 1) var move_backward_probability : float = .25

@export var animatronic_in_office : animatronic_in_office

@export var early_camera_nums : int = 2##first X cameras in camera path that animatronic can go to after being reset from door

@export var door_obstacle : door

signal animatronic_moved(animatronic_name : String, cam_name : String)

func _ready():
	cam_path_num = randi_range(0, cam_path.size() - 1)

func movement_opportunity() -> void:
	movement_timer.wait_time = randf_range(min_move_time, max_move_time)
	if randi_range(1, max_ai_level) <= ai_level and can_move:
		move()

func move() -> void:
	if animatronic_in_office.is_in_office:
		attack_opportunity()
		return
	
	var move_forward : bool = randf() > move_backward_probability
	if move_forward:
		current_cam_index_property += 1 if current_cam_index_property < cam_path[cam_path_num].size() - 1 else -current_cam_index_property - 1
	else:
		current_cam_index_property -= 1 if current_cam_index_property > 0 else 0

func attack_opportunity() -> void:
	if door_obstacle == null or !door_obstacle.current_door_state:
		pass
		#print(animatronic_name + " JUMPSCARE!")
	else:
		reset_pos()

func reset_pos() -> void:
	cam_path_num = randi_range(0, cam_path.size() - 1)
	current_cam_index_property = randi_range(0, early_camera_nums - 1)
