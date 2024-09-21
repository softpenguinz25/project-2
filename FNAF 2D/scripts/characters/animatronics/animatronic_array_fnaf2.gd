extends Node
class_name animatronics_fnaf2

var animatronic_array : Array[animatronic_roaming_fnaf2]
var animatronic_dict : Dictionary

#signal animatronics_set

func _ready():
	for child in get_children():
		if child is animatronic_roaming_fnaf2:
			animatronic_array.append(child)
			animatronic_dict[child.animatronic_name] = child
	
	#animatronics_set.emit()

func set_current_monitor_cam(monitor_cam : String, cam_is_flashed : bool):
	for a in animatronic_array: a.set_current_monitor_cam(monitor_cam, cam_is_flashed)
