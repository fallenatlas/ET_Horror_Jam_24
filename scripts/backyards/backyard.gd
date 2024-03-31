extends Node2D

@export var info : Backyard_Resource
@export var others : Array[Backyard_Resource]
@export var state : GameStateResource

# Called when the node enters the scene tree for the first time.
func _ready():
	#play dialog if first time
	if state.current_day == 1:
		if info.first_time_day:
			Dialogic.start(info.owner + "Presentations")
	elif info.first_time:
		var dialog_name = info.owner + "House"
		Dialogic.start(dialog_name)
		info.first_time = false
	if info.first_time_day:
		info.first_time_day = false
		state.visit_number += 1
	if state.day_or_night == "night":
		get_node("DayBackground").visible = false
		get_node("NightBackground").visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/street/street.tscn")
