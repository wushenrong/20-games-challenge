extends CharacterBody2D


var speed: float
var direction: Vector2 = [Vector2.LEFT, Vector2.RIGHT].pick_random()


func _physics_process(delta: float) -> void:
	velocity = direction * speed

	var collision = move_and_collide(velocity * delta)

	if collision:
		var normal = collision.get_normal()

		if collision.get_collider().is_in_group("paddles"):
			if not normal.y:
				direction = collision.get_normal()
				direction = direction.rotated(randf_range(-PI / 3, PI / 3))
				speed += speed * 0.1
			else:
				direction.x *= -1

		if normal.y:
			direction.y *= -1

		$BounceSound.play()


func start(pos):
	position = pos
	speed = 300.0
	direction = direction.rotated(randf_range(-PI / 3, PI / 3))
