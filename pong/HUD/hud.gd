extends CanvasLayer


func update_score(player: int, opponent: int):
	$PlayerScore.text = str(player)
	$OpponentScore.text = str(opponent)
