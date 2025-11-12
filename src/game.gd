extends Node2D

@onready var time_label = $CanvasLayer/HBoxContainer/TimeLabel
@onready var money_label = $CanvasLayer/HBoxContainer/MoneyLabel
@onready var rate_label = $CanvasLayer/HBoxContainer/RateLabel
@onready var debug_label = $CanvasLayer/HBoxContainer/DebugLabel

@onready var restaurant = $Restaurant
@onready var cook = $Cook

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.is_debug_build():
		debug_label.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if SaveManager.game_data.money > 1000 or SaveManager.game_data.money < 0:
		print("Game over money: " + str(SaveManager.game_data.money))
		get_tree().change_scene_to_file("res://src/ending.tscn")


func _on_timer_timeout() -> void:
	SaveManager.game_data.running_time += 1
	time_label.text = str(SaveManager.game_data.running_time)
	money_label.text = str(SaveManager.game_data.money)
	rate_label.text = str(SaveManager.game_data.total_satisfaction)
	debug_label.text = "num of customers: " + str(SaveManager.game_data.num_customer)

	if SaveManager.game_data.running_time % 100 == 0:
		SaveManager.save_game()
	if SaveManager.game_data.running_time % (60 * 24 * 30) == 0:
		print("Montly pay")
		SaveManager.game_data.money -= 1000

func _on_restaurant_button_pressed() -> void:
	restaurant.show()
	cook.hide()
	$CanvasLayer/RestaurantButton.hide()
	$CanvasLayer/ChefButton.show()
	restaurant.update_plate()

func _on_chef_button_pressed() -> void:
	restaurant.hide()
	cook.show()
	$CanvasLayer/RestaurantButton.show()
	$CanvasLayer/ChefButton.hide()
