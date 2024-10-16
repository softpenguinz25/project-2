extends Node

func play_sound(sound_path : String):
	AudioManager.play_sound(sound_path)

func stop_sound(sound_path : String):
	AudioManager.stop_sound(sound_path)

func stop_all_sounds(): 
	AudioManager.stop_all_sounds()
