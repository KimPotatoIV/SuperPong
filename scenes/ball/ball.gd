extends RigidBody2D

##################################################
const SCREEN_SIZE: Vector2 = Vector2(640.0, 360.0)
# 화면 크기
const INIT_BALL_SPEED: float = 200.0
# 공 초기 속도
const BALL_SPEED_MUL: float = 1.1
# 패들에 부딪힐 때마다 증가되는 공 속도 비율
const PADDLE_OFFSET_SCALE: float = 200.0
# 패들에 부딪힐 때 반사각 확대 비율

var ball_speed: float = INIT_BALL_SPEED
# 공 속도. 공 초기 속도로 설정
var velocity: Vector2 = Vector2()
# 공 움직임 방향과 속도 벡터

##################################################
func _ready() -> void:
	gravity_scale = 0.0
	# 중력 제거
	continuous_cd = CCD_MODE_CAST_RAY
	# 패들을 뚫고 지나가는 경우를 없애기 위함. 충돌 연산이 더 정밀해짐
	
	connect("body_entered", Callable(self, "_on_body_entered"))
	# body_entered 시 _on_body_entered 함수와 연결

##################################################
func _process(delta: float) -> void:
	if GM.get_game_playing():
	# 게임 플레이 중일 때
		if global_position.x < 0:
		# 공이 좌측 화면 밖으로 나가면
			GM.set_game_playing(false)
			# 게임 플레이 중이 아니도록 설정하고
			GM.set_score(GM.get_score(false) + 1, false)
			# 점수를 1점 올림
			SM.out_audio_play()
			# 게임 종료 오디오 재생
		elif global_position.x > SCREEN_SIZE.x:
		# 공이 우측 화면 밖으로 나가면
			GM.set_game_playing(false)
			# 게임 플레이 중이 아니도록 설정하고
			GM.set_score(GM.get_score(true) + 1, true)
			# 점수를 1점 올림
			SM.out_audio_play()
			# 게임 종료 오디오 재생
	else:
	# 게임 플레이 중이 아닐 때
		global_position = SCREEN_SIZE / 2
		# 공의 위치를 화면 중앙으로 초기화
		ball_speed = INIT_BALL_SPEED
		# 공의 속도를 INIT_BALL_SPEED로 초기화
		velocity = Vector2(-1, 0) * ball_speed
		# velocity를 플레이어 쪽으로 움직이도록 초기화
		linear_velocity = velocity
		# velocity 적용
		GM.set_game_playing(true)
		# 게임 플레이 중으로 설정

##################################################
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Paddle"):
	# 충돌 그룹이 Paddle일 때
		ball_speed *= BALL_SPEED_MUL
		# 공 속도를 BALL_SPEED_MUL만큼 증가 시킴
		
		var offset: float = global_position.y - body.global_position.y
		# 패들과 공의 좌표 차이를 offset으로 저장
		var normalized_offset: float = offset / GM.get_paddle_height()
		# offset을 정규화
		var reflection_vector: Vector2 = \
		Vector2(velocity.x * -1, normalized_offset * PADDLE_OFFSET_SCALE).normalized()
		# normalized_offset * PADDLE_OFFSET_SCALE만큼 반사각 설정
		
		velocity = reflection_vector * ball_speed
		# velocity에 적용
		linear_velocity = velocity
		# velocity 적용
	elif body.is_in_group("Wall"):
	# 충돌 그룹이 Wall일 때
		velocity.y *= -1
		# y 좌표로 반사
		linear_velocity = velocity
		# velocity 적용
	
	SM.hit_audio_play()
	# 패들이나 벽에 충돌하는 오디오 재생
