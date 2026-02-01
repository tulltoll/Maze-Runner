extends Area2D

var velocety : Vector2
@export var base_speed = -3
@export var acelerason = 1
@export var friction = 0.99
var angel_to_player

func _process( delta: float ) -> void:
	
	angel_to_player = SignalBus.player_position - position
	angel_to_player = angel_to_player.normalized()
	
	velocety = angel_to_player
	velocety *= base_speed * delta
	velocety *= friction
	
	position += velocety
	
	base_speed += acelerason * delta
