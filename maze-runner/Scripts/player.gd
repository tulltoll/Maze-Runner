extends CharacterBody2D

@export var movespeed = 100

@onready var color = $ColorRect

var blue_mask_is_on = false
var red_mask_is_on = false

var static_wall_layer = PropertyContainer.static_wall_layer
var blue_wall_layer = PropertyContainer.blue_wall_layer
var red_wall_layer = PropertyContainer.red_wall_layer
var purple_wall_layer = PropertyContainer.red_wall_layer
var no_wall_layer = PropertyContainer.no_wall_layer

var collision_variants = {"blue" : 3, "red" : 4, "purple" : 5, "white" : 6}

func _ready() -> void:
	collision_layer = PropertyContainer.player_layer # setter player sin collision layer
	Change_Collision() #setter alle layers for de fargede veggenee
	
func _process(delta: float) -> void:
	velocity.y = 0
	velocity.x = 0
	if Input.is_action_pressed("move_up"):
		velocity.y = movespeed * -1
	if Input.is_action_pressed("move_down"):
		velocity.y = movespeed
	if Input.is_action_pressed("move_left"):
		velocity.x = movespeed * -1
	if Input.is_action_pressed("move_right"):
		velocity.x = movespeed 
	
	if Input.is_action_just_pressed("blue_mask"):
		blue_mask_is_on = !blue_mask_is_on
		print("blue", red_mask_is_on)
		Change_Collision()
	if Input.is_action_just_pressed("red_mask"):
		red_mask_is_on = !red_mask_is_on
		print("red", red_mask_is_on)
		Change_Collision()
	
	move_and_slide()
func Change_Collision():
	Reset_Collision_Mask()
	if !blue_mask_is_on and !red_mask_is_on:
		set_collision_mask_value(collision_variants["white"], false)
		color.color = Color(0,0,0,0)
	elif blue_mask_is_on and !red_mask_is_on:
		set_collision_mask_value(collision_variants["blue"], false)
		color.color = PropertyContainer.colors["blue"]
	elif red_mask_is_on and !blue_mask_is_on:
		set_collision_mask_value(collision_variants["red"], false)
		color.color = PropertyContainer.colors["red"]
	elif red_mask_is_on and blue_mask_is_on:
		set_collision_mask_value(collision_variants["purple"], false)
		color.color = PropertyContainer.colors["purple"]
	SignalBus.mask_change.emit(blue_mask_is_on, red_mask_is_on)
	print(collision_mask)
	
func Reset_Collision_Mask():
	for i in range(5):
		set_collision_mask_value(i + 2, true)
