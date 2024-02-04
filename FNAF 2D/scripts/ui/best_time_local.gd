extends Node

@export var best_time_label : Label
@export var last_time_label : Label
@export var best_time_string_format : String = "Time: %d:%02d:%02d"

var best_time_in_s_local : float = 0
var last_time_in_s_local : float = 0

func _ready():
	update_best_time()
	
func update_best_time():
	BestTimeManager.load_data()
	
	if best_time_in_s_local != BestTimeManager.best_time_in_s: best_time_in_s_local = BestTimeManager.best_time_in_s
	if last_time_in_s_local != BestTimeManager.last_time_in_s: last_time_in_s_local = BestTimeManager.last_time_in_s
	
	best_time_label.text = "Best " + get_time_string(best_time_in_s_local)
	last_time_label.text = "Last " + get_time_string(last_time_in_s_local)

func get_time_string(time_in_s : float) -> String:
	var mils : float = fmod(time_in_s, 1) * 100
	var secs : float = fmod(time_in_s, 60)
	var mins : float = fmod(time_in_s, 60 * 60) / 60
	
	var time_string = best_time_string_format % [mins, secs, mils]
	return time_string
	
