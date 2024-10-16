extends CanvasItem

@export var popup_name : String = "withered_golden_freddy"
@export var monitors : MonitorScreen
var popup : WitheredGoldenFreddyPopup

@export var bsod_oneinc : CanvasItem

signal gfx_on
signal increment_updated(increments_left : int)
signal increment_updated_no_params

func _ready():
	#potential wr for most "popups" in a single line of code
	popup = monitors.popups.get_node(monitors.popups.popup_dict[popup_name])
	
	popup.popup_resolved.connect(func(): 
		visible = false
		bsod_oneinc.visible = false
		)
	popup.increments_updated.connect(func(increments_left : int): 
		if increments_left <= 1:
			visible = false
			bsod_oneinc.visible = true
		
		increment_updated_no_params.emit()
		increment_updated.emit(increments_left)
		)

func toggle_gfx(visible : bool):
	self.visible = visible
	
	if visible: gfx_on.emit()
