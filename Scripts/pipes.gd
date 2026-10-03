extends Node2D

var speed = 150


func _process(delta: float) -> void:
	position.x -= speed * delta


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		ScoreManager.add_point()


func _on_screen_exited() -> void:
	queue_free()
