extends CharacterBody2D

@export_category("Movement")
var last_move_dir : int
@onready var top_speed : float = 600
@onready var acceleration : float = 3600
@onready var acceleration_turn_around_multiplier : float = 2.5

func _process(_delta):
	move_player(_delta)
	
	move_and_slide()

func move_player(_delta) -> void:
	var move_dir : int = int(Input.get_axis("move_left", "move_right"))
	if absf(move_dir) > 0:
		var acceleration_to_use : float = acceleration if signf(velocity.x) == move_dir else acceleration * acceleration_turn_around_multiplier
		velocity.x += move_dir * acceleration_to_use * _delta
		last_move_dir = move_dir
	elif signf(velocity.x) == last_move_dir:
		velocity.x += -signf(velocity.x) * acceleration * _delta
	else:
		velocity.x = 0
		
	velocity.x = clampf(velocity.x, -top_speed, top_speed)

func interact_with_interactables(area_2d : Area2D, interact_state : bool) -> void:
	print("area 2d name: " + str(area_2d))
	if !area_2d.is_in_group("interactable"): return
	
	var interactable_node : interactable = area_2d.get_parent()
	interactable_node.set_interact_state(interact_state)
