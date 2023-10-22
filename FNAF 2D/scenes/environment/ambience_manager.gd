extends Node

@export var total_variation_time : float = 45.0

func _ready():
	for ambience_timer in self.get_children():
		var timer : Timer = ambience_timer
		timer.wait_time = randf_range(timer.wait_time - total_variation_time / 2, timer.wait_time + total_variation_time / 2)
		timer.start()
