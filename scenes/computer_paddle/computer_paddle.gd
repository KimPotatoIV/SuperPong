extends CharacterBody2D

##################################################
var paddle_speed = 200.0
# 패들 속도
var paddle_x_position: float
# 패들 x 좌표. 공에 튕겨도 좌표 고정을 위함
var ball: Node2D
# 공 노드

##################################################
func _ready() -> void:
	add_to_group("Paddle")
	# Paddle 그룹에 추가
	paddle_x_position = global_position.x
	# paddle_x_position를 현재 좌표로 설정
	
	ball = get_node("../Ball")
	# ball 노드 설정

##################################################
func _process(delta: float) -> void:
	position.x = paddle_x_position
	# 공에 튕겨도 좌표 고정을 위함

##################################################
func _physics_process(delta: float) -> void:
	var ball_position: Vector2 = ball.global_position
	# 실시간 공 좌표
	
	if position.y < ball_position.y:
	# 패들이 공보다 위에 있으면
		position.y = ball_position.y
		# 패들을 공 위치로 설정
	elif position.y > ball_position.y:
	# 패들이 공보다 아래에 있으면
		position.y = ball_position.y
		# 패들을 공 위치로 설정
	
	velocity.y = move_toward(velocity.y, 0, paddle_speed * delta)
	# velocity.y를 move_toward로 서서히 이동
	
	move_and_slide()
	# 물리 이동 처리 적용
