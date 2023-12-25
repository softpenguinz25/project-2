extends Node
class_name BatteryTimer

@export var start_power : float = 100
@export var power_per_second : float = .15
var power : float
var usage = 1

var is_out_of_power : bool
signal usage_changed(int)
signal out_of_power

signal incremented_power(amount : int)

func _ready():
	power = start_power

func _physics_process(_delta):
	if is_out_of_power : return
	
	power -= power_per_second * usage * _delta
	
	if power <= 0:
		out_of_power.emit()
		is_out_of_power = true

func set_power(new_power : int):
	power = new_power

func increment_power(increment_value : int):
	set_power(int(power + increment_value))
	incremented_power.emit(increment_value)

func set_usage(new_usage : int):
	usage = new_usage
	usage_changed.emit(usage)

func increment_usage(increment_value : int):
	set_usage(usage + increment_value)
