extends CanvasLayer


func update_score(player, opponent):
	$PlayerScore.text = str(player)
	$OpponentScore.text = str(opponent)
