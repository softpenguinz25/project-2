extends TextureRect

#var in_shake_state : bool
@export var shake_amplitude := 20.0
#var shake_speed := 10.0
#var time_passed : float
#var shake_timer : float
var original_position := Vector2(0, 0)
#var noise = FastNoiseLite.new()

func _ready():
	original_position = position
#	noise.set_noise_type(noise.TYPE_PERLIN)

func _process(_delta):
#	time_passed += _delta
	
	var random_offset = Vector2(randf_range(-shake_amplitude, shake_amplitude), randf_range(-shake_amplitude, shake_amplitude))
	position = original_position + random_offset

#func shake_screen(shake_duration : float):
#	original_position = position
#
#	in_shake_state = true
#	shake_timer = shake_duration
