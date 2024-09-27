extends animatronic
class_name animatronic_in_vent_fnaf2

var is_in_office : bool

@export_subgroup("Functionality")
@export var timer_jumpscare : Timer
@export var timer_mask : Timer

@export_subgroup("GFX")
@onready var sprite = $"."

@export_subgroup("Mask")
@export var player : player_fnaf2
var mask_on : bool
var mask_state_old : bool

@export_subgroup("Retreat")
@export var animatronic_roaming : animatronic_roaming_fnaf2

@export_subgroup("Jumpscare")
var jumpscare_queued : bool
@export var monitor_screen : MonitorScreen
signal animatronic_jumpscare(animatronic_name : String)

@export_subgroup("Debug")
@export var enable_gfx_on_ready : bool

func _ready():
	if not enable_gfx_on_ready: handle_gfx(false)
	monitor_screen.monitor_unfocus.connect(on_monitor_unfocus)
	
	mask_on = player.is_wearing_mask
	player.mask_state_changed.connect(on_mask_state_changed)

func trigger_in_office(in_office : bool) -> void:
	#print_debug("%s in_office: %s {%s}" % [animatronic_name, in_office, Time.get_ticks_msec() / 1000.0])
	
	is_in_office = in_office
	
	handle_gfx(in_office)
	
	if in_office: handle_func()
	else: retreat()

func handle_gfx(in_office : bool):
	sprite.visible = in_office

func handle_func():
	animatronic_roaming.set_can_move(false)
	
	timer_jumpscare.start()
	timer_mask.start()
	
	update_mask_state()

func _process(delta):
	if not is_in_office: return
	
	if not mask_on == mask_state_old:
		update_mask_state()
		
		mask_state_old = mask_on

func update_mask_state():
	timer_jumpscare.paused = mask_on
	timer_mask.paused = not mask_on

func retreat():
	jumpscare_queued = false
	
	animatronic_roaming.reset_pos()
	animatronic_roaming.set_can_move(true)
	
	timer_jumpscare.stop()
	timer_mask.stop()

func on_jumpscare_timer_timeout():
	if not ai_opportunity_passed():
		timer_jumpscare.start()
	else:
		jumpscare_queued = true

func on_monitor_unfocus():
	if jumpscare_queued:
		animatronic_jumpscare.emit(animatronic_name)

func on_mask_timer_timeout():
	trigger_in_office(false)

func on_mask_state_changed(is_on : bool):
	mask_on = is_on
