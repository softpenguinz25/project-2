extends Node

var animatronic_array : Array[animatronic_roaming_fnaf2]

func _ready():
	for child in get_children():
		if child is animatronic_roaming_fnaf2:
			animatronic_array.append(child)

func set_current_monitor_cam(monitor_cam : String, cam_is_flashed : bool):
	for a in animatronic_array: a.set_current_monitor_cam(monitor_cam, cam_is_flashed)
