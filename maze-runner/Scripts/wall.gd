extends StaticBody2D

@export var wall_ID = 0
@onready var color = $ColorRect

func _ready() -> void:
	var _wall_properties = WallClassContainer.define(wall_ID)
	set_collision_layer_value(1, false)
	set_collision_layer_value(_wall_properties[0], true)
	visibility_layer = _wall_properties[1]
	color.color = _wall_properties[2]
	print(collision_layer)
