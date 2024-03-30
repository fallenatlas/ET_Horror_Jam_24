extends Node2D

var day_limit = 5
@export var game_state : GameStateResource
@export var backdoors : Array[Backyard_Resource]
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
	if game_state.visit_number == 0:
		get_node("Player").position.x = game_state.position_on_street
		get_node("Player").disable_player()
		Dialogic.start(_get_prefix() + "outside") # first time outside
	elif _need_to_go_home():
		Dialogic.start("needToGoHome")

func _on_signal_event(argument : String):
	match argument:
		"investigate" :
			_investigate()
		"enterHouse":
			_enter_house()
		"endOutside":
			get_node("Player").enable_player()

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
		
func _can_enter_house():
	return game_state.current_day > 1 || game_state.day_or_night != "day" || game_state.visit_number == 5
		
func _need_to_go_home():
	return (game_state.current_day > 1 && game_state.visit_number > 1) || game_state.visit_number == 5

func _reset_visits():
	for resource in backdoors:
		resource.first_time_day = true
	game_state.visit_number = 0

func _on_player_house_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		if ! _can_enter_house():
			Dialogic.start("continueOutside")
		else:
			_reset_visits()
			Dialogic.start("enterHouse")

func _enter_house():
	save_player_position(-1890)
	get_tree().change_scene_to_file("res://scenes/player/player_house.tscn")

func save_player_position(x):
	game_state.position_on_street = x
