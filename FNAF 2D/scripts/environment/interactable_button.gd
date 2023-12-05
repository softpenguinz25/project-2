extends interactable

@onready var button : Button = $"."

@export var cooldown_timer : Timer

var should_be_enabled : bool = false
var disabled_state_frozen : bool = false

func _ready():
	button.disabled = true

func set_interact_state(interact_state : bool):
	should_be_enabled = interact_state
	super.set_interact_state(interact_state)
	set_button_disabled_state(not is_interacting)

func set_button_disabled_state(state : bool):
	super.set_button_disabled_state(state)
	if disabled_state_frozen: return
	
	if state: 
		button.set_pressed(false)
		button.button_up.emit()
	button.disabled = state

func set_interact_state_absolute(interact_state_absolute : bool):
	set_interact_state(interact_state_absolute)
	disabled_state_frozen = true

func set_button_disabled_state_absolute(state : bool):
	set_button_disabled_state(state)
	disabled_state_frozen = true

func unfreeze_disabled_state():
	disabled_state_frozen = false
	set_interact_state(should_be_enabled)

func button_pressed():
	if cooldown_timer != null: 
		set_button_disabled_state_absolute(true)
		cooldown_timer.start()
