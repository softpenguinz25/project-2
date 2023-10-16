extends StaticBody2D

var current_door_state : bool = true
@export var animation_tree : AnimationTree

func switch_door_state():
	change_door_state(!current_door_state)

func change_door_state(new_door_state : bool):
	if current_door_state == new_door_state:
		return
	
	current_door_state = new_door_state
	
	animation_tree["parameters/conditions/trigger_close"] = !current_door_state
	animation_tree["parameters/conditions/trigger_open"] = current_door_state
