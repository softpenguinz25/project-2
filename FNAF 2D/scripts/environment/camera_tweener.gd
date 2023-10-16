extends Node

@export_category("References")
@export var camera : Camera2D

@export_category("Tweening")
@export var tween_speed : float = .2

var pos_tween : Tween

func set_camera_pos(pos_name : String):
	for child in get_children():
		if child.name == pos_name:
			tween_camera_pos(child.position)

func tween_camera_pos(new_pos : Vector2):
	pos_tween = create_tween()
	pos_tween.set_trans(Tween.TRANS_CIRC)
	pos_tween.tween_property(camera, "position", new_pos, tween_speed)
