extends Node2D

@export var current_stage : int = 0

signal power_off_started
signal freddy_flicker_started
signal power_darkness_started
signal jumpscare_played

@export var time_until_animatronic_footstep_range : Vector2 = Vector2(1.5, 3)
@export var timer_until_animatronic_footstep : Timer
@export var time_until_freddy_flicker_range : Vector2 = Vector2(7.5, 12.5)
@export var timer_until_freddy_flicker : Timer
@export var time_until_power_darkness_range : Vector2 = Vector2(8, 16)
@export var timer_until_power_darkness : Timer
@export var time_until_animatronic_footstep_darkness_range : Vector2 = Vector2(2.5, 4.5)
@export var timer_until_animatronic_footstep_darkness : Timer
@export var time_until_jumpscare_range : Vector2 = Vector2(4, 12)
@export var timer_until_jumpscare : Timer

func _ready():
	timer_until_animatronic_footstep.wait_time = randf_range(time_until_animatronic_footstep_range.x, time_until_animatronic_footstep_range.y)
	timer_until_freddy_flicker.wait_time = randf_range(time_until_freddy_flicker_range.x, time_until_freddy_flicker_range.y)
	timer_until_power_darkness.wait_time = randf_range(time_until_power_darkness_range.x, time_until_power_darkness_range.y)
	timer_until_animatronic_footstep_darkness.wait_time = randf_range(time_until_animatronic_footstep_darkness_range.x, time_until_animatronic_footstep_darkness_range.y)
	timer_until_jumpscare.wait_time = randf_range(time_until_jumpscare_range.x, time_until_jumpscare_range.y)

func increment_power_off_stage():
	current_stage += 1
	match current_stage:
		1:
			power_off_started.emit()
		2:
			freddy_flicker_started.emit()
		3:
			power_darkness_started.emit()
		4:
			jumpscare_played.emit()
