extends Node

@export var battery_manager : FlashlightBattery

@export var battery_indicators : Array[CanvasItem]

var ratio_increment : float
var current_ratio : float
var num_indicators_remaining : int

func _ready():
	battery_manager.battery_ratio_set.connect(_on_battery_ratio_set)
	
	ratio_increment = 1.0 / battery_indicators.size()
	current_ratio = ratio_increment * (battery_indicators.size() - 1)
	num_indicators_remaining = battery_indicators.size()

func _on_battery_ratio_set(battery_ratio : float):
	if battery_ratio < 0:
		return
		
	while battery_ratio <= current_ratio:
		num_indicators_remaining -= 1
		battery_indicators[num_indicators_remaining].visible = false
		current_ratio -= ratio_increment
