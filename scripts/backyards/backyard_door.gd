extends Node

@export var info : Backyard_Resource



func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		var dial
