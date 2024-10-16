extends AudioStreamPlayer2D

@export var monitor_screen : MonitorScreen
@export var hall_name : String = "hall"

var num_animatronics_in_hall : int

var ambience_position : float

#account for foxy in hall
@export var withered_foxy_hall : animatronic_withered_foxy_hall

func _ready():
	monitor_screen.animatronic_moved_to_camera.connect(
		func(animatronic_name : String, cam_name : String):
			if cam_name == hall_name:
				num_animatronics_in_hall += 1
				#print_debug("{%s} %s | %s moved to %s" % [Time.get_ticks_msec() / 1000.0, num_animatronics_in_hall, animatronic_name, cam_name])
			
			if num_animatronics_in_hall == 1 and not playing:
				play(ambience_position)
	)
	
	monitor_screen.animatronic_moved_from_cam.connect(
		func(animatronic_name : String, cam_name : String):
			if cam_name == hall_name:
				num_animatronics_in_hall -= 1
				#print_debug("{%s} %s | %s moved from %s" % [Time.get_ticks_msec() / 1000.0, num_animatronics_in_hall, animatronic_name, cam_name])
			
			if num_animatronics_in_hall == 0 and not withered_foxy_hall.is_in_hall:
				ambience_position = get_playback_position() 
				stop()
	)
	
	withered_foxy_hall.hall_state_set.connect(
		func(is_in_hall : bool):
			if is_in_hall and not playing:
				play(ambience_position)
	)
