extends Node

@export var night_id : int = 1

var in_jumpscare : bool

signal jumpscare_played
signal jumpscare_played_with_name(animatronic_name : String)
signal jumpscare_finished

@export var jumpscare_timer : Timer

@export var night_timer : Timer

func play_jumpscare(animatronic_name : String):
	if in_jumpscare: return
	
	jumpscare_played.emit()
	jumpscare_played_with_name.emit(animatronic_name)
	
	jumpscare_timer.start()
	
	in_jumpscare = true

func finish_jumpscare():
	if AiManager.use_20d_mode: BestTimeManager.set_time_in_s(night_timer.wait_time - night_timer.time_left, night_id)
	
	jumpscare_finished.emit()
