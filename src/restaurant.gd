extends Node2D

var plates = []
var customers = []
const MAX_CUSTOMERS = 4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_plate()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func update_plate() -> void:
	SaveManager.game_data.num_plate = 2
	
	# 기존 플레이트들 제거
	for plate in plates:
		plate.queue_free()
	plates.clear()
	
	# 새로운 플레이트들 생성
	for i in range(SaveManager.game_data.num_plate):
		var plate = load("res://src/plate.tscn").instantiate()
		
		# 위치 설정 (여러 개일 경우 겹치지 않게)
		var offset = Vector2(i * 128, 0) # 예: x축으로 60픽셀 간격으로 배치
		plate.position = $Marker2D.position + offset
		
		# 씬 트리에 추가
		add_child(plate)
		plates.append(plate)
		
		if SaveManager.game_data.ready_food.size() > i: # ready_food가 충분한 경우에만 음식 생성
			var ingredients = SaveManager.game_data.ready_food[i]
			for entity in ingredients:
				var sprite = Sprite2D.new()
				sprite.texture = entity.texture
				# 텍스처 크기의 절반만큼 밑 오른쪽으로 위치 조정
				var texture_size = entity.texture.get_size()
				sprite.position = Vector2(texture_size.x / 2, texture_size.y / 2)
				plate.add_child(sprite)


func _on_spawn_timer_timeout() -> void:
	# 현재 손님 수가 최대 손님 수보다 적을 때만 새 손님 생성
	if customers.size() < MAX_CUSTOMERS:
		var customer = load("res://src/customer.tscn").instantiate()
		
		# 손님에게 고유한 자리 할당 (의자 위치에 따라 다른 경로 사용)
		var chair_index = customers.size()
		match chair_index:
			0:
				customer.get_node("Path2D").curve = load("res://assets/walk_path1.tres")
			1:
				customer.get_node("Path2D").curve = load("res://assets/walk_path2.tres")
			2:
				customer.get_node("Path2D").curve = load("res://assets/walk_path3.tres")
			3:
				customer.get_node("Path2D").curve = load("res://assets/walk_path4.tres")
		
		add_child(customer)
		customers.append(customer)
		print("새 손님 입장! 현재 손님 수: ", customers.size())
	else:
		print("최대 손님 수 도달! 현재 손님 수: ", customers.size())

# 손님이 씬에서 제거될 때 호출되는 함수
func _on_customer_exiting(customer: Node) -> void:
	if customer in customers:
		customers.erase(customer)
		print("손님이 떠났습니다! 현재 손님 수: ", customers.size())
