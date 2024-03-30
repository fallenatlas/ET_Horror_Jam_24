extends Node

@export var info : Backyard_Resource
@export var exit_position : int = 0
@export var game_state : GameStateResource

func _need_to_go_home():
	return game_state.current_day > 1 && game_state.visit_number > 1

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		if _need_to_go_home():
			Dialogic.start("needToGoHome")
		elif game_state.day_or_night == "night":
			Dialogic.start("invadeAtNight")
		else:
			get_parent().save_player_position(exit_position)
			var scene_name = "res://scenes/backyards/" + info.owner + "_backyard.tscn"
			get_tree().change_scene_to_file(scene_name)
