extends Node

class_name wall_properties

var _collision_layer = 0
var _visibility_layer = 0

func define(id):
	_collision_layer = id + 1
	_visibility_layer = id + 1
	return [_collision_layer, _visibility_layer]
