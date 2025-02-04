extends CanvasLayer

##################################################
var player_score_label: Label
# 플레이어 점수 라벨
var computer_score_label: Label
# 컴퓨터 점수 라벨
var player_score: int = 0
# 중복 설정을 막기 위한 플레이어 점수 지역 변수
var computer_score: int = 0
# 중복 설정을 막기 위한 컴퓨터 점수 지역 변수

##################################################
func _ready() -> void:
	player_score_label = $PlayerScoreLabel
	computer_score_label = $ComputerScoreLabel
	# 플레이어 점수와 컴퓨터 점수 설정

##################################################
func _process(delta: float) -> void:
	if not player_score == GM.get_score(true) or not computer_score == GM.get_score(false):
	# 플레이어 점수나 컴퓨터 점수 중 하나라도 각 지역 변수와 동일하지 않다면
		player_score = GM.get_score(true)
		computer_score = GM.get_score(false)
		# GM에서 각 점수를 받아옴
		
		player_score_label.text = str(player_score)
		computer_score_label.text = str(computer_score)
		# 각 라벨에 점수를 설정
