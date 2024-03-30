extends CharacterBody2D

const SPEED = 400.0
const JUMP_VELOCITY = -400.0

var move_on_y : bool = true
var disable_movement : bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation : AnimatedSprite2D = get_node("AnimatedSprite2D")

func _on_ready():
	animation.play("Idle")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if disable_movement: return
	
	var is_moving_x = handle_x_movement()
	var is_moving_y = false
	if move_on_y:
		is_moving_y = handle_y_movement()
		
	if not is_moving_x and not is_moving_y:
		animation.play("Idle")

	move_and_slide()

func handle_x_movement() -> bool:
	var direction_x = Input.get_axis("move_left", "move_right")
	if direction_x:
		velocity.x = direction_x * SPEED
		animation.play("Walk")
		if velocity.x < 0:
			animation.flip_h = true
		else:
			animation.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	return direction_x != 0

func handle_y_movement() -> bool:
	var direction_y = Input.get_axis("move_foward", "move_backward")
	if direction_y:
		velocity.y = direction_y * SPEED
		animation.play("Walk")
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	return direction_y != 0
	
func disable_y_movement():
	move_on_y = false
	
func disable_player():
	disable_movement = true
	animation.visible = false
	
func enable_player():
	disable_movement = false
	animation.visible = true
