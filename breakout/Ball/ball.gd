extends CharacterBody2D

signal brick_hit


var speed: float
var direction: Vector2


func _ready() -> void:
	hide()


func _physics_process(delta: float) -> void:
	velocity = direction * speed

	var collision := move_and_collide(velocity * delta)

	if collision:
		var normal := collision.get_normal()
		var collider := collision.get_collider() as PhysicsBody2D

		if not collider:
			return

		if collider.is_in_group("paddle"):
			direction = normal.rotated(randf_range(-PI / 3, PI / 3))
		elif normal.y:
			direction.y *= -1
		elif normal.x:
			direction.x *= -1

		# if collider.is_in_group("ceiling"):
		# 	ceiling_hit.emit()

		if collider.is_in_group("bricks"):
			speed += 10
			brick_hit.emit()
			collider.queue_free()

		$BounceSound.play()


func start(pos: Vector2):
	position = pos
	speed = 300.0
	direction = Vector2.DOWN
	show()
