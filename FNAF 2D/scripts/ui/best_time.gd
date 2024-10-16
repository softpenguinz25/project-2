extends Node

@export var best_time_in_s : float = 0
@export var last_time_in_s : float = 0

@export var best_time_in_s_fnaf2 : float = 0
@export var last_time_in_s_fnaf2 : float = 0

@export_group("Saving")
var save_path = "user://best_time.save"

##sets star_state to param
func set_time_in_s(new_time_in_s : float, game_id : int = 1):
	if new_time_in_s < 0:
		best_time_in_s = 0
		last_time_in_s = 0
		
		best_time_in_s_fnaf2 = 0
		last_time_in_s_fnaf2 = 0
	else:
		match(game_id):
			1:
				last_time_in_s = new_time_in_s
				if last_time_in_s > best_time_in_s: best_time_in_s = last_time_in_s
			2:
				last_time_in_s_fnaf2 = new_time_in_s
				if last_time_in_s_fnaf2 > best_time_in_s_fnaf2: best_time_in_s_fnaf2 = last_time_in_s_fnaf2
	
	save_data()

func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(best_time_in_s)
	file.store_var(last_time_in_s)
	
	file.store_var(best_time_in_s_fnaf2)
	file.store_var(last_time_in_s_fnaf2)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		
		var best_time_in_s = file.get_var(best_time_in_s)
		if best_time_in_s != null: self.best_time_in_s = best_time_in_s
		
		var last_time_in_s = file.get_var(last_time_in_s)
		if last_time_in_s != null: self.last_time_in_s = last_time_in_s
		
		var best_time_in_s_fnaf2 = file.get_var(best_time_in_s_fnaf2)
		if best_time_in_s_fnaf2 != null: self.best_time_in_s_fnaf2 = best_time_in_s_fnaf2
		
		var last_time_in_s_fnaf2 = file.get_var(last_time_in_s_fnaf2)
		if last_time_in_s_fnaf2 != null: self.last_time_in_s_fnaf2 = last_time_in_s_fnaf2
	else:
		print("no data saved...")
		best_time_in_s = 0
		last_time_in_s = 0
		
		best_time_in_s_fnaf2 = 0
		last_time_in_s_fnaf2 = 0
