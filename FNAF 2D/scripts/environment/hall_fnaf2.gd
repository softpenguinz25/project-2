extends Node

#this is potentially psycotically slow but i have no clue or willpower to make this any cleaner so ¯\_(ツ)_/¯
@export var animatronics : animatronics_fnaf2
var animatronics_in_hall : Dictionary

@export var hall_cam_names : Array[String] = ["hall", "hall_2"]

func is_animatronic_in_hall(animatronic : animatronic_roaming_fnaf2) -> bool:
	for hall_cam_name in hall_cam_names:
		if animatronic.current_pos == hall_cam_name:
			return true
	
	return false

func hall_light_flashed():
	for animatronic in animatronics.animatronic_roaming_array:
		if is_animatronic_in_hall(animatronic):
			#print_debug("%s can be stalled: %s" % [animatronic.animatronic_name, animatronic.can_pause_animatronic])
			animatronic.pause_animatronic(true)
