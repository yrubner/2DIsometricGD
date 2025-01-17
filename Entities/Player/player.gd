extends CharacterBody2D

const ACCELERATION = 600
const FRICTION = 400
var input = Vector2.ZERO

@export var speed = 70

func _process(delta: float) -> void:
	player_movement(delta)

func diagonal_movement(diagonal):
	var screen_pos = Vector2()
	screen_pos.x = diagonal.x - diagonal.y
	screen_pos.y = (diagonal.x + diagonal.y)
	return screen_pos

func player_movement(delta):
	input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input != Vector2.ZERO:
		velocity = velocity.limit_length(speed)
	
	if input == Vector2.ZERO:
		if velocity.length() > (FRICTION * delta):
			velocity -= velocity.normalized() * (FRICTION * delta)
		else:
			velocity = Vector2.ZERO
	
	#velocity += diagonal_movement(input * ACCELERATION * delta)
	velocity += input * ACCELERATION * delta
	move_and_slide()
