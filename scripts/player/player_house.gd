extends Node2D

@onready var characters = $Characters
@onready var objects = $Objects

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_call_button_pressed():
	if characters.right_choices() and objects.right_choices():
		print("well done")
	elif not characters.enough_choices():
		print("choose a suspect")
	elif not objects.enough_choices():
		print("not enouth evidence")
	else:
		print("rip")

func _on_exit_button_pressed():
	pass # Replace with function body.
	#go to next day/night...
	#probably change something, maybe game_manager.next_scene()
	get_tree().change_scene_to_file("res://scenes/player/player_house_view.tscn")
