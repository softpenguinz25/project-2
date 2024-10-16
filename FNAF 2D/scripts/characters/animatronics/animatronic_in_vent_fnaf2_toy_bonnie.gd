extends animatronic_in_vent_fnaf2

@export var animatronic_blackout : animatronic_blackout_fnaf2

func trigger_in_office(in_office : bool) -> void:
	super.trigger_in_office(in_office)#connecting signals dont work on overriden script, so gotta do this, i know its super messy but ¯\_(ツ)_/¯

func on_mask_timer_timeout():
	if not is_in_office : return #dont ask why this return clause is in this func and not the parent func, it just bugs when i do this ¯\_(ツ)_/¯
	
	#print_debug("%s mask_timer_timeout {%s}" % [animatronic_name, Time.get_ticks_msec() / 1000.0])
	trigger_in_office(false)
	animatronic_blackout.trigger_in_office_immediate(true)

#func trigger_in_office(in_office : bool) -> void:
	#super.trigger_in_office(in_office)
