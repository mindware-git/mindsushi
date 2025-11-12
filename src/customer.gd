extends Node2D

@export var type: int = 0
@export var seat: int = 0

enum CustomerState {
	WALKING_TO_SEAT,
	WAITING,
	EATING,
	LEAVING,
}

var eating_time: float = 10.0 # 식사 시간 (초)
var max_order: int = 2
var num_ordered: int = 0 # 주문한 음식 개수


var walk_speed: float = 50.0
var current_state: CustomerState = CustomerState.WALKING_TO_SEAT
var satisfaction: int = 100 # 만족도 (0-100)

func _ready() -> void:
	match type:
		1:
			$CharacterBody2D/AnimatedSprite2D.animation = "1"
			walk_speed = 60.0

		2:
			$CharacterBody2D/AnimatedSprite2D.animation = "2"
			walk_speed = 70.0

		
	$CharacterBody2D/AnimatedSprite2D.play()
	$CharacterBody2D/Order/WantFood.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match current_state:
		CustomerState.WALKING_TO_SEAT:
			_update_walking_to_seat(delta)
		CustomerState.LEAVING:
			_update_leaving(delta)

func _wait_food() -> void:
	current_state = CustomerState.WAITING
	print("I want to eat sushi!")

	$CharacterBody2D/Order/WantFood.show()
	$WaitTimer.wait_time = 13.0
	$WaitTimer.start()

func _update_walking_to_seat(delta: float) -> void:
	var path_follow = $Path2D/PathFollow2D
	var path = $Path2D
	path_follow.progress += walk_speed * delta
	
	# 캐릭터 위치를 PathFollow2D 위치로 업데이트
	$CharacterBody2D.global_position = path_follow.global_position
	
	# 경로 끝에 도착했는지 확인
	if path_follow.progress >= path.curve.get_baked_length():
		_wait_food()

func _update_leaving(_delta: float) -> void:
	$CharacterBody2D/Order/WantFood.hide()
	var path_follow = $Path2D/PathFollow2D
	path_follow.progress -= walk_speed * _delta
	
	# 캐릭터 위치를 PathFollow2D 위치로 업데이트
	$CharacterBody2D.global_position = path_follow.global_position
	
	# 경로 시작점에 도착했는지 확인
	if path_follow.progress <= 0:
		print("I'm done")
		print(satisfaction)
		
		# 부모 노드에 _on_customer_exiting 함수가 있으면 호출
		if get_parent() and get_parent().has_method("_on_customer_exiting"):
			get_parent()._on_customer_exiting(self)
		
		SaveManager.game_data.total_satisfaction += satisfaction
		SaveManager.game_data.num_customer += 1
		
		queue_free()

func _on_wait_timer_timeout() -> void:
	if current_state == CustomerState.WAITING:
		print("I'm angry! No food!")
		satisfaction -= 50
		current_state = CustomerState.LEAVING
	elif current_state == CustomerState.EATING:
		# next food
		if num_ordered < max_order:
			_wait_food()
		else:
			print("I'm full, I'm leaving now.")
			current_state = CustomerState.LEAVING

func _take_food() -> void:
	print("Thank you for the food!")

	$CharacterBody2D/Order/WantFood.hide()
	satisfaction += 20
	$WaitTimer.stop() # 대기 타이머 중단

	num_ordered += 1

	current_state = CustomerState.EATING
	$WaitTimer.wait_time = eating_time
	$WaitTimer.start()
