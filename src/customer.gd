extends Node2D

enum CustomerState {
	WALKING_TO_SEAT,
	WAITING,
	LEAVING,
}

var walk_speed: float = 50.0
var current_state: CustomerState = CustomerState.WALKING_TO_SEAT
var satisfaction: float = 100.0 # 만족도 (0-100)

func _ready() -> void:
	$CharacterBody2D/AnimatedSprite2D.play()
	$Path2D.curve = load("res://assets/walk_path.tres")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	match current_state:
		CustomerState.WALKING_TO_SEAT:
			_update_walking_to_seat(_delta)
		CustomerState.LEAVING:
			_update_leaving(_delta)

func _update_walking_to_seat(_delta: float) -> void:
	var path_follow = $Path2D/PathFollow2D
	var path = $Path2D
	path_follow.progress += walk_speed * _delta
	
	# 캐릭터 위치를 PathFollow2D 위치로 업데이트
	$CharacterBody2D.global_position = path_follow.global_position
	
	# 경로 끝에 도착했는지 확인
	if path_follow.progress >= path.curve.get_baked_length():
		current_state = CustomerState.WAITING
		print("손님이 자리에 도착하여 WAITING 상태로 변경")
		print("I want to eat sushi!")
		# 3초 타이머 시작
		$WaitTimer.wait_time = 13.0
		$WaitTimer.start()

func _update_leaving(_delta: float) -> void:
	var path_follow = $Path2D/PathFollow2D
	path_follow.progress -= walk_speed * _delta
	
	# 캐릭터 위치를 PathFollow2D 위치로 업데이트
	$CharacterBody2D.global_position = path_follow.global_position
	
	# 경로 시작점에 도착했는지 확인
	if path_follow.progress <= 0:
		print("I'm done")
		print(satisfaction)
		queue_free()


func _on_wait_timer_timeout() -> void:
	print("I'm angry! No food!")
	satisfaction -= 50
	current_state = CustomerState.LEAVING

func _take_food() -> void:
	print("Thank you for the food!")
	satisfaction += 20
	$WaitTimer.stop() # 대기 타이머 중단
	current_state = CustomerState.LEAVING
