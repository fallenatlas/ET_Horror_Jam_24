extends TextureButton

@onready var objects = get_parent()
@onready var select_indicator = $SelectIndicator
@onready var question_mark = $Label

@export var object : InteractableObject #resource

# Called when the node enters the scene tree for the first time.
func _ready():
	if object.found:
		texture_normal = object.art
	else:
		set_disabled(true)
		#texture_disabled = load("res://assets/question_mark.jpg")
		question_mark.visible = true
		
	select_indicator.visible = false

func _on_toggled(toggled_on):
	if toggled_on and objects.enough_choices():
		set_pressed_no_signal(false)
		return
		print("max choices")
	objects.update_buttons()
	select_indicator.visible = toggled_on
	
