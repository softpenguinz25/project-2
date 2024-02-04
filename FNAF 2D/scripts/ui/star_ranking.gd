extends Node

enum {NORMAL, CHEAT, TWENTYD}

var star_normal : bool
var star_cheat : bool
var star_20d : bool

@export_group("Saving")
var save_path = "user://star_state.save"

##sets star_state to param. star < 0 = sets all star
func earned_star(star_to_set : int, star_state : bool):
	if star_to_set >= 0: 
		match(star_to_set):
			NORMAL: star_normal = star_state
			CHEAT: star_cheat = star_state
			TWENTYD: star_20d = star_state
	else:
		star_normal = star_state
		star_cheat = star_state
		star_20d = star_state
	
	save_data()

func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(star_normal)
	file.store_var(star_cheat)
	file.store_var(star_20d)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		
		star_normal = file.get_var(star_normal)
		star_cheat = file.get_var(star_cheat)
		star_20d = file.get_var(star_20d)
	else:
		print("no data saved...")
		star_normal = false
		star_cheat = false
		star_20d = false
