extends Node2D

var day_limit = 5
var current_day = 1
var day_or_night = "day"
var suspicion = 0

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
	Dialogic.signal_event.connect(_on_signal_event)
	get_node("Player").disable_y_movement()

func _on_signal_event(argument : String):
	match argument:
		"investigate" :
			_investigate()
		"enterHouse":
			_change_day_and_night()

func _investigate():
	suspicion += 1
	var killed = death_array[current_day - 2] # day 2 corresponds to 1st element
	Dialogic.VAR.killed = killed
	Dialogic.VAR.pronoun = pronoun_map[killed]
	Dialogic.start("investigation" + str(suspicion))

func _on_dumpster_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		Dialogic.start("dumpster")
		
func _on_player_house_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		Dialogic.start("enterHouse")

func _get_prefix():
	return day_or_night + str(current_day)

func _enter_house():
	_change_day_and_night()
	
func _change_day_and_night():
	if (day_or_night == "night"):
		current_day += 1
	day_or_night = "night" if day_or_night == "day" else "day"
	var dialog_name = _get_prefix()
	print_debug("changed to " + dialog_name)
	Dialogic.start(dialog_name)
	
