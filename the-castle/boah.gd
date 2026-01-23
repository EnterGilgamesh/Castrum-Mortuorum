extends CharacterBody2D

const max_speed: float = 25
const hiding_cooldown: float = 1.5
const hiding_colour: Color = Color(0.70, 0.85, 1, 0.25)

@export var target: Node2D

var current_max_speed = max_speed
var hiding: bool = true

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var pathfind_timer: Timer = $PathfindCooldown
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	# Add effects for hiding mode on spawn
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", hiding_colour, 0)

func _physics_process(_delta: float) -> void:
	if target != null:
		movement()
	
	move_and_slide()

func find_path():
	nav_agent.target_position = target.global_position

func movement():
	var direction = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = direction * current_max_speed
	
	# Animate
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
	if direction == Vector2.ZERO:
		sprite.play("idle")
		# Add effects for hiding mode
		if hiding == false:
			hiding = true
			await get_tree().create_timer(hiding_cooldown).timeout
			var tween = create_tween()
			tween.tween_property(sprite, "modulate", hiding_colour, 0)
	else:
		sprite.play("chase")
		# Remove effects for hiding mode
		if hiding == true:
			hiding = false
			var tween = create_tween()
			tween.tween_property(sprite, "modulate", Color.WHITE, hiding_cooldown / 4)

func _on_pathfind_cooldown_timeout() -> void:
	if target != null:
		find_path()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body == target:
		if pathfind_timer.is_stopped():
			pathfind_timer.start()
