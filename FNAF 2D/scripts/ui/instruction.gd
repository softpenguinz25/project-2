extends CanvasItem
class_name Instruction

func is_mobile() -> bool:
	return OS.has_feature("mobile")

func set_active_state(state:bool):
	visible = state
