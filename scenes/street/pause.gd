extends CanvasLayer

@onready var control = $Control
var paused : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (paused and Input.is_action_just_pressed("pause_key")):
		control.visible = false
		control.process_mode = Node.PROCESS_MODE_DISABLED
		paused = false
	elif (not paused and Input.is_action_just_pressed("pause_key")):
		control.visible = true
		control.process_mode = Node.PROCESS_MODE_INHERIT
		paused = true

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func _on_exit_button_pressed():
	get_tree().quit()
