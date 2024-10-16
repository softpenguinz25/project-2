extends Node
class_name animatronics_fnaf2

var animatronic_array : Array[animatronic]
var animatronic_roaming_array : Array[animatronic_roaming_fnaf2]
var animatronic_dict : Dictionary

@export var other_animatronics_parent_array : Array[Node]

#signal animatronics_set
signal using_20d_mode
signal using_cheat_mode

func _ready():
	for child in get_children():
		if child is animatronic:
			animatronic_array.append(child)
			if child is animatronic_roaming_fnaf2: animatronic_roaming_array.append(child)
			animatronic_dict[child.animatronic_name] = child
	#animatronics_set.emit()
	
	#for animatronic_to_set in animatronics_to_set:
		#var animatronic_script : animatronic = animatronic_to_set
		#animatronic_script.use_ai_level_by_hour = not (AiManager.use_20d_mode or AiManager.use_cheat_mode)
	if AiManager.use_20d_mode: 
		set_all_animatronics_ai_level(20)
		using_20d_mode.emit()
	if AiManager.use_cheat_mode: 
		set_all_animatronics_ai_level(20)
		using_cheat_mode.emit()

func set_current_monitor_cam(monitor_cam : String, cam_is_flashed : bool):
	for a in animatronic_roaming_array: 
		a.set_current_monitor_cam(monitor_cam, cam_is_flashed)

func set_all_animatronics_ai_level(ai_level : int):
	for animatronic in animatronic_array:
		animatronic.use_ai_level_by_hour = not (AiManager.use_20d_mode or AiManager.use_cheat_mode)
		animatronic.set_ai_level(ai_level)
	
	for other_animatronics_parent in other_animatronics_parent_array:
		if other_animatronics_parent is animatronic: 
			other_animatronics_parent.use_ai_level_by_hour = not (AiManager.use_20d_mode or AiManager.use_cheat_mode)
			other_animatronics_parent.set_ai_level(ai_level)
		else:
			for animatronic in other_animatronics_parent.get_children():
				animatronic.use_ai_level_by_hour = not (AiManager.use_20d_mode or AiManager.use_cheat_mode)
				animatronic.set_ai_level(ai_level)

func set_all_animatronics_ai_level_by_hour(hour : int):
	for animatronic in animatronic_array:
		animatronic.set_ai_level_by_hour(hour)
	
	for other_animatronics_parent in other_animatronics_parent_array:
		if other_animatronics_parent is animatronic: other_animatronics_parent.set_ai_level_by_hour(hour)
		else:
			for animatronic in other_animatronics_parent.get_children():
				animatronic.set_ai_level_by_hour(hour)
