extends Sprite2D
class_name animatronic_in_office

var is_in_office : bool

func set_office_appearance_state(appear_in_office : bool) -> void:
	if appear_in_office == is_in_office:
		return
	
	is_in_office = appear_in_office
	
	visible = is_in_office
