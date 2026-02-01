extends AudioStreamPlayer2D

func _ready() -> void:
	
	play( SignalBus.sound_loop_location )
