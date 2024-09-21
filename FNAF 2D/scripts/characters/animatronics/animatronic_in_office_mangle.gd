extends animatronic

@export var monitor : MonitorScreen

@export var gfx_body : CanvasItem

signal jumpscare(animatronic_name : String)

func trigger_in_office() -> void:
	handle_func()
	handle_gfx(true)

func handle_func():
	monitor.monitor_unfocus.connect(_on_monitor_unfocus)

func handle_gfx(gfx_on : bool):
	gfx_body.visible = gfx_on

func _on_monitor_unfocus():
	if ai_opportunity_passed():
		bruhdiedggeznoreskilldiffsigmaskibidided()

func bruhdiedggeznoreskilldiffsigmaskibidided():
	jumpscare.emit(animatronic_name)
	handle_gfx(false)
