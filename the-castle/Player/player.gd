extends CharacterBody2D

const max_speed: float = 80
const acceleration: float = 5
const friction: float = 16

@export var current_max_speed: float = max_speed

func _physics_process(delta: float) -> void:
	movement(delta)
	
	move_and_slide()

func movement(delta):
	var input_direction = Vector2(Input.get_axis("Move Left", "Move Right"), Input.get_axis("Move Up", "Move Down"))
	var lerp_time = delta * (acceleration if input_direction else friction)
	
	velocity = lerp(velocity, input_direction.normalized() * current_max_speed, lerp_time)
	animate(input_direction)

func animate(input_direction):
	if input_direction.x == 1.0:
		$AnimatedSprite2D.flip_h = false
	elif input_direction.x == -1:
		$AnimatedSprite2D.flip_h = true
	if input_direction == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("run")
