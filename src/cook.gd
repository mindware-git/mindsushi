extends Control

@onready var rice_timer = $RiceButton/Timer
@onready var rice_progress = $RiceButton/ProgressBar

var sushi_instance: Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rice_progress.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_rice_button_pressed() -> void:
	print("rice pressed")
	rice_timer.start()
	rice_progress.show()

func _on_rice_button_released() -> void:
	print("rice released")
	rice_progress.hide()
	var pressed_time = rice_timer.wait_time - rice_timer.time_left
	rice_timer.stop()
	print("pressed time: ", pressed_time)
	
	# 스시 씬 생성
	sushi_instance = load("res://src/food.tscn").instantiate()
	add_child(sushi_instance)


func _on_timer_timeout() -> void:
	print("Too long hold rice")
