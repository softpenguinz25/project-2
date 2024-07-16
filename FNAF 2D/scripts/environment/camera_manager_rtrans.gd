extends Camera2D

@export_category("Camera Position")
var current_camera_rtrans : RemoteTransform2D
@export var default_camera_rtrans : RemoteTransform2D

@export_category("Camera Easing")
@export var default_zoom_ease : Tween.EaseType
@export var default_zoom_trans : Tween.TransitionType
@export var default_zoom_length : float = 1

func set_camera_rtrans(rtrans : RemoteTransform2D, smooth_camera : bool = true):
	position_smoothing_enabled = smooth_camera
	
	rtrans.remote_path = $".".get_path()
	
	if current_camera_rtrans != null: 
		current_camera_rtrans.update_position = false
		current_camera_rtrans.update_rotation = false
	
	rtrans.update_position = true
	rtrans.update_rotation = true
	
	if smooth_camera:
		var zoom_tween = create_tween().set_ease(default_zoom_ease).set_trans(default_zoom_trans)
		zoom_tween.tween_property(self, "zoom", rtrans.scale, default_zoom_length)
	else:
		zoom = rtrans.scale
	
	current_camera_rtrans = rtrans

func set_camera_rtrans_nodepath(node_path : NodePath):
	var rtrans : Node = get_node(node_path)
	if not rtrans is RemoteTransform2D:
		push_error("%s isn't of type %s!" % [rtrans, "RemoteTransform2D"])
		return
	set_camera_rtrans(rtrans)

func reset_camera_rtrans(rtrans : RemoteTransform2D = null):
	if rtrans != null: 
		default_camera_rtrans = rtrans
	
	set_camera_rtrans(default_camera_rtrans)

#-SCREEN SHAKE-
var in_shake_state : bool
var shake_amplitude = 15.0
var shake_timer : float
var original_position = Vector2(0, 0)

@export var camera_parent : Node2D

func _process(delta):
	if shake_timer > 0.0:
		shake_timer -= delta
		var random_offset = Vector2(randf_range(-shake_amplitude, shake_amplitude), randf_range(-shake_amplitude, shake_amplitude))
		camera_parent.position = original_position + random_offset
	elif in_shake_state:
		camera_parent.position = original_position
		in_shake_state = false

func shake_screen(local_shake_duration : float):
	in_shake_state = true
	shake_timer = local_shake_duration
