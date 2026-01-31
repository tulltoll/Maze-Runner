extends CharacterBody2D


var player_input_vector : Vector2

@export var player_aceleration = 3000

@export var player_friction = 0.95

@export var player_bounce_reduction = 1.8


func _process( delta: float ) -> void:
	
	player_input_vector = Input.get_vector( "Player_left", "Player_right", "Player_up", "Player_down" )
	
	velocity += ( player_input_vector * player_aceleration * delta )
	
	velocity *= player_friction
	
	if  abs( velocity.x ) + abs( velocity.y ) < 10 :
		
		velocity = Vector2( 0, 0 )
	
	var collision = move_and_collide( velocity * delta )
	
	if collision:
		
		velocity = velocity.bounce( collision.get_normal( ) )
		
		velocity *=  player_bounce_reduction

#func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	#
	#print("a")
