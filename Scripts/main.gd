extends Node


@export var pipes_scene : PackedScene
@onready var spawn_upper: Marker2D = $Upper
@onready var spawn_lower: Marker2D = $Lower
@onready var pipe_holder: Node = $PipeHolder
@onready var spawn_timer: Timer = $SpawnTimer
@onready var player: Player = $Player


func _ready() -> void:
	ScoreManager.load_file()
	SignalManager.hit.connect(game_over)


func _on_spawn_timer_timeout() -> void:
	spawn_pipes()


func spawn_pipes():
	var new_pipe = pipes_scene.instantiate()
	var x_pos = spawn_upper.position.x
	var y_pos = randf_range(spawn_upper.position.y, spawn_lower.position.y)
	new_pipe.position = Vector2(x_pos, y_pos)
	pipe_holder.add_child(new_pipe)


func new_game():
	ScoreManager.reset_score()
	spawn_pipes()
	spawn_timer.start()
	player.enable_physics()


func game_over():
	ScoreManager.save_file()
	spawn_timer.stop()
	$UI.show_gameover()
	get_tree().paused = true
