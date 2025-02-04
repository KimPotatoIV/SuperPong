extends CharacterBody2D

##################################################
const SCREEN_SIZE: Vector2 = Vector2(640.0, 360.0)
# 화면 크기

var paddle_speed: float = 200.0
var paddle_x_position: float

##################################################
func _ready() -> void:
	add_to_group("Paddle")
	# Paddle 그룹에 추가
	paddle_x_position = global_position.x
	# paddle_x_position를 현재 좌표로 설정
	
	GM.set_paddle_height($CollisionShape2D.shape.extents.y * 2)
	# 패들 높이 설정

##################################################
func _process(delta: float) -> void:
	position.x = paddle_x_position
	# 공에 튕겨도 좌표 고정을 위함
	
	if not GM.get_game_playing():
	# 게임 플레이 중이 아니라면
		global_position.y = SCREEN_SIZE.y / 2
		# 플레이어 패들을 화면 중앙으로 설정

##################################################
func _physics_process(delta: float) -> void:
	var direction: float = Input.get_axis("ui_up", "ui_down")
	# 위 아래 이동 값을 direction에 설정
	if direction:
	# 이동 값이 0이 아니면
		velocity.y = direction * paddle_speed
		# paddle_speed에 따라 velocity.y를 설정
	else:
	# 이동 값이 0이면
		velocity.y = move_toward(velocity.y, 0, paddle_speed)
		# velocity.y를 move_toward로 서서히 이동
	
	move_and_slide()
	# 물리 이동 처리 적용
