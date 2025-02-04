extends Node

##################################################
var paddle_height: float
# 패들 높이. paddle.gd에서 설정함
var player_score: int
# 플레이어 점수
var computer_score: int
# 컴퓨터 점수
var game_playing: bool = false
# 게임 중인지 여부

##################################################
func get_paddle_height() -> float:
	return paddle_height

##################################################
func set_paddle_height(value: float) -> void:
	paddle_height = value

##################################################
func get_score(is_player_score: bool) -> int:
	if is_player_score:
		return player_score
	else:
		return computer_score
	# is_player_score에 따라 플레이어 점수와 컴퓨터 점수 반환

##################################################
func set_score(score: int, is_player_score: bool) -> void:
	if is_player_score:
		player_score = score
	else:
		computer_score = score
	# is_player_score에 따라 플레이어 점수와 컴퓨터 점수 설정

##################################################
func get_game_playing() -> bool:
	return game_playing

##################################################
func set_game_playing(value: bool) -> void:
	game_playing = value
