extends Control

@onready var rice_timer = $RiceButton/Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_rice_button_pressed() -> void:
	print("rice pressed")
	rice_timer.start()

func _on_rice_button_released() -> void:
	print("rice released")
	var pressed_time = rice_timer.wait_time - rice_timer.time_left
	rice_timer.stop()
	print("pressed time: ", pressed_time)
	
	# 스시 씬 생성
	var sushi_instance = load("res://src/sushi.tscn").instantiate()
	sushi_instance.rice_amount = pressed_time # pressed_time 변수 전달
	add_child(sushi_instance) # CanvasLayer에 추가
	sushi_instance.position = Vector2(100, 200) # ChefNode 기준 적절한 위치


func _on_timer_timeout() -> void:
	print("Too long hold rice")


func _on_serving_button_pressed() -> void:
	var rice: Ingredient = load("res://src/entity/rice.tres")
	SaveManager.game_data.ready_food.append([rice])
	print("Ready food: ", SaveManager.game_data.ready_food)
