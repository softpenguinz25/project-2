@tool
extends TextureRect

@export_multiline var cam_name : String = "CAM\n1A" :
	set(new_cam_name):
		cam_name = new_cam_name
		$cam_box_label.text = cam_name

@export var default_cam_color : Color = Color.html("#424242")
@export var selected_cam_color : Color = Color.html("#C3DE00")

signal cam_clicked

func click_cam():
	cam_clicked.emit()

func click_cam_gfx(is_selected : bool):
	$cam_box_bg.self_modulate = default_cam_color if !is_selected else selected_cam_color
