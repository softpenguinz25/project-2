extends Node2D
class_name animatronic_blackout_fnaf2_manager

#when animatronic has blackout queued...
#1. add them to list of animatronic_blackout
#2. if at index 0, call their blackout func
#3. remove animatronics from list who are done with blackout func

var blackouts_queued : Array[animatronic_blackout_fnaf2]

func append_blackout(blackout : animatronic_blackout_fnaf2):
	blackouts_queued.append(blackout)
	#print_debug("appending %s | %s queued {%s}" % [blackout, blackouts_queued.size(), Time.get_ticks_msec() / 1000.0])
	
	if blackout == blackouts_queued[0]: 
		blackout.trigger_blackout()

func erase_blackout(blackout : animatronic_blackout_fnaf2):
	blackouts_queued.erase(blackout)
	#print_debug("erasing %s | %s queued {%s}" % [blackout, blackouts_queued.size(), Time.get_ticks_msec() / 1000.0])
	
	if blackouts_queued.size() >= 1 and not blackout == blackouts_queued[0]: 
		blackouts_queued[0].trigger_blackout()
