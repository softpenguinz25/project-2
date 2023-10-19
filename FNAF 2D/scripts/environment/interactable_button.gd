extends interactable

@onready var button : Button = $Button

func _ready():
	button.disabled = true

func set_interact_state(interact_state : bool):
	super.set_interact_state(interact_state)
	button.disabled = not is_interacting
