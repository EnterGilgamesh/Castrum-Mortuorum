extends CharacterBody2D

const max_speed: int = 80
const acceleration: int = 5
const friction: int = 8

func _physics_process(delta: float) -> void:
	var Input = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	var lerp_weight = delta * (acceleration if Input else friction)
	velocity = lerp(velocity, Input * max_speed, lerp_weight)
	
	move_and_slide()
