extends Node

@export var info : InteractableObject

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed && ! \
		(info.state.day_or_night == "day" && info.state.current_day == 1):
		info.found = true
		Dialogic.start(info.dialog_name)
