extends Node

@export var game_state : GameStateResource
@export var others : Array[Backyard_Resource]
var day_limit = 5
var suspicion = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug(_get_prefix())
	Dialogic.signal_event.connect(_on_signal_event)
	_change_day_and_night()
	
func _on_signal_event(argument : String):
	match argument:
		"exitHouse":
			_exit_house()
		"sleep":
			_change_day_and_night()

func _get_prefix():
	return game_state.day_or_night + str(game_state.current_day)

func _change_day_and_night():
	if (game_state.day_or_night == "night"):
		game_state.current_day += 1
	game_state.day_or_night = "night" if game_state.day_or_night == "day" else "day"
	print_debug(game_state.day_or_night + str(game_state.current_day))
	var dialog_name = _get_prefix()
	print_debug("changed to " + dialog_name)
	Dialogic.start(dialog_name)
	
func _on_exit_button_pressed():
	if game_state.day_or_night == "night" && game_state.current_day != 1:
		Dialogic.start("exitHouse")
	else:
		_exit_house()

func _exit_house():
	get_tree().change_scene_to_file("res://scenes/street/street.tscn")
