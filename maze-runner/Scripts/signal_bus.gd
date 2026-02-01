extends Node

signal mask_change

var blue_mask_on = false
var red_mask_on = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("blue_mask") and !Input.is_action_just_pressed("red_mask"):
		blue_mask_on = !blue_mask_on
	elif Input.is_action_just_pressed("red_mask") and !Input.is_action_just_pressed("blue_mask"):
		red_mask_on = !red_mask_on
	elif Input.is_action_just_pressed("red_mask") and Input.is_action_just_pressed("blue_mask"):
		red_mask_on = !red_mask_on
		blue_mask_on = !blue_mask_on
