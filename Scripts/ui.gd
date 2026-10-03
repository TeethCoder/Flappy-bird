extends Control


signal start_game


@onready var high_score_label: Label = $MarginContainer/HighScoreLabel
@onready var play_label: Label = $PlayLabel
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var game_over_label: Label = $MarginContainer/GameOverLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_labels()
	game_over_label.hide()
	connect_signals()


func _unhandled_input(event: InputEvent) -> void:
	if play_label.visible and event.is_action_pressed("jump"):
		play_label.hide()
		game_over_label.hide()
		high_score_label.hide()
		start_game.emit()

	if game_over_label.visible and event.is_action_pressed("jump"):
		get_tree().paused = false
		get_tree().reload_current_scene()


func connect_signals():
	ScoreManager.score_changed.connect(update_score_label)
	ScoreManager.high_score_changed.connect(update_high_score)


func update_score_label(new_score : int):
	score_label.text = "SCORE: " + str(new_score)


func update_high_score(new_score : int):
	high_score_label.text = "HIGHEST SCORE: " + str(new_score)


func update_labels():
	high_score_label.text = "HIGHEST SCORE: " + str(ScoreManager.high_score)


func show_gameover():
	game_over_label.show()
	high_score_label.show()
