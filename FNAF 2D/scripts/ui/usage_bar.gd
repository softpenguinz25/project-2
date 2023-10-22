extends Label

@export var battery_timer : BatteryTimer

func set_usage_bars(num_bars : int):
	for child in get_children():
		child.visible = child.get_index() < num_bars
