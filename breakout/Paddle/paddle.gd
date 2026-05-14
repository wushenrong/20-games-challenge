extends CharacterBody2D


@export var speed: float = 600.0


func _ready() -> void:
	hide()


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_collide(velocity * delta)


func start(pos: Vector2):
	position = pos
	show()
