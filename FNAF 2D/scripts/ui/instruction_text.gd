extends Instruction

@export var instruction_pc : String = "Press 'S' to Roll"
@export var instruction_mobile : String = "Double Tap < or > to Roll"

func _ready():
	self.text = instruction_pc if not is_mobile() else instruction_mobile

func set_active_state(state:bool):
	super.set_active_state(state)
