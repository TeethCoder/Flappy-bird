extends Node


signal score_changed(new_score)
signal high_score_changed(new_score)


const CONFIG : String = "user://save2.res"


var score : int = 0:
	get:
		return score
	set(value):
		score = value
		score_changed.emit(score)


var high_score : int = 0:
	get:
		return high_score
	set(value):
		high_score = value
		high_score_changed.emit(high_score)


func _ready() -> void:
	load_file()


func add_point():
	score += 1
	if score > high_score:
		high_score = score


func reset_score():
	score = 0


func save_file():
	var data = {
		"highscore": high_score,
	}

	var file = FileAccess.open(CONFIG, FileAccess.WRITE)
	file.store_var(data)
	file.close()


func load_file():
	if FileAccess.file_exists(CONFIG):
		var file = FileAccess.open(CONFIG, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		if typeof(data) == TYPE_DICTIONARY:
			high_score = data.get("highscore")
	else:
		save_file()
