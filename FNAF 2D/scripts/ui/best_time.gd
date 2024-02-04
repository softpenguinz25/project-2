extends Node

@export var best_time_in_s : float = 0
@export var last_time_in_s : float = 0

@export_group("Saving")
var save_path = "user://best_time.save"

##sets star_state to param
func set_time_in_s(new_time_in_s : float):
	if new_time_in_s >= 0:
		last_time_in_s = new_time_in_s
		if last_time_in_s > best_time_in_s: best_time_in_s = last_time_in_s
	else:
		best_time_in_s = 0
		last_time_in_s = 0
	
	save_data()

func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(best_time_in_s)
	file.store_var(last_time_in_s)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		best_time_in_s = file.get_var(best_time_in_s)
		last_time_in_s = file.get_var(last_time_in_s)
	else:
		print("no data saved...")
		best_time_in_s = 0
		last_time_in_s = 0
