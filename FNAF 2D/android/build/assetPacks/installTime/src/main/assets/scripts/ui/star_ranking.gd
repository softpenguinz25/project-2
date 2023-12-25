extends Node

##0 = no star, 1 = outline star, 2 = glowing star
@export var star_state : int = 0

@export_group("Saving")
var save_path = "user://star_state.save"

##sets star_state to param
func earned_star(new_star_state : int):
	star_state = new_star_state
	save_data()

func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(star_state)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		star_state = file.get_var(star_state)
	else:
		print("no data saved...")
		star_state = 0
