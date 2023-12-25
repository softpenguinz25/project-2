extends Sprite2D

@export var flicker_timer : Timer
@export_range(0, 1) var flicker_chance : float = 0.5
@export var eye_sprite_chances : Dictionary

var previously_visible : bool = false

func toggle_animation(do_start : bool, toggle_start_state : bool = false):
	if do_start: flicker_timer.start()
	else: 
		flicker_timer.stop()
		visible = toggle_start_state

func try_flicker():
	visible = randf() <= flicker_chance
	if visible:
		if !previously_visible:
			previously_visible = true
			texture = get_random_eye_sprite()
	else: previously_visible = false

func get_random_eye_sprite() -> Texture2D:
	var total_denomination : float = 0
	for eye_sprite in eye_sprite_chances:
		total_denomination += eye_sprite_chances[eye_sprite]
	
	var rng : float = randf_range(0, total_denomination)
	var current_denomination : float = 0
		
	for eye_sprite in eye_sprite_chances:
		current_denomination += eye_sprite_chances[eye_sprite]
		if rng <= current_denomination:
			return eye_sprite
	
	push_warning("get_random_eye_sprite() didn't work! too bad! rng: " + str(rng) + " | total_denomination: " + str(total_denomination))
	return null
