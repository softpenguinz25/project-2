@tool
extends RemoteTransform2D

@export var limit : Vector4 = Vector4(-10000000, -10000000, 10000000, 10000000)
var start_limit : Vector4

@export var keep_relativity_to_parent : bool
var start_local_pos : Vector2

func _ready():
	start_limit = limit
	start_local_pos = position

func _process(_delta):
	if not Engine.is_editor_hint():
		if keep_relativity_to_parent:
			position = start_local_pos
	
	global_position = global_position.clamp(Vector2(limit.x, limit.y), Vector2(limit.z, limit.w))

func remove_limit():
	limit = Vector4(-10000000, -10000000, 10000000, 10000000)

func reset_limit():
	limit = start_limit
