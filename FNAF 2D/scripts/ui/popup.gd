extends animatronic
class_name PopupAnimatronic

@export var monitor : MonitorScreen

func _ready():
	monitor.popup_toggled.connect(_on_popup_on)

func _on_popup_on(popup_name : String):
	return
