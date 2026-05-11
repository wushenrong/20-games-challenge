extends CharacterBody2D


@export var speed: float = 600.0
var direction: Vector2


func _process(_delta: float) -> void:
	direction = Vector2.ZERO

	if Input.is_action_pressed("player_move_down"):
		direction.y += 1

	if Input.is_action_pressed("player_move_up"):
		direction.y -= 1


func _physics_process(delta: float) -> void:
	velocity = direction * speed

	move_and_collide(velocity * delta)


func start(pos):
	position = pos
