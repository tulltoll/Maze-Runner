extends Control

@onready var color_filter = $ColorRect

func _ready() -> void:
	SignalBus.mask_change.connect(Change_Signal)
	
func Change_Signal():
	print(SignalBus.red_mask_on, SignalBus.blue_mask_on)
	if !SignalBus.red_mask_on and SignalBus.blue_mask_on:
		print("test")
		color_filter.color = Color(0,0,1,0.2)
	elif SignalBus.red_mask_on and !SignalBus.blue_mask_on:
			color_filter.color = Color(1,0,0,0.2)
	elif SignalBus.red_mask_on and SignalBus.blue_mask_on:
			color_filter.color = Color(1,0,1,0.2)
	else:
		color_filter.color = Color(0,0,0,0)
		print("test1")
	print(color_filter.color)
