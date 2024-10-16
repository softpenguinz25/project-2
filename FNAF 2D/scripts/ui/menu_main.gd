extends Control

@export var menu_array : Array[MenuMainSub]
var current_menu_index = 0

signal menu_set_no_params

func _ready():
	load_menu_state()

func set_current_menu(index : int):
	current_menu_index = wrapi(index, 0, menu_array.size())
	
	for menu_index in menu_array.size():
		menu_array[menu_index].set_active_state(menu_index == current_menu_index)
	
	menu_set_no_params.emit()
	
	MenuManager.set_current_menu_index(current_menu_index)

func increment_current_menu(increment : int):
	set_current_menu(current_menu_index + increment)

func load_menu_state():
	MenuManager.load_data()
	
	set_current_menu(MenuManager.current_menu_index)
