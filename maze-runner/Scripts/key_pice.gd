extends Area2D

@export var pice_number : String

var picked_up = true

func _ready( ) -> void:
	
	$AnimatedSprite2D.play( pice_number )



func _on_body_entered(body: Node2D) -> void:
	
	if body is CharacterBody2D and picked_up:
		
		$AudioStreamPlayer2D.play( )
		
		SignalBus.key_pice_amount_picket_up += 1
		
		visible = false
		
		picked_up = false
