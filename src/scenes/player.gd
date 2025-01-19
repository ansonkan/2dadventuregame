extends CharacterBody2D

const MAX_SPEED = 70
const acceleration = 550
const friction = 400

var input = Vector2.ZERO


func _physics_process(delta: float) -> void:
	move_player(delta)
	

func move_player(delta: float) -> void:
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input:
		velocity = velocity.move_toward(input * MAX_SPEED, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_slide()
