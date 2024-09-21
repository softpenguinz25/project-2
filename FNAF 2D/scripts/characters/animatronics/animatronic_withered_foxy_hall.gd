extends animatronic
#i could make this polymorphic as vent animatronics have the same funcs, but ¯\_(ツ)_/¯

var is_in_hall : bool

@export var animatronic_roaming : animatronic_roaming_fnaf2

@export_subgroup("Functionality")
@export var timer_retreat : Timer
@export var timer_jumpscare : Timer
@export var timer_jumpscare_start_timer_over_ai : Curve
var timer_jumpscare_wait_time : float:
	get: return timer_jumpscare_start_timer_over_ai.sample(ai_level / max_ai_level)
var retreat_queued : bool

@export_subgroup("GFX")
@export var animatronic_gfx : CanvasItem
@export var animatronic_eyes : CanvasItem

signal animatronic_jumpscare(animatronic_name : String)

func _ready():
	handle_gfx(false)

func trigger_in_office(in_office : bool) -> void:
	handle_func(in_office)
	handle_gfx(in_office)

func handle_func(in_office : bool):
	is_in_hall = in_office
	
	animatronic_roaming.set_can_move(not in_office)
	
	if in_office:
		timer_retreat.start()
		
		timer_jumpscare.wait_time = timer_jumpscare_wait_time
		timer_jumpscare.start()
	else:
		timer_retreat.stop()
		timer_jumpscare.stop()
		
		animatronic_roaming.reset_pos()
	
	retreat_queued = false

func _process(delta):
	if not is_in_hall: return
	
	animatronic_eyes.modulate.a = 1 - (timer_jumpscare.time_left / timer_jumpscare.wait_time)

func handle_gfx(in_office : bool):
	animatronic_gfx.visible = in_office
	animatronic_eyes.visible = in_office

func hall_light_state_set(state : bool):
	if not is_in_hall: return
	
	if state: 
		if retreat_queued: 
			trigger_in_office(false)
			return
		
		timer_jumpscare.wait_time = timer_jumpscare_wait_time
		timer_jumpscare.start()
	
	animatronic_eyes.visible = not state

func _on_timer_retreat_timeout():
	retreat_queued = true

func _on_timer_jumpscare_timeout():
	animatronic_jumpscare.emit(animatronic_name)
