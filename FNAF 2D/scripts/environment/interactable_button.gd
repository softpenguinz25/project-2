extends interactable

@onready var button : Button = $"."

@export var cooldown_timer : Timer

var is_absolute : bool = false

func _ready():
	button.disabled = true

func set_interact_state(interact_state : bool):
	super.set_interact_state(interact_state)
	set_button_disabled_state(not is_interacting)

func set_button_disabled_state(state : bool):
	if is_absolute: return
	
	if state: 
		button.set_pressed(false)
		button.button_up.emit()
	button.disabled = state

func set_interact_state_absolute(interact_state_absolute : bool):
	set_interact_state(interact_state_absolute)
	is_absolute = true

func button_pressed():
	if cooldown_timer != null: 
		set_button_disabled_state(true)
		cooldown_timer.start()
