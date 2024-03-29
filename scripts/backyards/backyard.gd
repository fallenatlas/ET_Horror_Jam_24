extends Node2D

@export var info : Backyard_Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	#play dialog if first time
	if info.first_time:
		var dialog_name = info.owner + "House"
		Dialogic.start(dialog_name)
		info.first_time = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/street/street.tscn")
