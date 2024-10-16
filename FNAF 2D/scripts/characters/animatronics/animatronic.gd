extends Node
class_name animatronic

@export var animatronic_name : String

var use_ai_level_by_hour : bool = true
@export var ai_level_by_hour : Dictionary = {12:0,1:4,2:8,3:12,4:16,5:20}
var ai_level : int = ai_level_by_hour[12]
const max_ai_level = 20

@export var debug_ai : bool = false

func _ready():
	if debug_ai:
		use_ai_level_by_hour = false
		set_ai_level(max_ai_level)

func set_ai_level(new_ai_level : int): 
	ai_level = new_ai_level
	#print_debug("%s new ai level: %s (%s)" % [animatronic_name, new_ai_level, ai_opportunity_passed()])
func set_ai_level_by_hour(hour : int): if use_ai_level_by_hour and ai_level_by_hour.has(hour): set_ai_level(ai_level_by_hour[hour])
func increment_ai_level(increment_value : int): set_ai_level(ai_level + increment_value)

func ai_opportunity_passed() -> bool: return randf_range(1, max_ai_level) <= ai_level
