extends Node2D

var day_limit = 5
@export var game_state : GameStateResource
@export var backdoors : Array[Backyard_Resource]
@export var scales : InteractableObject
@export var otherItems: Array[InteractableObject] # just to save them
var suspicion
var alienFaced = false

# Astronaut, CT, NRA, Karen
var death_array = ["Mr Johnson", "Joanne", "Billy", "Charlotte"]
var pronoun_map = {
	"Mr Johnson" : "He", 
	"Joanne" : "She",
	"Billy" : "He",
	"Charlotte" : "She"
}
var house_death_order = ["astronaut", "ct", "nra", "couple"]
var house_death_position = [2569, -2773, 1500, -1103]

# Called when the node enters the scene tree for the first time.
func _ready():
	suspicion = game_state.suspicion
	print_debug(game_state.day_or_night + str(game_state.current_day))
	Dialogic.signal_event.connect(_on_signal_event)
	if game_state.day_or_night == "night":
		get_node("ParallaxBackground/ParallaxLayer/Icon").visible = false
		get_node("ParallaxBackground/ParallaxLayer/Night").visible = true
		get_node("Lights").visible = true
	get_node("Player").disable_y_movement()
	get_node("Player").position.x = game_state.position_on_street
	if game_state.current_day > 1 && game_state.day_or_night == "night":
		_instantiate_blood()
		game_state.killed = house_death_order[game_state.current_day - 2]
	if _need_scales_found():
		_instantiate_scales()	
	if game_state.visit_number == 0:
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
		"startOutside":
			get_node("Player").disable_player()
		"endOutside":
			get_node("Player").enable_player()
		"alienFaced":
			alienFaced = true
		"endGame":
			_end_game()

func _get_prefix():
	return game_state.day_or_night + str(game_state.current_day)

func _investigate():
	if game_state.current_day == 5:      # alien killing player scenario
		Dialogic.start("investigation4")
		return
	suspicion += 1
	game_state.suspicion = suspicion
	var killed = death_array[game_state.current_day - 2] # day 2 corresponds to 1st element
	Dialogic.VAR.killed = killed
	Dialogic.VAR.pronoun = pronoun_map[killed]
	Dialogic.start("investigation" + str(suspicion))
		
func _can_enter_house():
	return game_state.current_day > 1 || game_state.day_or_night != "day" || game_state.visit_number >= 5
		
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
		elif _need_scales_found():
			Dialogic.start("continueInvestigation")
		elif _need_to_face_alien():
			Dialogic.start("needToFaceAlien")
		else:
			_reset_visits()
			Dialogic.start("enterHouse")

func _enter_house():
	save_player_position(-1890)
	if game_state.day_or_night == "night" || game_state.current_day == 1:
		get_tree().change_scene_to_file("res://scenes/player/player_house_view.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/player/player_house.tscn")

func _need_scales_found():
	return game_state.current_day == 1 && game_state.day_or_night == "night" && ! scales.found

func _need_to_face_alien():
	return game_state.current_day == 5 && game_state.day_or_night == "night" && ! alienFaced

func _scales_found():
	return scales.found

func _instantiate_scales():
	var scales = load("res://scenes/scales.tscn")
	var instance = scales.instantiate()
	add_child(instance)

func _instantiate_blood():
	var blood = load("res://scenes/street/blood.tscn")
	var instance = blood.instantiate()
	var i = game_state.current_day - 2
	instance.position = Vector2(house_death_position[i], 0)
	add_child(instance)

func _end_game(): # called when death or jail
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func save_player_position(x):
	game_state.position_on_street = x
