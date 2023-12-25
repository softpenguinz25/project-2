extends Control

@export var jumpscare_sprites : Dictionary

func show_jumpscare_sprite(animatronic_name : String):
	get_node(jumpscare_sprites[animatronic_name]).visible = true
