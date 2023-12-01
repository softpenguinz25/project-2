extends Node

@onready var audio_players = $audio_players
var sound_paths_per_player : Dictionary

func play_sound(sound_path : String):
	if sound_path.is_empty(): return
	
	for audio_stream_player in audio_players.get_children():
		if not audio_stream_player.playing:
			var sound_file = load(sound_path)
			audio_stream_player.stream = sound_file
			audio_stream_player.play()
			
			sound_paths_per_player[sound_path] = [audio_stream_player, sound_file]
			break

func stop_sound(sound_path : String):
	if not sound_paths_per_player.has(sound_path): return
	
	var sound_player_to_stop : AudioStreamPlayer = sound_paths_per_player[sound_path][0]
	
	if not sound_player_to_stop.playing or sound_player_to_stop.stream != sound_paths_per_player[sound_path][1]: return 
	
	sound_player_to_stop.stop()

func stop_all_sounds():
	for audio_stream_player in audio_players.get_children():
		var sound_player_to_stop : AudioStreamPlayer = audio_stream_player
		sound_player_to_stop.stop()
