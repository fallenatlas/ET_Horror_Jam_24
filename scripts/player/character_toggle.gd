extends TextureButton

@onready var characters = get_parent()
@onready var select_indicator = $SelectIndicator

@export var character : CharacterState

# Called when the node enters the scene tree for the first time.
func _ready():
	if character.alive:
		texture_normal = character.art
	else:
		set_disabled(true)
		texture_disabled = load("res://assets/question_mark.jpg")
	select_indicator.visible = false


func _on_toggled(toggled_on):
	print("enter")
	print(toggled_on)
	print(characters.number_choices)
	if toggled_on and characters.enough_choices():
		#set_pressed_no_signal(false)
		characters.deselect_others()
		set_pressed_no_signal(true)
		#return
		#print("max choices")
	characters.update_buttons()
	select_indicator.visible = toggled_on

func deselect():
	if button_pressed:
		set_pressed_no_signal(false)
		select_indicator.visible = false
