extends Label

@export var battery_timer : BatteryTimer
@export var format_text : String = ":%s%%"

func _process(_delta):
	$".".text = format_text % roundi(battery_timer.power)

func increment_power_gfx(increment_amount : int):
	var color_tween : Tween = create_tween()
	set("theme_override_colors/font_color", Color.RED if increment_amount < 0 else Color.GREEN)
	color_tween.tween_property($".", "theme_override_colors/font_color", Color.WHITE, .33).set_trans(Tween.TRANS_CIRC)
	
