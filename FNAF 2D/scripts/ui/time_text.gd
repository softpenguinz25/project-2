extends Label

@export var night_timer : Timer
@export var format_text : String = "-%s AM-"

var old_hour_to_show
signal hour_changed(hour : int)

func _process(_delta):
	var hour_to_show = (((int)((night_timer.wait_time - night_timer.time_left) / (night_timer.wait_time / 6)) + 11) % 12) + 1
	$".".text = format_text % hour_to_show
	
	if hour_to_show != old_hour_to_show: hour_changed.emit(hour_to_show)
	
	old_hour_to_show = hour_to_show
