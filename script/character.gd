extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -800.0

@export var max_jump = 2
var jump

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump > 0:
		velocity.y = JUMP_VELOCITY * -1
		jump -= 1
	
	if is_on_floor():
		jump = max_jump
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
