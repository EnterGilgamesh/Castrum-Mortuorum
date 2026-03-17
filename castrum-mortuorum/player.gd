extends CharacterBody2D


@export var speed : float = 6000.0
@export var attack_velocity : float = 3000.0

@export var allow_input : bool = true


func _physics_process(delta: float) -> void:
	var direction = Vector2(Input.get_axis("Move left", "Move right"), Input.get_axis("Move up", "Move down"))
	
	movement(delta, direction)
	#attack(direction, delta)

	move_and_slide()

func movement(delta, direction):
	if allow_input: 
		velocity = direction.normalized() * speed * delta
		
		if direction == Vector2.ZERO:
			$Sprite.play("idle")
		else:
			$Sprite.play("run")
		
		if direction.x == 1:
			$Sprite.flip_h = false
		elif direction.x == -1:
			$Sprite.flip_h = true

func attack(direction, delta):
	if Input.is_action_just_pressed("Attack"):
		$Sprite.play("attack")
		allow_input = false
		velocity += direction * attack_velocity * delta
		await get_tree().create_timer(1).timeout
		allow_input = true
