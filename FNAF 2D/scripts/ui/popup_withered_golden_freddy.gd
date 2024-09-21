extends PopupAnimatronic

var is_in_progress : bool

@export var jumpscare_increments : Array[Control]
var current_increment : int

@export var timer_jumpscare_increment : Timer

@export var pos_bound_topleft : Control
@export var pos_bound_bottomright : Control

func _ready():
	super._ready()
	handle_gfx(jumpscare_increments[0], false)

func _on_popup_on(popup_name : String):
	if is_in_progress: return
	
	if animatronic_name != popup_name: return
	
	handle_func()

func handle_func():
	timer_jumpscare_increment.start()
	
	self.position = Vector2(randf_range(pos_bound_topleft.position.x, pos_bound_bottomright.position.x), randf_range(pos_bound_topleft.position.y, pos_bound_bottomright.position.y))
	
	is_in_progress = true

func _on_popup_off():
	timer_jumpscare_increment.stop()
	
	current_increment = 0
	for jumpscare_increment in jumpscare_increments: handle_gfx(jumpscare_increment, false)
	
	is_in_progress = false

func _on_timer_jumpscare_increment_timeout():
	if current_increment >= jumpscare_increments.size():
		monitor.emit_jumpscare(animatronic_name)
		return
	
	handle_gfx(jumpscare_increments[current_increment], true)
	
	current_increment += 1

func handle_gfx(control : Control, gfx_state : bool):
	control.color = Color.RED if gfx_state else Color.BLACK
	self.visible = gfx_state
