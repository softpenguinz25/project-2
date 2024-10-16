extends Node

@export_category("References")
@export var camera : Camera2D
@export var camera_parent : Node2D

@export var start_node : Node2D
var current_node

var camera_tween : Tween

var original_limit : Vector4
var original_position_smoothing_enabled : bool
var original_position_smoothing : float
var original_limit_smoothing_enabled : float

#var cam_target_pos_changed : bool
#var cam_pos_epsilon : float = .01
##signal camera_tween_finished
#signal cam_at_target_pos

func _ready():
	original_position = camera_parent.position
	original_limit = Vector4(camera.limit_left,camera.limit_top,camera.limit_right,camera.limit_bottom)
	original_position_smoothing_enabled = camera.position_smoothing_enabled
	original_position_smoothing = camera.position_smoothing_speed
	original_limit_smoothing_enabled = camera.limit_smoothed
	current_node = start_node

func set_camera_pos(node_name : String, tween_time : float):
	#print_debug("set camera pos: " + node_name + " | " + str(tween_time))
	for child in get_children():
		if child.name == node_name:
			var next_node : Node2D = child if child != current_node else start_node
			current_node = next_node
			tween_camera_pos(next_node.global_position, next_node.global_scale, tween_time)

func tween_camera_pos(new_pos : Vector2, new_zoom : Vector2, tween_time : float):
	camera_tween = create_tween().set_parallel(true)
	if not camera.position_smoothing_enabled:
		camera_tween.tween_property(camera, "global_position", new_pos, tween_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	else:
		#print_debug("new global pos: " + str(new_pos))
		#cam_target_pos_changed = true
		camera.global_position = new_pos
	if current_node != start_node:
		camera_tween.tween_property(camera, "zoom", new_zoom, tween_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)
	else:
		camera_tween.tween_property(camera, "zoom", new_zoom, tween_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	
	#await get_tree().create_timer(tween_time).timeout
	#camera_tween_finished.emit()

func set_camera_limit(limit : Vector4):
	camera.limit_left = limit.x
	camera.limit_top = limit.y
	camera.limit_right = limit.z
	camera.limit_bottom = limit.w

func reset_camera_limit():
	camera.limit_left = original_limit.x
	camera.limit_top = original_limit.y
	camera.limit_right = original_limit.z
	camera.limit_bottom = original_limit.w

func add_camera_limit(limit_add : Vector4):
	set_camera_limit(Vector4(
		camera.limit_left + limit_add.x,
		camera.limit_top + limit_add.y,
		camera.limit_right + limit_add.z,
		camera.limit_bottom + limit_add.w
	))

func reset_position_smoothing_enabled():
	camera.position_smoothing_enabled = original_position_smoothing_enabled

func set_position_smoothing_enabled(smoothing_enabled : bool):
	camera.position_smoothing_enabled = smoothing_enabled

func reset_position_smoothing():
	camera.position_smoothing_speed = original_position_smoothing

func set_position_smoothing(smoothing : float):
	camera.position_smoothing_speed = smoothing
	
func reset_limit_smoothing_enabled():
	camera.limit_smoothed = original_limit_smoothing_enabled

func set_limit_smoothing_enabled(smoothing_enabled : bool):
	camera.limit_smoothed = smoothing_enabled

func set_rtrans(rtrans_nodepath : NodePath, remote_path_is_cam : bool):
	var rtrans : RemoteTransform2D = (get_node(rtrans_nodepath) as RemoteTransform2D)
	#print_debug("Nodepath: " + str(rtrans_nodepath) + " | Node: " + str(rtrans))
	rtrans.remote_path = camera.get_path() if remote_path_is_cam else ""

#-SCREEN SHAKE-
var in_shake_state : bool
@export var shake_amplitude = 15.0
var shake_timer : float
var original_position = Vector2(0, 0)

func _process(delta):
	if shake_timer > 0.0:
		shake_timer -= delta
		var random_offset = Vector2(randf_range(-shake_amplitude, shake_amplitude), randf_range(-shake_amplitude, shake_amplitude))
		camera_parent.position = original_position + random_offset
	elif in_shake_state:
		camera_parent.position = original_position
		in_shake_state = false
	
	#if not cam_target_pos_changed:
		##print_debug("cam target_pos: " + str(camera.get_target_position()) + "cam screen_center_pos: " + str(camera.get_screen_center_position()) + "cam pos: " + str(camera.position))
		#if camera.get_screen_center_position().distance_to(camera.get_target_position()) <= cam_pos_epsilon:
			#print_debug("cam at target pos (" + str(camera.get_target_position()) + ")")
			#cam_at_target_pos.emit()
	#
	#cam_target_pos_changed = false

#func shake_screen():
#	original_position = camera.position
#
#	in_shake_state = true
#	shake_timer = shake_duration

func shake_screen(local_shake_duration : float):
	in_shake_state = true
	shake_timer = local_shake_duration
