extends Control

@onready var ct : TextureButton = $CTToggle
@onready var couple : TextureButton = $CoupleToggle
@onready var karen : TextureButton = $KarenToggle
@onready var nra : TextureButton = $NRAToggle
@onready var astronaut : TextureButton = $AstronautToggle

@onready var correct_characters : Array = [couple]
@onready var wrong_characters : Array = [ct, karen, nra, astronaut]

var number_choices : int = 0
var choices_correct : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	update_buttons()

func update_buttons():
	number_choices = 0
	choices_correct = true
	for o in wrong_characters:
		choices_correct = choices_correct and not o.button_pressed
		number_choices += 1 if o.button_pressed else 0
	for o in correct_characters:
		choices_correct = choices_correct and o.button_pressed
		number_choices += 1 if o.button_pressed else 0
	
	choices_correct = choices_correct and enough_choices()

func right_choices() -> bool:
	return choices_correct

func enough_choices() -> bool:
	return number_choices == correct_characters.size()
	
func deselect_others() -> void:
	for o in wrong_characters:
		o.deselect()
	for o in correct_characters:
		o.deselect()
