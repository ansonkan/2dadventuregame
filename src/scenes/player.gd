extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $Visuals/AnimatedSprite2D
@onready var visuals: Node2D = $Visuals

const MAX_SPEED = 50
const acceleration = 400
const friction = 350

var is_jumping = false

func _ready() -> void:
	animated_sprite_2d.animation_finished.connect(on_animation_finished)

func _process(_delta: float) -> void:
	update_animation()
		

func _physics_process(delta: float) -> void:
	move_player(delta)
	

func move_player(delta: float) -> void:
	var input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input:
		velocity = velocity.move_toward(input * MAX_SPEED, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	if velocity:
		if velocity.x > 0:
			animated_sprite_2d.flip_h = false
		elif velocity.x < 0:
			animated_sprite_2d.flip_h = true

	move_and_slide()


func update_animation() -> void:
	if !is_jumping && Input.is_action_pressed("ui_select"):
		is_jumping = true
		animated_sprite_2d.play("jump")
		
	if !is_jumping:
		if velocity:
			animated_sprite_2d.play("walk")
		else:
			animated_sprite_2d.play("idle")
			
	if is_jumping:
		visuals.position = Vector2(0, -10)
	else:
		visuals.position = Vector2(0, 0)


func on_animation_finished() -> void:
	if is_jumping:
		is_jumping = false
		print("is_jumping = ", is_jumping)
