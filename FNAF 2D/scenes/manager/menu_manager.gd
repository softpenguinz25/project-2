extends Node

var current_menu_index : int

@export_subgroup("Saving")
@export var save_path : String = "user://menu_state.save"

func set_current_menu_index(index : int):
	current_menu_index = index
	save_data()

func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(current_menu_index)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		
		var current_menu_index = file.get_var(current_menu_index)
		if current_menu_index != null: self.current_menu_index = current_menu_index
	else:
		print("no data saved...")
		current_menu_index = 0
