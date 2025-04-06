extends Marker2D

signal puzzle_solved
signal puzzle_failed

@export var target_score: int

var score: int = 0

func increase_score() -> void:
	score += 1
	check_score()

func decrease_score() -> void:
	score -= 1
	check_score()

func check_score() -> void:
	if score >= target_score:
		puzzle_solved.emit()
	else:
		puzzle_failed.emit()
