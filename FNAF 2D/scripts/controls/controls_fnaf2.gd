extends Node

var double_tap_available : bool
@export var roll_timer : Timer

func control_pressed():	
	if double_tap_available:
		#print_debug("roll")
		Input.action_press("roll")
		#call_deferred("release_roll_action")#bizarre i know but ashkhdlkas
	double_tap_available = true
	roll_timer.start()

func control_released():
	Input.action_release("roll")
	#double_tap_available = false

func _on_double_tap_timer_timeout():
	#print_debug("tap timeout")
	double_tap_available = false

#func release_roll_action():
	#Input.action_release("roll")

#func _process(delta):
	#print_debug("%s | roll action pressed" % Input.is_action_just_pressed("roll"))
