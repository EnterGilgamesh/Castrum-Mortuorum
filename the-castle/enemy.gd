extends CharacterBody2D

func _ready() -> void:
	var target = get_parent().find_child("Player").global_position
	
	if target != null:
		$NavigationAgent2D.target_position = target
		print(target)

func _physics_process(delta: float) -> void:
	pass
