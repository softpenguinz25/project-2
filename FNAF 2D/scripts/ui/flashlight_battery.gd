extends Node
class_name FlashlightBattery

@export_subgroup("Functionality")
var battery_out : bool
var battery_out_queued : bool
var is_last_flashlight_camera : bool

@export var use_limit : int = 120
#TODO: @export var use_limit_20d : int

var current_uses : int

@export_subgroup("Hall")
@export var hall_button : InteractableButton

@export_subgroup("Monitor")
@export var monitor : MonitorScreen

signal battery_ratio_set(battery_ratio : float)

func _ready():
	hall_button.on_disabled_state_unfreeze.connect(_on_hall_light_button_on_disabled_state_unfreeze)
	
	hall_button.button_down.connect(_on_hall_light_flashed_on)
	hall_button.button_up.connect(_on_hall_light_flashed_off)
	
	monitor.camera_scene_flashed_on.connect(_on_monitor_screen_flashed_on)
	monitor.camera_scene_flashed_off.connect(_on_monitor_screen_flashed_off)
	
	battery_ratio_set.emit((float)(use_limit - current_uses) / use_limit)

func use_flashlight():
	current_uses += 1
	battery_ratio_set.emit((float)(use_limit - current_uses) / use_limit)
	
	if current_uses > use_limit - 1: queue_disable_flashlight()

func queue_disable_flashlight():
	battery_out_queued = true

func disable_flashlight():
	battery_out = true
	
	disable_light_hall()
	disable_light_monitor()

func disable_light_hall():
	#hall_button.set_interact_state_absolute(false)
	hall_button.set_button_disabled_state_absolute(true)

func _on_hall_light_button_on_disabled_state_unfreeze():
	if not battery_out: return
	
	disable_light_hall()

func disable_light_monitor():
	monitor.set_flash_disable(true)

func _on_current_flashlight_button_up():
	disable_flashlight

func _on_hall_light_flashed_on():
	use_flashlight()
	is_last_flashlight_camera = false

func _on_monitor_screen_flashed_on():
	use_flashlight()
	is_last_flashlight_camera = true

func _on_hall_light_flashed_off():
	if not battery_out and battery_out_queued and not is_last_flashlight_camera:
		disable_flashlight()

func _on_monitor_screen_flashed_off():
	if not battery_out and battery_out_queued and is_last_flashlight_camera:
		disable_flashlight()
