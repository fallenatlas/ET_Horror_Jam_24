extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Player").disable_y_movement()


func _on_dumpster_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		Dialogic.start("dumpster")
