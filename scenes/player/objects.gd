extends Control

@onready var scales : TextureButton = $ScalesToggle
@onready var space_rock : TextureButton = $SpaceRockToggle
@onready var drawing : TextureButton = $DrawingToggle
@onready var rocket : TextureButton = $RocketToggle
@onready var fur : TextureButton = $FurToggle
@onready var rat_poison : TextureButton = $RatPoisonToggle
@onready var newspaper : TextureButton = $NewspaperToggle
@onready var ovni_photo : TextureButton = $OvniPhotoToggle
@onready var goo : TextureButton = $GooToggle
@onready var painting : TextureButton = $PaintingToggle
@onready var metal : TextureButton = $MetalToggle

@onready var correct_objects : Array = [metal, goo, painting]
@onready var wrong_objects : Array = [scales, space_rock, drawing, rocket, fur, rat_poison, newspaper, ovni_photo]

var number_choices : int = 0
var choices_correct : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	update_buttons()

func update_buttons():
	number_choices = 0
	choices_correct = true
	for o in wrong_objects:
		choices_correct = choices_correct and not o.button_pressed
		number_choices += 1 if o.button_pressed else 0
	for o in correct_objects:
		choices_correct = choices_correct and o.button_pressed
		number_choices += 1 if o.button_pressed else 0
	
	choices_correct = choices_correct and enough_choices()

func right_choices() -> bool:
	return choices_correct

func no_choices() -> bool:
	return number_choices == 0

func enough_choices() -> bool:
	return number_choices == correct_objects.size()
