extends Node

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
	Dialogic.Styles.load_style("cust")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _get_prefix():
	return day_or_night + str(current_day)

func _investigate_prompt():
	Dialogic.start("investigate")
	
func _on_signal_event(argument : String):
	match argument:
		"investigate" :
			_investigate()

func _investigate():
	suspicion += 1
	var killed = death_array[current_day - 2] # day 2 corresponds to 1st element
	Dialogic.VAR.killed = killed
	Dialogic.VAR.pronoun = pronoun_map[killed]
	Dialogic.start("investigation" + str(suspicion))
	
func _outside():
	Dialogic.start(_get_prefix() + "Outside")
	
func _obj_dialog(obj : Node):
	var prefix = _get_prefix()
	Dialogic.start(prefix + obj.name)

func _change_day_and_night():
	var dialog_name = _get_prefix()
	Dialogic.start(dialog_name)
	if (day_or_night == "night"):
		current_day += 1
	day_or_night = "night" if day_or_night == "day" else "day"
