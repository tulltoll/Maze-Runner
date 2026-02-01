extends TileMapLayer

var mask_status = "none"
var tiles = get_used_cells()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.mask_change.connect(Mask_Status)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Mask_Status(blue_mask_on, red_mask_on):
	if !blue_mask_on and !red_mask_on:
		mask_status = "none"
	elif blue_mask_on and !red_mask_on:
		mask_status = "blue"
	elif !blue_mask_on and red_mask_on:
		mask_status = "red"
	else:
		mask_status = "both"

func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	if mask_status == "none":
		if coords.y != 0:
			return false
		if(coords.x == 1 or coords.x == 2 or coords.x == 3):
			return true
	if mask_status == "red":
		if coords.y == 1:
			if coords.x == 2 or coords.x == 3 or coords.x == 4:
				return true
		elif coords.y == 2 and coords.x == 0:
			return true
	if mask_status == "blue":
		if coords.y == 2:
			if coords.x == 2 or coords.x == 3 or coords.x == 4:
				return true
		elif coords.y == 3 and coords.x == 0:
			return true
	if mask_status == "both":
		if coords.y == 3:
			if coords.x == 2 or coords.x == 3 or coords.x == 4:
				return true
		elif coords.y == 4 and coords.x == 0:
			return true
	return false
	
func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	tile_data.modulate = Color(0,0,0,0)
