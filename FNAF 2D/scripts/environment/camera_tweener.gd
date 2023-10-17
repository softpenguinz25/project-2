extends Node

@export_category("References")
@export var camera : Camera2D

@export var start_node : Node2D
var current_node

var camera_tween : Tween

func _ready():
	current_node = start_node

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
