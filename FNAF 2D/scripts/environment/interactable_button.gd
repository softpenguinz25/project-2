extends interactable

@onready var button : Button = $"."

func _ready():
	print(name + ": " + str(button))
	button.disabled = true

func set_interact_state(interact_state : bool):
	super.set_interact_state(interact_state)
	button.disabled = not is_interacting
