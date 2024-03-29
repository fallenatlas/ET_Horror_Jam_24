extends Node

@export var game_state : GameStateResource
var day_limit = 5
var suspicion = 0
var current_day
var day_or_night

# Called when the node enters the scene tree for the first time.
func _ready():
	current_day = game_state.current_day
	day_or_night = game_state.day_or_night
	Dialogic.signal_event.connect(_on_signal_event)
	_change_day_and_night()
	
func _on_signal_event(argument : String):
	match argument:
		"exitHouse":
			_exit_house()
		"sleep":
			_change_day_and_night()

func _get_prefix():
	return day_or_night + str(current_day)

func _change_day_and_night():
	if (day_or_night == "night"):
		current_day += 1
	day_or_night = "night" if day_or_night == "day" else "day"
	var dialog_name = _get_prefix()
	print_debug("changed to " + dialog_name)
	Dialogic.start(dialog_name)
	
func _on_exit_button_pressed():
	if day_or_night == "night":
		Dialogic.start("exitHouse")
	else:
		_exit_house()

func _exit_house():
	get_tree().change_scene_to_file("res://scenes/street/street.tscn")
