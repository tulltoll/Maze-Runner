extends Node

class_name wall_properties

var _collision_layer = 0
var _visibility_layer = 0
var color = 0

var colors = {PropertyContainer.static_wall_layer : Color(0,0,0), PropertyContainer.blue_wall_layer : Color(0,0,255), PropertyContainer.red_wall_layer : Color(255,0,0), PropertyContainer.purple_wall_layer : Color(255,0,255), PropertyContainer.no_wall_layer : Color(255,255,255)}

func define(id):
	_collision_layer = id
	print(id)
	_visibility_layer = id
	print(PropertyContainer.static_wall_layer)
	color = colors[id]
	return [_collision_layer, _visibility_layer, color]
