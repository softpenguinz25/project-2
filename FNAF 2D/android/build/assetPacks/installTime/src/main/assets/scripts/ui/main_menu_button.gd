extends Button

func set_use_20d_mode(use : bool):
	AiManager.use_20d_mode = use
	
func set_use_cheat_mode(use : bool):
	AiManager.use_cheat_mode = use

func quit_game():
	get_tree().quit()
