extends StaticBody2D

@export var animation_tree : AnimationTree

@export_category("Door")
var current_door_state : bool = true

@export_category("Light")
var current_light_state : bool = false

@export_category("Signals")
signal door_off(door_off_data)
signal door_on(door_on_data)
signal light_off(light_off_data)
signal light_on(light_on_data)

func switch_door_state():
	change_door_state(!current_door_state)

func change_door_state(new_door_state : bool):
	if current_door_state == new_door_state:
		return
	
	current_door_state = new_door_state
	
	animation_tree["parameters/conditions/trigger_close"] = !current_door_state
	animation_tree["parameters/conditions/trigger_open"] = current_door_state
	
	if current_door_state:
		door_on.emit()
	else:
		door_off.emit()

func switch_light_state():
	change_light_state(!current_light_state)

func change_light_state(new_light_state : bool):
	if current_light_state == new_light_state:
		return
	
	current_light_state = new_light_state
	
	if current_light_state:
		light_on.emit()
	else:
		light_off.emit()
