extends Node2D

var day_limit = 5
@export var game_state : GameStateResource
var suspicion

# Astronaut, CT, NRA, Karen
var death_array = ["Mr Johnson", "CT", "NRA", "Charlotte"]
var pronoun_map = {
	"Mr Johnson" : "He", 
	"CT" : "She",
	"NRA" : "He",
	"Charlotte" : "She"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	suspicion = game_state.suspicion
	print_debug(game_state.day_or_night + str(game_state.current_day))
	Dialogic.signal_event.connect(_on_signal_event)
	get_node("Player").disable_y_movement()
	Dialogic.start(_get_prefix() + "outside")

func _on_signal_event(argument : String):
	match argument:
		"investigate" :
			_investigate()
		"enterHouse":
			_enter_house()

func _get_prefix():
	return game_state.day_or_night + str(game_state.current_day)

func _investigate():
	suspicion += 1
	game_state.suspicion = suspicion
	var killed = death_array[ - 2] # day 2 corresponds to 1st element
	Dialogic.VAR.killed = killed
	Dialogic.VAR.pronoun = pronoun_map[killed]
	Dialogic.start("investigation" + str(suspicion))

func _on_dumpster_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		Dialogic.start("dumpster")
		
func _on_player_house_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		Dialogic.start("enterHouse")

func _enter_house():
	get_tree().change_scene_to_file("res://scenes/player/player_house.tscn")
