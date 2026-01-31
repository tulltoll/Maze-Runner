extends CharacterBody2D

@export var movespeed = 200

var blue_mask_is_on = false
var red_mask_is_on = false

var static_wall_layer = PropertyContainer.static_wall_layer
var blue_wall_layer = PropertyContainer.blue_wall_layer
var red_wall_layer = PropertyContainer.red_wall_layer
var purple_wall_layer = PropertyContainer.red_wall_layer
var no_wall_layer = PropertyContainer.no_wall_layer

func _ready() -> void:
	collision_layer = PropertyContainer.player_layer # setter player sin collision layer
	collision_mask = static_wall_layer|blue_wall_layer|red_wall_layer|purple_wall_layer #setter alle layers for de fargede veggenee
	
func	 _process(delta: float) -> void:
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
		print(blue_mask_is_on)
		print(collision_mask)
		Change_Collision()
	
	move_and_slide()
func Change_Collision():
	set_collision_mask_value(blue_wall_layer, blue_mask_is_on)
	set_collision_mask_value(red_wall_layer, red_mask_is_on)
	set_collision_mask_value(purple_wall_layer, blue_mask_is_on and red_mask_is_on)
	set_collision_mask_value(no_wall_layer, !blue_mask_is_on and !red_mask_is_on)
	
