extends Node

const DEFAULT_SCORE: int = 100

var _level_scores: Dictionary = {}
var _level_selected: int = 0
var _attempts: int = 0
var _cups_hit: int = 0
var _target_cups: int = 0

func check_and_add(level:int) -> void:
	if _level_scores.has(level) == false:
		_level_scores[level]=DEFAULT_SCORE

func level_selected(level: int) -> void:
	check_and_add(level)
	_level_selected = level
	_attempts = 0
	_cups_hit = 0
	
func get_best_for_level(level:int) -> int:
	check_and_add(level)
	return _level_scores[level]

func get_attempts() -> int:
	return _attempts

func get_level_selected() -> int:
	return _level_selected

func set_target_cups(t:int)->void:
	_target_cups=t

func attempt_made()->void:
	_attempts+=1
	SignalManager.on_attempt_made.emit()

func check_game_over() -> bool:
	if _cups_hit >= _target_cups:
		#print("GAME OVER", _level_scores)

		if _level_scores[_level_selected] > _attempts:
			_level_scores[_level_selected] = _attempts
			#print("Record set", _level_scores)
		return true
	return false

func on_cup_destroyed() -> void:
	_cups_hit+=1
	#print("on_cup_destroyed")
	if check_game_over() == true:
		SignalManager.on_game_over.emit()


