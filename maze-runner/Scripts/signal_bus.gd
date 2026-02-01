extends Node

signal mask_change

var player_position : Vector2 = Vector2(0,0)

var key_pice_amount_picket_up : int = 0

var sound_loop_location = 0.0

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
