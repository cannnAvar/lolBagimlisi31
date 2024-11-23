extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -800.0

@export var max_jump = 2
var jump
var is_looking_left = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and jump > 0:
		velocity.y = JUMP_VELOCITY * -1
		jump -= 1
	
	if is_on_floor():
		jump = max_jump
	
	
	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("Left", "Right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	# When input is left look left. When input is right look right 
	# Don't fuck with me 
	if Input.is_action_just_pressed("Left") and is_looking_left == false:
		scale.x *= -1
		is_looking_left = true
	if Input.is_action_just_pressed("Right") and is_looking_left == true:
		scale.x *= -1
		is_looking_left = false

	move_and_slide()
