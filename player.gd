class_name Player extends CharacterBody2D


@export var speed: float = 300

func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = speed * direction
	move_and_slide()
