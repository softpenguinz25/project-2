#script by PhonoForest - https://www.phonoforest.com/2020/05/7-second-tutorial-smooth-flickering.html

extends PointLight2D

@export var light_to_flicker : Light2D
@export var noise : FastNoiseLite
var value = 0.0
const MAX_VALUE = 100000000

var start_energy
@export var total_energy_range : float = 2

func _ready():
	randomize()
	value = randi() % MAX_VALUE
	
	start_energy = light_to_flicker.energy

func _physics_process(_delta):
	value += .5
	if value > MAX_VALUE: value = 0.0
	
	var random_noise_value = (noise.get_noise_1d(value))
	
	light_to_flicker.energy = start_energy + total_energy_range * random_noise_value
