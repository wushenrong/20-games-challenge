extends Node


const COLUMNS: int = 16
const ROWS: PackedColorArray = [
	Color.RED,
	Color.ORANGE_RED,
	Color.ORANGE,
	Color.YELLOW,
	Color.GREEN,
	Color.BLUE,
	Color.BLUE_VIOLET,
	Color.VIOLET,
]
const SAVE_FILE: String = "user://score.save"


@export var brick_scene: PackedScene
var score: int
var best_score: int = 0
var lives: int


func _ready() -> void:
	load_score()
	$HUD.update_best_score(best_score)


func _on_miss_area_body_entered(_body: Node2D) -> void:
	lives -= 1

	$HUD.update_lives(lives)
	$Paddle.hide()
	$Ball.hide()

	if lives:
		new_round()
	else:
		$HUD.show_game_over()
		save_score()


func _on_ball_brick_hit() -> void:
	score += 1

	$HUD.update_score(score)

	if score > best_score:
		best_score = score
		$HUD.update_best_score(best_score)


func new_game():
	score = 0
	lives = 3

	get_tree().call_group("bricks", "queue_free")

	$HUD.update_score(score)
	$HUD.update_lives(lives)

	for row in ROWS.size():
		for col in range(COLUMNS):
			var brick := brick_scene.instantiate()

			brick.position = Vector2(125 + (col * 55), 124 + (row * 30))
			brick.set_brick_color(ROWS[row])

			add_child(brick)

	new_round()


func new_round():
	$HUD.show_message("Ready")
	await $HUD/MessageTimer.timeout

	$Paddle.start($PaddleStartLocation.position)
	$Ball.start($BallStartLocation.position)


func save_score():
	var save_dict := {"score": best_score}
	var json_string = JSON.stringify(save_dict)
	var save_file := FileAccess.open(SAVE_FILE, FileAccess.WRITE)

	save_file.store_line(json_string)


func load_score():
	if not FileAccess.file_exists(SAVE_FILE):
		return

	var save_file := FileAccess.open(SAVE_FILE, FileAccess.READ)
	var json_string := save_file.get_line()
	var json := JSON.new()

	var parse_result := json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())

	best_score = json.data["score"]
