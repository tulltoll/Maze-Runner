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
extends CharacterBody2D


var player_input_vector : Vector2

@export var axeleration = 3000
@export var friction = 0.95
@export var bounce_reduction = 1.8

@onready var player_animation: AnimationPlayer = $AnimationPlayer
@onready var player_sprite: Sprite2D = $"Player sprite"
var player_animation_type_string: String
@export var player_animation_stand_threshold = 100
@export var player_animation_walk_threshold = 750

var player_look_direction : Vector2

@onready var mask: Sprite2D = $Mask
@onready var mask_orginal_position = mask.position
const MASK = preload("res://Asets/Mask.png")
const MASK_LEFT = preload("res://Asets/Mask_left_side.png")
const MASK_RIGHT = preload("res://Asets/Mask_right_side.png")
@export var mask_run_displasment = 20

@onready var mask_eye_color: Sprite2D = $"Mask/Mask eye color"
const WHITE_PIXEL_MIDDEL = preload("res://Asets/white_pixel_middel.png")
const WHITE_PIXEL_LEFT = preload("res://Asets/white_pixel_left.png")




func _process( delta: float ) -> void:
	
	#movement:
	if Input.get_vector( "Player_left", "Player_right", "Player_up", "Player_down" ):
		
		player_input_vector = Input.get_vector( "Player_left", "Player_right", "Player_up", "Player_down" )
		
	else:
		
		player_input_vector = Vector2( 0, 0)
	
	velocity += ( player_input_vector * axeleration * delta )
	
	velocity *= friction
	
	if  abs(velocity.x) + abs(velocity.y) < 10 :
		
		velocity = Vector2( 0, 0 )
	
	var collision = move_and_collide( velocity * delta )
	
	if collision:
		
		velocity = velocity.bounce( collision.get_normal( ) )
		
		velocity *=  bounce_reduction
	
	#animations and sprite:
	
	if abs(velocity.x) > abs(velocity.y):
		
		player_look_direction = Vector2( abs(velocity.x) / velocity.x, 0 )
	
	if abs(velocity.y) > abs(velocity.x):
		
		player_look_direction = Vector2( 0, abs(velocity.y) / velocity.y )
	
	if player_look_direction.x > 0:
		
		player_sprite.flip_h = false 
		
	elif player_look_direction.x < 0:
		
		player_sprite.flip_h = true
	
	
	if abs(velocity.x) + abs(velocity.y) < player_animation_stand_threshold:
		
		player_animation_type_string = "stand"
		
	elif abs(velocity.x) + abs(velocity.y) < player_animation_walk_threshold:
		
		player_animation_type_string = "walk"
		
	else:
		
		player_animation_type_string = "run"
	
	
	if player_animation_type_string == "run":
		
		mask.position = Vector2( mask_orginal_position.x + player_look_direction.x * mask_run_displasment, mask_orginal_position.y + player_look_direction.y * mask_run_displasment )
		
	else:
		
		mask.position = mask_orginal_position
	
	
	if player_look_direction.x:
		
		player_animation.current_animation = player_animation_type_string + "_side"
		
		if player_look_direction.x < 0:
			
			mask.flip_h = false
			mask.texture = MASK_LEFT
			mask.z_index = 3
			
			mask_eye_color.texture = WHITE_PIXEL_LEFT
			mask_eye_color.flip_h = false
			
		elif player_look_direction.x > 0:
			
			mask.flip_h = false
			mask.texture = MASK_RIGHT
			mask.z_index = 3
			
			mask_eye_color.texture = WHITE_PIXEL_LEFT
			mask_eye_color.flip_h = true
		
	else:
		
		mask_eye_color.texture = WHITE_PIXEL_MIDDEL
		
		if player_look_direction.y > 0:
		
			mask.flip_h = false
			mask.texture = MASK
			mask.z_index = 3
			
			player_sprite.flip_h = false
			player_animation.current_animation = player_animation_type_string + "_down"
			
		elif player_look_direction.y < 0:
			
			mask.z_index = 1
			mask.texture = MASK
			mask.flip_h = true
			
			player_sprite.flip_h = false
			player_animation.current_animation = player_animation_type_string + "_up"
