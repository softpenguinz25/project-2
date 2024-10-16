extends animatronic

var is_in_office : bool

@export var hall_button : InteractableButton

@export var gfx_body : CanvasItem
@export var in_office_ambience : AudioStreamPlayer2D

func _ready():
	super._ready()
	
	hall_button.on_disabled_state_unfreeze.connect(_on_hall_light_button_on_disabled_state_unfreeze)

func trigger_in_office() -> void:
	is_in_office = true
	
	handle_func()
	handle_gfx()

func handle_func():
	if not is_in_office: return
	
	hall_button.set_button_disabled_state_absolute(true)

func handle_gfx():
	gfx_body.visible = true
	in_office_ambience.play()

func _on_hall_light_button_on_disabled_state_unfreeze():
	handle_func()
