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


func _on_ball_scored(goal: String):
	if goal.contains("Player"):
		opponent_score += 1
	else:
		player_score += 1

	$HUD.update_score(player_score, opponent_score)

	new_round()
