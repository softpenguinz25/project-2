extends Node

@export_category("References")
@export var camera : Camera2D
@export var camera_parent : Node2D

@export var start_node : Node2D
var current_node

var camera_tween : Tween

var start_camera_limits : Vector4
var no_camera_limits : Vector4 = Vector4(-10000000,-10000000,10000000,10000000)

func _ready():
	original_position = camera_parent.position
	current_node = start_node
	start_camera_limits = Vector4(camera.limit_left,camera.limit_top,camera.limit_right,camera.limit_bottom)

func set_camera_pos(node_name : String, tween_time : float):
	for child in get_children():
		if child.name == node_name:
			var next_node : Node2D = child if child != current_node else start_node
			current_node = next_node
			tween_camera_pos(next_node.position, next_node.scale, tween_time)

func tween_camera_pos(new_pos : Vector2, new_zoom : Vector2, tween_time : float):
	camera_tween = create_tween().set_parallel(true)
	camera_tween.tween_property(camera, "position", new_pos, tween_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
	if current_node != start_node:
		camera_tween.tween_property(camera, "zoom", new_zoom, tween_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_LINEAR)
	else:
		camera_tween.tween_property(camera, "zoom", new_zoom, tween_time).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)

func set_camera_follow(node_path : String):
	print_debug("setting camera follow to: " + node_path)
	#camera.reparent(get_node(node_path))

func remove_camera_limits():
	camera.limit_left = no_camera_limits.x
	camera.limit_top = no_camera_limits.y
	camera.limit_right = no_camera_limits.z
	camera.limit_bottom = no_camera_limits.w

func reset_camera_limits():
	camera.limit_left = start_camera_limits.x
	camera.limit_top = start_camera_limits.y
	camera.limit_right = start_camera_limits.z
	camera.limit_bottom = start_camera_limits.w

#-SCREEN SHAKE-
var in_shake_state : bool
var shake_amplitude = 15.0
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

#func shake_screen():
#	original_position = camera.position
#
#	in_shake_state = true
#	shake_timer = shake_duration

func shake_screen(local_shake_duration : float):
	in_shake_state = true
	shake_timer = local_shake_duration
