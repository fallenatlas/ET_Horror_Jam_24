extends Node

@export var info : Backyard_Resource



func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		var scene_name = "res://scenes/backyards/" + info.owner + "_backyard.tscn"
		get_tree().change_scene_to_file(scene_name)
