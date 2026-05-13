extends CharacterBody2D


@export var speed: float = 600.0


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("opponent_move_up", "opponent_move_down")

	if direction:
		velocity.y = direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_collide(velocity * delta)


func start(pos: Vector2):
	position = pos
