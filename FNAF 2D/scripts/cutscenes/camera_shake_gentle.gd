extends Node2D

@export var noise : FastNoiseLite
@export var shake_speed = 5.0
@export var shake_amplitude = 2.0
var time_passed = 0.0
var in_box_pos
var current_offset = Vector2(0, 0)

func _ready():
	in_box_pos = position
	noise.set_seed(randi())

func _process(delta):
	time_passed += delta * shake_speed
#	var noise_input = time_passed * 2.0
#	var noise_value = Vector2(noise.get_noise_2d(noise_input, noise_input), noise.get_noise_2d(noise_input + noise.seed, noise_input + noise.seed))
#	var target_offset = Vector2(noise_value.x, noise_value.y) * shake_amplitude
#	current_offset = current_offset.lerp(target_offset, 0.1)
	
	current_offset = (Vector2(noise.get_noise_1d(time_passed), noise.get_noise_1d(time_passed + 69420)) * shake_amplitude)# - (Vector2(shake_amplitude, shake_amplitude) / 2)
	position = in_box_pos + current_offset
