extends Node

enum {NORMAL, CHEAT, TWENTYD, NORMAL_2, CHEAT_2, TWENTYD_2}

var star_normal : bool
var star_cheat : bool
var star_20d : bool

var star_normal_2 : bool
var star_cheat_2 : bool
var star_20d_2 : bool

@export_group("Saving")
var save_path = "user://star_state.save"

#func _ready():
	#pass

##sets star_state to param. star < 0 = sets all star
func earned_star(star_to_set : int, star_state : bool):
	if star_to_set >= 0: 
		match(star_to_set):
			NORMAL: star_normal = star_state
			CHEAT: star_cheat = star_state
			TWENTYD: star_20d = star_state
			
			NORMAL_2: star_normal_2 = star_state
			CHEAT_2: star_cheat_2 = star_state
			TWENTYD_2: star_20d_2 = star_state
	else:
		star_normal = star_state
		star_cheat = star_state
		star_20d = star_state
		
		star_normal_2 = star_state
		star_cheat_2 = star_state
		star_20d_2 = star_state
	
	save_data()

func save_data():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(star_normal)
	file.store_var(star_cheat)
	file.store_var(star_20d)
	
	file.store_var(star_normal_2)
	file.store_var(star_cheat_2)
	file.store_var(star_20d_2)

func load_data():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		
		#this code may be worse than yandere dev, but its october freaking 15th and i gotta get this sh*t done today SJLKHLHSAKJDLKH
		var star_normal = file.get_var(star_normal) 
		if star_normal != null: self.star_normal = star_normal
		
		var star_cheat = file.get_var(star_cheat)
		if star_cheat != null: self.star_cheat = star_cheat
			
		var star_20d = file.get_var(star_20d)
		if star_20d != null: self.star_20d = star_20d
		
		var star_normal_2 = file.get_var(star_normal_2) 
		if star_normal_2 != null: self.star_normal_2 = star_normal_2
			
		var star_cheat_2 = file.get_var(star_cheat_2)
		if star_cheat_2 != null: self.star_cheat_2 = star_cheat_2
			
		var star_20d_2 = file.get_var(star_20d_2)
		if star_20d_2 != null: self.star_20d_2 = star_20d_2
	else:
		print("no data saved...")
		star_normal = false
		star_cheat = false
		star_20d = false
		
		star_normal_2 = false
		star_cheat_2 = false
		star_20d_2 = false
