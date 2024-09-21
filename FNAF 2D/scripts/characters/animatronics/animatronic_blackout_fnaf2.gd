extends animatronic
class_name animatronic_blackout_fnaf2

var is_in_office_queued : bool

@export_subgroup("Functionality")
@export var timer_blackout : Timer
@export var timer_mask_reaction : Timer
@export var timer_mask_reaction_start_timer_over_ai : Curve
var is_in_blackout : bool
@export var blackout_manager : animatronic_blackout_fnaf2_manager

@export_subgroup("Mask")
@export var player : player_fnaf2
var mask_on : bool

@export_subgroup("Retreat")
@export var animatronic_roaming : animatronic_roaming_fnaf2

@export_subgroup("Jumpscare")
var checking_for_jumpscare : bool
@export var monitor_screen : MonitorScreen
signal animatronic_jumpscare(animatronic_name : String)

@export_subgroup("GFX")
@export var animations : Array[AnimationPlayer]

func _ready():
	handle_gfx(false)
	monitor_screen.monitor_unfocus.connect(on_monitor_unfocus)
	
	mask_on = player.is_wearing_mask
	player.mask_state_changed.connect(on_mask_state_changed)

func trigger_in_office(in_office : bool) -> void:
	is_in_office_queued = in_office
	
	if in_office:
		animatronic_roaming.set_can_move(false)
	else:
		handle_gfx(in_office)
		
		retreat()

func trigger_in_office_immediate(in_office : bool) -> void:
	trigger_in_office(in_office)
	blackout_manager.append_blackout(self)

func handle_gfx(in_office : bool):
	self.visible = in_office
	
	if in_office:
		for animation in animations:
			animation.stop()
			animation.play("blackout")

func handle_func():
	timer_blackout.start()
	
	timer_mask_reaction.wait_time = timer_mask_reaction_start_timer_over_ai.sample(ai_level / max_ai_level)
	timer_mask_reaction.start()
	
	#player.set_can_take_off(false)
	
	is_in_blackout = true

func retreat():
	animatronic_roaming.reset_pos()
	animatronic_roaming.set_can_move(true)

func on_blackout_timer_timeout():
	handle_gfx(false)
	trigger_in_office(false)
	
	#player.set_can_take_off(true)
	
	#print_debug("we finna erase %s (it's name is %s)" % [self, name])
	blackout_manager.erase_blackout(self)
	
	checking_for_jumpscare = false
	is_in_blackout = false
	
func _process(delta):
	if checking_for_jumpscare:
		if not player.is_wearing_mask:
			animatronic_jumpscare.emit(animatronic_name)

func on_mask_reaction_timer_timeout():
	checking_for_jumpscare = true

func on_monitor_unfocus():
	if is_in_blackout: return
	
	if is_in_office_queued:
		blackout_manager.append_blackout(self)
		#trigger_blackout()	

func trigger_blackout():
	handle_func()
	handle_gfx(true)

func on_mask_state_changed(is_on : bool):
	mask_on = is_on
