extends Node
#this is super bizzare, but i am super bizzare so ¯\_(ツ)_/¯

@export var eyes_blacked_hall : Array[CanvasItem]

func _ready():
	for eye_blacked_hall in eyes_blacked_hall:
		eye_blacked_hall.z_index = 1

func hall_light_state_set(state : bool):
	for eye_blacked_hall in eyes_blacked_hall:
		eye_blacked_hall.z_index = 0 if state else 1
