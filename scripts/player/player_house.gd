extends Node2D

@onready var characters = $Characters
@onready var objects = $Objects

@export var game_state : GameStateResource
@export var other : Array[Backyard_Resource]

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug(game_state.day_or_night + str(game_state.current_day))
	Dialogic.signal_event.connect(_on_signal_event)
	
func _on_signal_event(argument : String):
	match argument:
		"changeDay":
			_on_exit_button_pressed()
		"endGame":
			get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func _on_call_button_pressed():
	if characters.right_choices() and objects.right_choices():
		Dialogic.start("goodAccusation")
	elif not characters.enough_choices():
		Dialogic.start("needSuspect")
	elif objects.no_choices():
		Dialogic.start("needEvidence")
	else:
		Dialogic.start("falseAccusation")

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/player/player_house_view.tscn")
