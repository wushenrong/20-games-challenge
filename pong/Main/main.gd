extends Node


var player_score = 0
var opponent_score = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_round()


func new_round():
	$PlayerPaddle.start($PlayerStartLocation.position)
	$OpponentPaddle.start($OpponentStartLocation.position)
	$Ball.start($BallStartLocation.position)


func _on_player_goal_body_entered(_body: Node2D) -> void:
	score("player")


func _on_opponent_goal_body_entered(_body: Node2D) -> void:
	score("opponent")


func score(goal: String):
	if goal == "player":
		opponent_score += 1
		$Ball.direction = Vector2.RIGHT
	else:
		player_score += 1
		$Ball.direction = Vector2.LEFT

	$HUD.update_score(player_score, opponent_score)

	new_round()
