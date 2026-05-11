extends Area2D


signal scored(goal: String)


var speed: float
var direction: Vector2 = [Vector2.LEFT, Vector2.RIGHT].pick_random()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = direction * speed

	position += velocity * delta


func start(pos):
	position = pos
	speed = 300.0
	direction = direction.rotated(randf_range(-PI / 3, PI / 3))
	show()


func _on_area_entered(area: Area2D) -> void:
	if area.name.contains("Player"):
		direction = Vector2.RIGHT
	else:
		direction = Vector2.LEFT

	scored.emit(area.name)


func _on_body_entered(body: Node2D) -> void:
	if body.name.contains("Wall"):
		direction.y *= -1
		return

	speed += speed * 0.1
	direction = Vector2.LEFT if direction.x > 0 else Vector2.RIGHT
	direction = direction.rotated(randf_range(-PI / 3, PI / 3))

	$BounceSound.play()
