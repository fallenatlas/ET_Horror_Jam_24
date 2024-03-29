extends Node

@export var info : InteractableObject

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		info.found = true
		Dialogic.start(info.dialog_name)
		
