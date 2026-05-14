extends CanvasLayer


signal start_game


func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	$Message.hide()


func update_score(score: int) -> void:
	$ScoreLabel.text = str(score)


func update_best_score(best_score: int) -> void:
	$BestScoreLabel.text = str(best_score)


func update_lives(lives: int) -> void:
	$LivesLabel.text = str(lives)


func show_message(msg: String) -> void:
	$Message.text = msg
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")

	await $MessageTimer.timeout

	$Message.text = "Breakout!"
	$Message.show()

	await get_tree().create_timer(1.0).timeout

	$StartButton.show()
