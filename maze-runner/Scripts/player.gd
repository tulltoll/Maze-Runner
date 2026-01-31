extends CharacterBody2D

@export var movespeed = 200

func _ready() -> void:
	pass
	
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
