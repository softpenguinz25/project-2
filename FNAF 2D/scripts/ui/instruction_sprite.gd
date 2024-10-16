extends Instruction

@export var instruction_pc : Texture2D
@export var instruction_mobile : Texture2D

func _ready():
	self.texture = instruction_pc if not is_mobile() else instruction_mobile

func set_active_state(state:bool):
	super.set_active_state(state)
