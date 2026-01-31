extends CharacterBody2D

@export var movespeed = 200

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
	
	
	move_and_slide()
