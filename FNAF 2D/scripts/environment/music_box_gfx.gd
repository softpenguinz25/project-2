extends RemoteTransform2D

var music_box_ratio_remaining : float = 1

@export_range(0, 1) var music_box_ratio_remaining_property:
	get:
		return music_box_ratio_remaining
	set(ratio_remaining):
		music_box_ratio_remaining = ratio_remaining
		position = lerp(out_box_pos, in_box_pos, music_box_ratio_remaining)
		
		if ambience_audio_player != null: 
			ambience_audio_player.volume_db = linear_to_db(1 - music_box_ratio_remaining) #linear_to_db(lerp(ambience_volume_range.x, ambience_volume_range.y, 1 - music_box_ratio_remaining))

@export var in_box_pos : Vector2
@export var out_box_pos : Vector2

func set_music_box_ratio_remaining(ratio_remaining : float):
	music_box_ratio_remaining_property = ratio_remaining

@export var ambience_audio_player : AudioStreamPlayer2D
