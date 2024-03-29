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
		texture_disabled = load("res://icon.svg")
	select_indicator.visible = false


func _on_toggled(toggled_on):
	if toggled_on and characters.enough_choices():
		set_pressed_no_signal(false)
		return
		print("max choices")
	characters.update_buttons()
	select_indicator.visible = toggled_on
